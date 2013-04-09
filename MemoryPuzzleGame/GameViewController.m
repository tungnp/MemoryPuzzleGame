//
//  GameViewController.m
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/4/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "GameViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GameViewController ()

@end
int _numberOfPieceFacedUp;
int _numberOfPieceRemain;
BOOL _flipAnimating;
PieceImageView* _firstFlipUp;
UIView* rotateView;
AVAudioPlayer* backgroundMusic;
AVAudioPlayer* beepSound;
AVAudioPlayer* flipSound1;
AVAudioPlayer* flipSound2;
AVAudioPlayer* errorSound;
@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
              forType:(int) type{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        backgroundMusic = [GameViewController audioForFileName:@"backgroundMusic"
                                                        ofType:@"mp3"];
        beepSound = [GameViewController audioForFileName:@"beep" ofType:@"mp3"];
        flipSound1 = [GameViewController audioForFileName:@"flip" ofType:@"mp3"];
        flipSound2 = [GameViewController audioForFileName:@"flip" ofType:@"mp3"];
        errorSound = [ GameViewController audioForFileName:@"error" ofType:@"mp3"];
        beepSound.volume = 0.5;
        flipSound2.volume = 0.5;
        flipSound1.volume = 0.5;
        errorSound.volume = 0.5;
        beepSound.numberOfLoops = 0;
        flipSound1.numberOfLoops = 0;
        flipSound2.numberOfLoops = 0;
        errorSound.numberOfLoops = 0;
        backgroundMusic.numberOfLoops = -1;
        self.type = type;
   
    }
    return self;
}
- (void) rotateAround{
    float angle = ((float)M_PI) / (arc4random() % 10 +1);
    if (arc4random()%2) {
        angle = -angle;
    }
    [UIView animateWithDuration: angle animations:^{
        rotateView.transform = CGAffineTransformRotate(rotateView.transform, angle);
    }];
}
+ (AVAudioPlayer*) audioForFileName: (NSString*) fileName
                             ofType: (NSString*) type{
    NSString* audioFilePath = [[NSBundle mainBundle]pathForResource:fileName ofType:type];
    NSURL* url = [NSURL fileURLWithPath:audioFilePath];
    NSError* error;
    AVAudioPlayer* audio = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    return audio;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    GameManager* gameManager = [GameManager sharedManager];
    [gameManager createGameAtLevel: (int) 1
                           forType: (int) self.type];
    [self loadViewFrom:gameManager];
    _numberOfPieceFacedUp = 0;
    _flipAnimating = NO;
    _numberOfPieceRemain = [gameManager.gameLevel.pieceImageViews count];
    [backgroundMusic play];

}

- (void) loadViewFrom: (GameManager*) gameManager{
    [self.view addSubview:[[UIImageView alloc]initWithImage:gameManager.gameLevel.backgroundImage]];
    if (self.type == ROTATE){
        UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        float width = gameManager.gameLevel.width;
        float height = gameManager.gameLevel.height;
        [scrollView setContentSize:CGSizeMake(width, height)];
        [scrollView scrollRectToVisible:CGRectMake((width - scrollView.frame.size.width)/2, (height - scrollView.frame.size.height)/2, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
        UIView* piecesContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        [scrollView addSubview:piecesContainerView];
        [self.view addSubview:scrollView];
        [gameManager loadViewTo:piecesContainerView];
        rotateView = piecesContainerView;
    }
    else if (self.type == NORMAL){
        [gameManager loadViewTo:self.view];
    }
    for (PieceImageView* pieceImageView in gameManager.gameLevel.pieceImageViews) {
        if ([pieceImageView isKindOfClass:[PieceImageView class]]) {
            UITapGestureRecognizer* tapGestureRecognizer  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pieceTapHandle:)];
            [tapGestureRecognizer setNumberOfTapsRequired:1];
            [tapGestureRecognizer setNumberOfTouchesRequired:1];
            [pieceImageView addGestureRecognizer:tapGestureRecognizer];
        }
    }
}
- (void) pieceTapHandle: (UITapGestureRecognizer*) sender{
    PieceImageView* pieceImageView = (PieceImageView*) sender.view;
    if (_numberOfPieceFacedUp == 0) {
        if (!_flipAnimating) {
            [flipSound1 play];
            _firstFlipUp = pieceImageView;
            _numberOfPieceFacedUp ++;
            [UIView transitionWithView:pieceImageView
                              duration:FLIP_TIME
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                [pieceImageView flipUp];
                            }
                            completion:^(BOOL finished){
                            }];
        }
    }
    else if( _numberOfPieceFacedUp == 1 && _firstFlipUp != pieceImageView){
        if (!_flipAnimating) {
            [flipSound2 play];
            _flipAnimating = YES;
            [UIView transitionWithView:pieceImageView
                              duration:FLIP_TIME
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                [pieceImageView flipUp];
                            }
                            completion:^(BOOL finished){
                                [self flipHandleWithFirstPiece: (PieceImageView*) _firstFlipUp
                                                   SecondPiece: (PieceImageView*) pieceImageView];
                                _numberOfPieceFacedUp --;
                                _firstFlipUp = nil;
                            }];

        }
    }
}
- (void) flipHandleWithFirstPiece: (PieceImageView*) firstPiece
                      SecondPiece: (PieceImageView*) secondPiece{
    if (firstPiece.code == secondPiece.code) {
        [beepSound play];
        [UIView transitionFromView:firstPiece
                            toView:nil
                          duration:FLIP_TIME
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished){
                        }];
        [UIView transitionFromView:secondPiece
                            toView:nil
                          duration:FLIP_TIME
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished){
                            [self didSelectTwoRightPieces];
                            _flipAnimating = NO;
                        }];
    }
    else{
        [errorSound play];
        [UIView animateWithDuration:0.1 animations:^{
            firstPiece.center = CGPointMake(firstPiece.center.x - 5, firstPiece.center.y - 5);
            secondPiece.center = CGPointMake(secondPiece.center.x - 5, secondPiece.center.y - 5);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 firstPiece.center = CGPointMake(firstPiece.center.x + 5, firstPiece.center.y + 5);
                                 secondPiece.center = CGPointMake(secondPiece.center.x + 5, secondPiece.center.y + 5);
                             }
                                              completion:^(BOOL finished){
                                                   _flipAnimating = NO;
                                                  [UIView transitionWithView:firstPiece
                                                                    duration:FLIP_TIME
                                                                     options:UIViewAnimationOptionTransitionFlipFromLeft
                                                                  animations:^{
                                                                      [firstPiece flipDown];
                                                                  }
                                                                  completion:^(BOOL finished){
                                                                  }];
                                                  [UIView transitionWithView:secondPiece
                                                                    duration:FLIP_TIME
                                                                     options:UIViewAnimationOptionTransitionFlipFromLeft
                                                                  animations:^{
                                                                      [secondPiece flipDown];
                                                                  }
                                                                  completion:^(BOOL finished){

                                                                  }];

                                              }];
                         }];
        [self didSelectTwoWrongPieces];
        
    }
}
- (void) didSelectTwoRightPieces{
    _numberOfPieceRemain -=2;
    if (_numberOfPieceRemain <= 0) {
        [self win];
    }
}
- (void) didSelectTwoWrongPieces{
    if (self.type == ROTATE) {
        [self rotateAround];
    }
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) win{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame: CGRectMake(50, 220, 220, 50)];
    [button setTitle:@"Return to HomeScreen" forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor blackColor]];
    [button addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [backgroundMusic stop];
}
- (void) backToHome{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
