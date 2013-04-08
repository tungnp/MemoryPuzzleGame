//
//  GameManager.h
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameLevel.h"
@interface GameManager : NSObject

//  Level of the game
@property (nonatomic, strong) GameLevel* gameLevel;

//  load view to a view controller
- (void) loadViewTo: (UIView*) view;

- (void) createGameAtLevel: (int) level
                   forType: (int) type;
+ (id) sharedManager;

@end
