//
//  AppDelegate.h
//  M3Modeler
//
//  Created by Tanoy Sinha on 10/16/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "M3SceneController.h"
#import "M3Scene.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GLKViewControllerDelegate, GLKViewDelegate> {
    M3Scene *scene;
}

@property (strong, nonatomic) UIWindow *window;

#pragma mark GLKViewControllerDelegate
- (void)glkViewControllerUpdate:(GLKViewController *)controller;

#pragma mark GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect;

@end
