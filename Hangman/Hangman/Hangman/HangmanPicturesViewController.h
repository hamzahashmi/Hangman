//
//  HangmanPicturesViewController.h
//  Hangman
//
//  Created by Hamza Hashmi on 11/6/13.
//  Copyright (c) 2013 hamza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HangmanGameLogic.h"

@interface HangmanPicturesViewController : UIViewController

@property (strong, nonatomic) NSString  *message;
@property (strong, nonatomic) HangmanGameLogic *game;
@property (strong, nonatomic) NSMutableArray *letters;

@end
