//
//  GameViewController.h
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameManager.h"

#define NORMAL 0
#define ROTATE 1
@interface GameViewController : UIViewController

//  type of the game
@property (nonatomic) int type;
- (void) pieceTapHandle: (UITapGestureRecognizer*) sender;

- (id) initWithNibName:(NSString *)nibNameOrNil
                bundle:(NSBundle *)nibBundleOrNil
               forType: (int) type;
@end
