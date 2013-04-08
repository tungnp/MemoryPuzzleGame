//
//  PieceImageView.m
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "PieceImageView.h"

@implementation PieceImageView

- (id) initWithImage:(UIImage *)upImage
       DownsideImage:(UIImage *)downImage
                Code:(int)code{
    if (self = [super initWithImage:downImage]) {
        _code = code;
        self.frame = CGRectMake(0, 0, STANDARD_WIDTH, STANDARD_HEIGHT);
        self.upImage = upImage;
        self.downImage = downImage;
        self.faceUP = NO;
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}
- (void) flipUp{
    self.image = self.upImage;
    self.faceUP = YES;
}
- (void) flipDown{
    self.image = self.downImage;
    self.faceUP = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
