//
//  HangmanGameLogic.m
//  Hangman
//
//  Created by Hamza Hashmi on 10/18/13.
//  Copyright (c) 2013 hamza. All rights reserved.
//

#import "HangmanGameLogic.h"
#import "HangmanWords.h"

@implementation HangmanGameLogic

const int MAXIMUMNUMBEROFGUESSES = 15;

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id) init {
    if (self  = [super init]) {
        
        HangmanWords *randomPhrase = [[HangmanWords alloc] init];
        self.currentWord = [randomPhrase getWord];
        
    }
    [self updateCurrGuess];

    return self;
    
    
}
-(NSMutableArray *)visibleLetters {
    if (!_visibleLetters) {
        
        _visibleLetters = [[NSMutableArray alloc] initWithCapacity:[self.currentWord length]];
        for (int i = 0; i < [self.currentWord length]; i++) {
            if ([[self.wordLetters objectAtIndex:i] isEqualToString:@" "]) {
                //NSLog(@"it's a space ");
                [_visibleLetters addObject:@"1"];

            }
            else {
            [_visibleLetters addObject:@"0"];
            }

        }
    }
    
    return _visibleLetters;
}

-(NSMutableArray *)wordLetters {
    if (!_wordLetters) {
        _wordLetters = [[NSMutableArray alloc] init];
        
        NSRange theRange = {0, 1};
        //NSMutableArray * array = [NSMutableArray array];
        for ( NSInteger i = 0; i < [self.currentWord length]; i++) {
            theRange.location = i;
            [_wordLetters addObject:[self.currentWord substringWithRange:theRange]];
        }
    }


    return _wordLetters;
    
    
}



-(int) numberOfGuesses {
    
    if (!_numberOfGuesses) {
        
        return 0;
    }
    return _numberOfGuesses;
    
    
}



-(void) callMatch:(NSString *) word {
    [self match:word inArray:self.wordLetters];
    
    
}


-(int) match:(NSString *)letter inArray:(NSArray *)wordRep {
    self.gameStatus = @"mismatch";

    if (self.numberOfGuesses < MAXIMUMNUMBEROFGUESSES) {
        for (int i = 0; i < [wordRep count]; i++) {
            if ([[wordRep objectAtIndex:i] isEqualToString:letter]) {
                [self.visibleLetters replaceObjectAtIndex:i withObject:@"1"];
                self.gameStatus = @"match";
                [self updateCurrGuess];


                
            }
        }
        
        if ([self.gameStatus isEqualToString:@"mismatch"]) {
        
        self.numberOfGuesses++;
        }
        [self updateCurrGuess];
        return 0; //letter not found in word
        }
    else {
        self.gameStatus = @"GAME OVER";
        return -1; //reached maximum number of guesses and game is now over
        
        
    }
    [self updateCurrGuess];
    
    
}



-(void)updateCurrGuess {
    //NSLog(@"current:word: %@", self.currentWord);
    

    self.currentLettersGuessedCorrectly = [[NSMutableString alloc] initWithCapacity:[self.currentWord length]];
    for (int i =0; i < [self.visibleLetters count]; i++) {
        
        if ([[self.visibleLetters objectAtIndex:i] isEqualToString:@"1"]) {
                [self.currentLettersGuessedCorrectly appendString:@"   "];
                [self.currentLettersGuessedCorrectly appendString:[self.wordLetters objectAtIndex:i]];



        }

        else {
            [self.currentLettersGuessedCorrectly appendString:@"   _"];

            
        }
    }
    
    
    

    
}




@end
