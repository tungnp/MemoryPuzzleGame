//
//  PieceImageView.h
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//


#import <UIKit/UIKit.h>
//  standard width and height
#define STANDARD_WIDTH 60
#define STANDARD_HEIGHT 60

//  standard flip up/down time (second)
#define FLIP_TIME 0.3

@interface PieceImageView : UIImageView

//  if 2 pieces with the same code are flipped, player will score (in another way 2 pieces whoses image are the same will have same code
@property (nonatomic, readonly) int code;

// the upside and downside image displayed, all downside image in 1 level should be the same
@property (nonatomic, strong) UIImage* upImage;
@property (nonatomic, strong) UIImage* downImage;

// 
@property (nonatomic) BOOL faceUP;


// init object with upSide image and code
- (id) initWithImage:(UIImage *)upImage
       DownsideImage:(UIImage *)downImage
                Code:(int) code;

// flip up, showing the upside image
- (void) flipUp;

// flip down, showing the downside image
- (void) flipDown;
@end
