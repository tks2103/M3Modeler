//
//  M3Sprite.m
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "M3Sprite.h"

@implementation M3Sprite

@synthesize rotation;

-(id) init {
    self = [super init];
    if (self) {
        fread = [[M3FileReader alloc] initWithFile:@"/Users/tsinha/src/M3Modeler/M3Modeler/ArcliteSiegeTank.m3"];
        //[fread calcVerts];
        
    }
    return self;
}

-(void) render {
    GLKBaseEffect *effect = [[GLKBaseEffect alloc] init];
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    effect.transform.projectionMatrix = GLKMatrix4MakePerspective(45.0f, 2.0f/3.0f, 10.0f, 200.0f);
    
    GLKMatrix4 modelviewMatrix = GLKMatrix4Multiply(GLKMatrix4MakeXRotation(-M_PI/2), GLKMatrix4MakeYRotation(-M_PI/8));
    modelviewMatrix = GLKMatrix4Multiply(GLKMatrix4MakeYRotation(rotation), modelviewMatrix);
    modelviewMatrix = GLKMatrix4Multiply(GLKMatrix4MakeTranslation(0, -1, -15), modelviewMatrix);
    effect.transform.modelviewMatrix = modelviewMatrix;
            
    [effect prepareToDraw];
        
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);

    for (int i = 0; i < 10; i++) {
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, fread.meshes[i].vertices);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, fread.meshes[i].colors);
        glDrawArrays(GL_TRIANGLES, 0, fread.meshes[i].num_verts);
    }

    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
    glDisable(GL_BLEND);
}

-(void) update {
    rotation += M_PI / 96;
    if (rotation > 2 * M_PI) {
        rotation = 0;
    }
}


@end
