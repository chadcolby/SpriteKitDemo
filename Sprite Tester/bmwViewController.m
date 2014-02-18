//
//  bmwViewController.m
//  Sprite Tester
//
//  Created by Chad D Colby on 2/17/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwViewController.h"
#import "bmwMyScene.h"
#import "bmwMainMenu.h"

@implementation bmwViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewWillLayoutSubviews
{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [bmwMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
