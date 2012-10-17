//
//  M3Scene.m
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "M3Scene.h"

@implementation M3Scene

-(id) init {
    self = [super init];
    if (self) {
        sprite = [[M3Sprite alloc] init];
    }
    return self;
}

-(void) update {
    [sprite update];
}

-(void) render {
    glClearColor(0.4, 0.4, 0.4, 0.4);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [sprite render];
}

@end
