//
//  M3FileReader.m
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "M3FileReader.h"

char* rev(char* str) {
    char temp;
    
    for (int i = 0; i < 2; i++) {
        temp = str[i];
        str[i] = str[3-i];
        str[3-i] = temp;
    }
    str[4] = '\0';
    
    return str;
}

@implementation M3FileReader

@synthesize verts, meshes;

-(id) initWithFile:(NSString *)fileName {
    self = [super init];
    if (self) {
        FILE *f;
        
        f = fopen([fileName cStringUsingEncoding:NSASCIIStringEncoding], "r");
        
        [self readHeader:f];
        [self readReferenceTable:f];
        [self readModel:f];
        [self readDiv:f];
        
        [self getVertices:f];
        [self getMeshes:f];
        
        
                /*
        for (int i = 0; i < regnEntry.count; i++) {
            for (int j = 0; j < meshes[i].num_verts; j++) {
                NSLog(@"mesh %d, %f, %f, %f", i, meshes[i].vertices[j].x, meshes[i].vertices[j].y, meshes[i].vertices[j].z);
            }
        }
        */
        fclose(f);
    }
    return self;
}

-(void) readHeader:(FILE *)f {
    fread(&header, sizeof(M3Header), 1, f);
}

-(void) readReferenceTable:(FILE *)f {
    referenceTable = malloc(sizeof(M3ReferenceEntry) * header.reference_table_count);
    fseek(f, header.reference_table_offset, SEEK_SET);
    fread(referenceTable, sizeof(M3ReferenceEntry), header.reference_table_count, f);
}

-(void) readModel:(FILE *)f {
    fseek(f, referenceTable[header.model_index].offset, SEEK_SET);
    fread(&model, sizeof(M3MODL23), 1, f);
}

-(void) readDiv:(FILE *)f {
    M3ReferenceEntry divEntry = [self getEntryFromReference:model.ref_div];
    fseek(f, divEntry.offset, SEEK_SET);
    fread(&div, sizeof(M3Div), divEntry.count, f);
}

-(void) getVertices:(FILE *)f {
    M3ReferenceEntry vertexEntry = [self getEntryFromReference:model.ref_vertexReference];
    int num_vertices = vertexEntry.count / 32;

    fseek(f, vertexEntry.offset, SEEK_SET);
    M3Vertex *vertices = malloc(sizeof(M3Vertex)*num_vertices);
    verts = malloc(sizeof(GLKVector3)*num_vertices);
    fread(vertices, sizeof(M3Vertex), num_vertices, f);
    
    for (int i = 0; i < num_vertices; i++) {
        verts[i] = GLKVector3Make(vertices[i].position.x, vertices[i].position.y, vertices[i].position.z);
    }
    free(vertices);
}

-(void) getMeshes:(FILE *)f {
    M3ReferenceEntry faceEntry = [self getEntryFromReference:div.faces];
    M3ReferenceEntry batEntry = [self getEntryFromReference:div.BAT];
    M3ReferenceEntry regnEntry = [self getEntryFromReference:div.REGN];
    
    fseek(f, faceEntry.offset, SEEK_SET);
    faces = malloc(sizeof(short)*faceEntry.count);
    fread(faces, sizeof(short), faceEntry.count, f);

    fseek(f, batEntry.offset, SEEK_SET);
    M3Bat *BAT = malloc(sizeof(M3Bat)*batEntry.count);
    fread(BAT, sizeof(M3Bat), batEntry.count, f);
    
    fseek(f, regnEntry.offset, SEEK_SET);
    M3Regn *REGN = malloc(sizeof(M3Regn)*regnEntry.count);
    fread(REGN, sizeof(M3Regn), regnEntry.count, f);
    
    meshes = malloc(sizeof(M3Submesh)*batEntry.count);
    
    
    for (int i = 0; i < batEntry.count; i++) {
        M3Regn rtemp = REGN[BAT[i].index_regn];
        int faces1 = rtemp.num_faces;
        
        meshes[i].vertices = malloc(sizeof(GLKVector3)*faces1);
        meshes[i].colors = malloc(sizeof(GLKVector4)*faces1);
        
        int offset_vert = rtemp.offset_vert;
        int offset = rtemp.offset_faces;
        
        meshes[i].num_verts = faces1;
        for (int j = 0; j < faces1; j++) {
            
            short vert1 = faces[offset+j] + offset_vert;
            meshes[i].vertices[j]   = GLKVector3Make(verts[vert1].x,
                                                     verts[vert1].y,
                                                     verts[vert1].z);
            meshes[i].colors[j] = GLKVector4Make(j%3==0?1:0, j%3==1?1:0, j%3==2?1:0, 1.0);
        }
    }

    free(BAT);
    free(REGN);
}

-(M3ReferenceEntry)getEntryFromReference:(M3Reference)ref {
    M3ReferenceEntry entry = referenceTable[ref.index];
    return entry;
}

-(void) dealloc {
    free(referenceTable);
    free(verts);
    free(faces);
    for (int i = 0; i<10; i ++) {
        free(meshes[i].vertices);
    }
    free(meshes);
}

@end
