//
//  M3Scene.h
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M3Sprite.h"

@interface M3Scene : NSObject {
    M3Sprite *sprite;

}
-(void) update;
-(void) render;
@end
