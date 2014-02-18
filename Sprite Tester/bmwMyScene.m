//
//  bmwMyScene.m
//  Sprite Tester
//
//  Created by Chad D Colby on 2/17/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwMyScene.h"
#import "bmwMainMenu.h"

#define kNumFlappy 10

@interface bmwMyScene()
{
    int _nextFlappy;
    double _nextFlappySpawn;
    
}

@end

@implementation bmwMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        _nextFlappy = 0;
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        for (int i = 0; i < 2; i ++) {
            SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"seattle3"];
            bg.anchorPoint = CGPointZero;
            bg.position = CGPointMake(i * bg.size.width, 0);
            bg.name = @"background";
            [self addChild:bg];
            
        }

        [self setUpMainCharacter];
//        self.mainCharacter = [SKSpriteNode spriteNodeWithImageNamed: @"cleanMega.png"];
//        self.mainCharacter.position = CGPointMake(50, 100);
//        [self addChild:self.mainCharacter];
//        
//        self.mainCharacter.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.mainCharacter.size];
//        self.mainCharacter.physicsBody.dynamic = YES;
//        self.mainCharacter.physicsBody.affectedByGravity = YES;
//        self.mainCharacter.physicsBody.mass = 0.02;
//        
//        self.flappyArray = [[NSMutableArray alloc] initWithCapacity:kNumFlappy];
//        
//        for (int i = 0; i < kNumFlappy; i ++) {
//            SKSpriteNode *flappy = [SKSpriteNode spriteNodeWithImageNamed:@"smallFlappy"];
//            flappy.hidden = YES;
//            [self.flappyArray addObject:flappy];
//            flappy.position = CGPointMake(1000, 200);
//            [self addChild:flappy];
//        }
//        
        
    }
    return self;
}

- (void)setUpMainCharacter
{
    self.mainCharacter = [SKSpriteNode spriteNodeWithImageNamed: @"connor"];
    self.mainCharacter.position = CGPointMake(50, 100);
    [self addChild:self.mainCharacter];
    
    self.mainCharacter.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.mainCharacter.size];
    self.mainCharacter.physicsBody.dynamic = YES;
    self.mainCharacter.physicsBody.affectedByGravity = YES;
    self.mainCharacter.physicsBody.mass = 0.02;
    
    self.flappyArray = [[NSMutableArray alloc] initWithCapacity:kNumFlappy];
    
    for (int i = 0; i < kNumFlappy; i ++) {
        SKSpriteNode *flappy = [SKSpriteNode spriteNodeWithImageNamed:@"baron"];
        flappy.hidden = YES;
        [self.flappyArray addObject:flappy];
        flappy.position = CGPointMake(1000, 200);
        [self addChild:flappy];
    }
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.mainCharacter.physicsBody setVelocity:CGVectorMake(0, 0)];
    [self.mainCharacter.physicsBody applyImpulse:CGVectorMake(0, 10)];

}

-(float)randomValueBetween:(float)low andValue:(float)high
{
    return ((float) arc4random() / 0xFFFFFFFFu) * (high - low) + low;
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self enumerateChildNodesWithName:@"background" usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *bg = (SKSpriteNode *)node;
        bg.position = CGPointMake(bg.position.x - 5, bg.position.y);
        
        if (bg.position.x <= -bg.size.width) {
            bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y);
        }
        
    }];
    
    double curTime = CACurrentMediaTime();
    
    if (curTime > _nextFlappySpawn) {
        
        float randSeconds = [self randomValueBetween:0.20f andValue:1.0f];
        _nextFlappySpawn = randSeconds + curTime;
        
        float randY = [self randomValueBetween:0.0f andValue:self.frame.size.height];
        float randDuration = [self randomValueBetween:5.0f andValue:8.0f];
        SKSpriteNode *flappy = self.flappyArray[_nextFlappy];
        
        _nextFlappy++;
        
        if (_nextFlappy >= self.flappyArray.count) {
            _nextFlappy = 0;
        }
        
        [flappy removeAllActions];
        flappy.position = CGPointMake(self.frame.size.width + flappy.size.width / 2, randY);
        
        flappy.hidden = NO;
        CGPoint location = CGPointMake(-600, randY);
        
        SKAction *moveAction = [SKAction moveTo:location duration:randDuration];
        SKAction *makeBig = [SKAction scaleBy:3.0f duration:0.5];
        SKAction *doneAction = [SKAction runBlock:^{
            flappy.hidden = YES;
        }];
        
        SKAction *moveFlappyActionWithDone = [SKAction sequence:@[moveAction, makeBig,doneAction]];
    
        
        [flappy runAction:moveFlappyActionWithDone];
    
        
        for (SKSpriteNode *flappy in self.flappyArray) {
            
            if ([self.mainCharacter intersectsNode:flappy]) {
                                 [self.mainCharacter.physicsBody applyTorque:3.0f];
                NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
                SKEmitterNode *burstNode = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];

                burstNode.position = self.mainCharacter.position;
               // [self addChild:burstNode];
                
                [self.mainCharacter runAction:makeBig completion:^{

                
//                    SKScene *menuScene = [[bmwMainMenu alloc] initWithSize:self.size];
//                    menuScene.scaleMode = SKSceneScaleModeAspectFill;

                    // [self.view presentScene:menuScene];
                    [self.mainCharacter removeFromParent];
                    
                    [self showAlert];
                    [burstNode resetSimulation];
                    [burstNode removeFromParent];
                    
                }];
            
                //[self.mainCharacter.physicsBody applyImpulse:CGVectorMake(10.0f, 10.0f)];

            }
        }

    }
    
}


- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ahh Crap" message:@"Would you like to play again?" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self setUpMainCharacter];
    }
}

@end
