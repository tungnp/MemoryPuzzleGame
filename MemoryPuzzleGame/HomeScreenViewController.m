//
//  HomeScreenViewController.m
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/8/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "GameViewController.h"
@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)normalMode:(id)sender {
    GameViewController* gameViewController = [[GameViewController alloc]initWithNibName:@"GameViewController"
                                                                                 bundle:nil
                                              forType:NORMAL];
    [self.navigationController pushViewController:gameViewController animated:NO];
}
- (IBAction)rotateMode:(id)sender {
    GameViewController* gameViewController = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil forType:ROTATE];
    [self.navigationController pushViewController:gameViewController animated:NO];
}

@end
