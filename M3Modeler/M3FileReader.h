//
//  M3FileReader.h
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M3Struct.h"

@interface M3FileReader : NSObject {
    M3Header            header;
    M3ReferenceEntry    *referenceTable;
    M3MODL23            model;
    M3Div               div;
    short               *faces;
    M3Submesh           *meshes;
    
    GLKVector3          *verts;
}

@property (readonly) GLKVector3 *verts;
@property (readonly) M3Submesh  *meshes;

-(id) initWithFile:(NSString*) fileName;
-(void) readHeader:(FILE *) f;                                          //read raw header info
-(void) readReferenceTable:(FILE *) f;                                  //read raw reference table info
-(void) readModel:(FILE *) f;                                           //read model references
-(void) readDiv:(FILE *) f;                                             //read div references
-(void) getVertices:(FILE *) f;                                         //read raw vertices and convert to GLKVector3 array
-(void) getMeshes:(FILE *) f;

-(M3ReferenceEntry) getEntryFromReference:(M3Reference)ref;

@end
