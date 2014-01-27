//
//  HangmanPicturesViewController.m
//  Hangman
//
//  Created by Hamza Hashmi on 11/6/13.
//  Copyright (c) 2013 hamza. All rights reserved.
//

#import "HangmanPicturesViewController.h"
#import "HangmanGameLogic.h"

@interface HangmanPicturesViewController ()

@end

@implementation HangmanPicturesViewController


- (IBAction)swipingBack:(UISwipeGestureRecognizer *)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}




- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"%@", self.message);

    UIImage *hanging = [UIImage imageNamed: [NSString stringWithFormat:@"Hangman%@.gif",self.message]];
   // NSLog(@"%d", [[HangmanGameLogic sharedInstance] numberOfGuesses]);
    
           UIImageView *hangView = [[UIImageView alloc] initWithImage:hanging];
           [self.view addSubview:hangView];
// [[HangmanGameLogic sharedInstance] currentWord];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
