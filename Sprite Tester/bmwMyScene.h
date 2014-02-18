//
//  bmwMyScene.h
//  Sprite Tester
//

//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface bmwMyScene : SKScene <UIAlertViewDelegate>

@property (strong, nonatomic) SKSpriteNode *mainCharacter;
@property (strong, nonatomic) NSMutableArray *flappyArray;

@end
