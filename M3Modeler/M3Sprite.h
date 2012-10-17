//
//  M3Sprite.h
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "M3FileReader.h"

@interface M3Sprite : NSObject {
    M3FileReader    *fread;
    float           rotation;
}

@property float rotation;

-(void)render;
-(void)update;

@end


