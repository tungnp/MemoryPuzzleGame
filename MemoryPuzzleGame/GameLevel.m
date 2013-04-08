//
//  GameLevel.m
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "GameLevel.h"
#import "NSMutableArray+Shuffle.h"

@implementation GameLevel

- (id) initLevelAt:(int)level
           forType:(int)type{
    if (self = [super init]) {
        self.type = type;
        _level = level;
        NSString* filePath = [[NSBundle mainBundle]pathForResource:@"gameLevel" ofType:@"plist"];
        NSDictionary* initDictionary = [[NSArray arrayWithContentsOfFile:filePath] objectAtIndex:level-1];
        [self loadDataFromDictionary:initDictionary];
        [self generateFromDictionary:initDictionary];
    }
    return self;
}
- (void) loadDataFromDictionary:(NSDictionary *)dictionary{
    self.row = [[dictionary objectForKey:@"row"] intValue];
    if (!self.row*COLUMN % 2) {
        self.row++;
    }
    self.numberOfImages = [[dictionary objectForKey:@"number of images"] intValue];
    self.backgroundImage = [UIImage imageNamed:[dictionary objectForKey:@"background"]];
}

- (void) generateFromDictionary: (NSDictionary*) dictionary{
    NSMutableArray* pieceImageViews = [NSMutableArray new];
    NSArray* array = [dictionary objectForKey:@"images"];
    for (int i = 0; i < self.row*COLUMN; i ++) {
        NSString* imageName = [array objectAtIndex:(i/2)%[array count]];
        NSString* downImageName = [dictionary objectForKey:@"downside image"];
        PieceImageView* imageView =
        [[PieceImageView alloc]initWithImage:[UIImage imageNamed:imageName]
                               DownsideImage:[UIImage imageNamed:downImageName]
                                        Code:(i/2)%[array count]];
        [pieceImageViews addObject:imageView];
    }
    pieceImageViews = [pieceImageViews shuffle];
    _pieceImageViews = [NSArray arrayWithArray:pieceImageViews];
    if (self.type == ROTATE) {
        self.width = COLUMN * (STANDARD_WIDTH +10)* sqrtf(2) + 50;
        self.height = self.row * (STANDARD_HEIGHT + 10)* sqrtf(2) + 50;
        for ( PieceImageView* object in _pieceImageViews) {
            int index = [_pieceImageViews indexOfObject:object];
            float distance = ( STANDARD_WIDTH + 10 ) / sqrtf(2);
            object.center = CGPointMake(self.width/2 + distance * (index % COLUMN) - distance*(index / COLUMN), sqrtf(2) * STANDARD_HEIGHT + distance * (index / COLUMN) + distance * (index % COLUMN));
            object.transform = CGAffineTransformMakeRotation(M_PI_4);
        }
    }
    else if (self.type == NORMAL){
        self.width = COLUMN * (STANDARD_WIDTH +10)*  + 20;
        self.height = self.row * (STANDARD_HEIGHT + 10)* + 20;
        for ( PieceImageView* object in _pieceImageViews) {
            int index = [_pieceImageViews indexOfObject:object];
            float distance = STANDARD_WIDTH + 10;
            object.center = CGPointMake(20 +STANDARD_WIDTH/2 + distance * (index % COLUMN) , 20 +STANDARD_HEIGHT/2+ distance * (index / COLUMN));
        }

    }
}

@end
