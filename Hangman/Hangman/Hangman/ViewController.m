//
//  ViewController.m
//  Hangman
//
//  Created by Hamza Hashmi on 10/18/13.
//  Copyright (c) 2013 hamza. All rights reserved.
//

#import "ViewController.h"
#import "HangmanPicturesViewController.h"
#import "HangmanGameLogic.h"

@interface ViewController ()

@property (strong, nonatomic) HangmanGameLogic *game;
@property (strong, nonatomic) IBOutlet UILabel *lettersVisible;
@property (strong, nonatomic) IBOutlet UITextField *guessBox;
@property (strong, nonatomic) NSString *guessedLetter;
@property (strong, nonatomic) IBOutlet UILabel *numberOfGuessLeftLabel;

@property (strong, nonatomic) IBOutlet UIImageView *hangingImage;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (strong, nonatomic) NSMutableArray *guessedLettersSoFar;

@end

@implementation ViewController

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender {
    

    
    [self performSegueWithIdentifier:@"showHangman" sender:self];
}



-(NSMutableArray *)guessedLettersSoFar {
    if (!_guessedLettersSoFar) {
        _guessedLettersSoFar = [[NSMutableArray alloc] initWithCapacity:15];
    }
    return _guessedLettersSoFar;
    
}
-(HangmanGameLogic *)game {
    if (!_game) {
        _game = [[HangmanGameLogic alloc] init];
    }
    return _game;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in this bitch");
    HangmanPicturesViewController *picturesView = [segue destinationViewController];
    
    if (self.guessedLettersSoFar == NULL) {
        NSLog(@"null");
    }
    picturesView.letters = self.guessedLettersSoFar;
    if ([[segue identifier] isEqualToString:@"showHangman"]) {
        [[segue destinationViewController] setMessage:[NSString stringWithFormat:@"%d", self.game.numberOfGuesses]];
        //NSLog(@"HERE");

    }
}
- (IBAction)textfieldEnded:(id)sender {
    
    //NSLog(@"In this bitch");
    if (![self.guessBox.text  isEqual: @" "]) {
        //NSLog(@"THIS BITCH IS CALLED");
        self.guessedLetter = self.guessBox.text;
        [self.game callMatch:self.guessBox.text];
        [self update];
    }
    if ([self.guessBox isFirstResponder]) {
        
        NSLog(@"its first");
    }
    if(self.guessBox.delegate == self) {
        NSLog(@"Iamthedelegate");
    }

}

//- (IBAction)guessingField:(UITextField *)sender {
//    
//        //NSLog(@"%@", self.guessBox.text);
////    if (![self.guessBox.text  isEqual: @" "]) {
////        NSLog(@"THIS BITCH IS CALLED");
////        self.guessedLetter = self.guessBox.text;
////        [self.game callMatch:self.guessBox.text];
////        [self update];
//    
////
////    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.guessBox.delegate = self;
    self.view.backgroundColor = [UIColor greenColor];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(resignOnTap)];
    
    [self.view addGestureRecognizer:tap];
    NSLog(@"%@", self.game.currentWord);
    [self.guessBox becomeFirstResponder];

    //self.howManyGuesses.textColor = [UIColor whiteColor];
    [self update];
    
	// Do any additional setup after loading the view, typically from a nib.

}



-(void) resignOnTap {
    NSLog(@"here resigning");
    [self.guessBox resignFirstResponder];
    //[self.view endEditing:YES];
}



- (IBAction)resetButton:(UIButton *)sender {
    self.game = [[HangmanGameLogic alloc] init];
//    self.lettersVisible.text = @" ";
    self.guessBox.enabled = YES;
    self.view.backgroundColor = [UIColor greenColor];
    [self update];
}

-(void) update {
    
    self.lettersVisible.numberOfLines = 5;
    self.lettersVisible.text = [NSString stringWithString:
                                self.game.currentLettersGuessedCorrectly];
    self.lettersVisible.textAlignment = NSTextAlignmentCenter;
    self.guessBox.text = @"guess here";
    self.guessBox.clearsOnBeginEditing = YES;
    NSUInteger guessesLeft = 15 - self.game.numberOfGuesses;
    self.numberOfGuessLeftLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)guessesLeft];

    

    if (self.guessedLetter) {
        [self.guessedLettersSoFar addObject:self.guessedLetter];
    }

    [self checkForWin];
    [self dealWithHangmanImage];


    if ((self.game.numberOfGuesses) == 15) {

        [self disableEverythingInCaseOfLoss];
        
    }
    [self changeBackGroundColor];
    [self.guessBox becomeFirstResponder];

}

-(void) checkForWin {
    if (self.game.didPlayerWin) {
        [self disableEverythingInCaseOfWin];
        
    }
    
    
}

-(void) dealWithHangmanImage {
    UIImage *hanging = [UIImage imageNamed: [NSString stringWithFormat:@"Hangman%d.gif",self.game.numberOfGuesses]];
    self.hangingImage.image = hanging;

}

-(void)disableEverythingInCaseOfLoss {
    self.guessBox.enabled = NO;
    //self.lettersVisible.text = @"GAME OVER";
    self.lettersVisible.text = [NSString stringWithFormat: @"You Lose :( The correct phrase was '%@' ", self.game.currentWord];

    
    
}

-(void)disableEverythingInCaseOfWin {
    
    self.guessBox.enabled = NO;
        self.lettersVisible.text = [NSString stringWithFormat: @"You WON :) The correct phrase was '%@' ", self.game.currentWord];
    
}

-(void) changeBackGroundColor {
    if (self.game.numberOfGuesses == 4) {
        
        self.view.backgroundColor = [UIColor yellowColor];
    }
    else if (self.game.numberOfGuesses == 8) {
        self.view.backgroundColor = [UIColor orangeColor];
        
    }
    else if (self.game.numberOfGuesses == 12) {
        self.view.backgroundColor = [UIColor redColor];
        
    }
    else if (self.game.numberOfGuesses == 15) {
        self.view.backgroundColor = [UIColor blackColor];
        self.lettersVisible.textColor = [UIColor whiteColor];
        [self.resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.numberOfGuessLeftLabel.textColor = [UIColor whiteColor];

        
    }
    
    
}




@end
