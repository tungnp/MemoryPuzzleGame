//
//  GameManager.m
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

- (id) init{
    if (self = [super init]) {
    }
    return self;
}
+ (id) sharedManager{
    static GameManager* gameManager;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        gameManager = [self new];
    });
    return gameManager;
}
- (void) loadViewTo:(UIView *)view{
    for (PieceImageView* imageView in self.gameLevel.pieceImageViews) {
        [view addSubview:imageView];
    }
}
- (void) createGameAtLevel:(int)level forType:(int)type{
    self.gameLevel = [[GameLevel alloc]initLevelAt:level forType:type];
}
@end
