//
//  ViewController.m
//  Hangman
//
//  Created by Hamza Hashmi on 10/18/13.
//  Copyright (c) 2013 hamza. All rights reserved.
//

#import "ViewController.h"
#import "HangmanGameLogic.h"

@interface ViewController ()

@property (strong, nonatomic) HangmanGameLogic *game;
@property (strong, nonatomic) IBOutlet UILabel *lettersVisible;

@property (strong, nonatomic) IBOutlet UITextField *guessBox;
@property (strong, nonatomic) NSString *guessedLetter;
@property (strong, nonatomic) IBOutlet UILabel *howManyGuesses;


@end

@implementation ViewController

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender {
    
    [self performSegueWithIdentifier:@"showHangman" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showHangman"]) {
        //[[segue destinationViewController] setMessage:@"YOYO"];
        //NSLog(@"HERE");

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.guessBox.delegate = self;
    self.game = [HangmanGameLogic sharedInstance];
    [self update];
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)guessingField:(UITextField *)sender {
    
        //NSLog(@"%@", self.guessBox.text);
    [self.game callMatch:self.guessBox.text];
    [self update];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetButton:(UIButton *)sender {
    self.game = [[HangmanGameLogic alloc] init];
//    self.lettersVisible.text = @" ";
    self.guessBox.enabled = YES;
    [self update];
}

-(void) update {
    
    self.lettersVisible.numberOfLines = 5;
    self.lettersVisible.text = [NSString stringWithString:
                                self.game.currentLettersGuessedCorrectly];
    self.lettersVisible.textAlignment = NSTextAlignmentCenter;
    self.guessBox.text = @"guess here";
    self.guessBox.clearsOnBeginEditing = YES;
    [self.howManyGuesses setText:[NSString stringWithFormat:@"%d", self.game.numberOfGuesses]];
//    if ([self.game.gameStatus isEqualToString:@"mismatch"]) {
//        NSLog(@"it's a mismatch");
//        UIImage *hanging = [UIImage imageNamed:[NSString stringWithFormat:@"Hangman%d.gif", self.game.numberOfGuesses]];
//        UIImageView *hangView = [[UIImageView alloc] initWithImage:hanging];
//        [self.view addSubview:hangView];
//        
//    }

    if ((self.game.numberOfGuesses) == 15) {

        [self disableEverything];
        
    }
}

-(void)disableEverything {
    self.guessBox.enabled = NO;
    self.lettersVisible.text = @"GAME OVER";
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self update];
    //NSLog(@"re");
    return YES;
    
}

@end
