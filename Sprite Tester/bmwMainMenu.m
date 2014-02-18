//
//  bmwMainMenu.m
//  Sprite Tester
//
//  Created by Chad D Colby on 2/17/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwMainMenu.h"

@implementation bmwMainMenu

- (void)didMoveToView:(SKView *)view
{
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"seattle3"];
    backGround.alpha = 0.4f;
    backGround.anchorPoint = CGPointZero;
    backGround.position = CGPointMake(0, 0);
    self.view.showsFPS = NO;
    self.view.showsNodeCount = NO;
    
    [self addChild:backGround];
    
    [self addChild:[self createLabel]];
}

- (SKLabelNode *)createLabel
{
    SKLabelNode *labelNode = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    labelNode.text = @"Game Over";

    labelNode.position = CGPointMake(150, 50);
    labelNode.fontSize = 42.0f;
    
    UIButton *playAgainButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 90, 50, 50)];
    playAgainButton.titleLabel.text = @"Play Again";
    
    playAgainButton.enabled = NO;
    
   //[self.view addSubview:playAgainButton];
    
    return labelNode;
}



@end
