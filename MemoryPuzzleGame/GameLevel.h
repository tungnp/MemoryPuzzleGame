//
//  GameLevel.h
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PieceImageView.h"
// number of Column
#define COLUMN 4
#define NORMAL 0
#define ROTATE 1

@interface GameLevel : NSObject

//  Calculated width and height for the superview
@property (nonatomic) float width;
@property (nonatomic) float height;

//  type of the game
@property (nonatomic) int type;
//  level of ... level
@property (nonatomic, readonly) int level;

//  array of pieces in level
@property (nonatomic, strong, readonly) NSArray* pieceImageViews;

//  number of row
@property (nonatomic) int row;

//  number of different images in level (the higher the harder)
@property (nonatomic) int numberOfImages;

//  background image
@property (nonatomic, strong) UIImage* backgroundImage;
- (id) initLevelAt: (int) level
           forType: (int) type;
- (void) loadDataFromDictionary: (NSDictionary*) dictionary;
@end
