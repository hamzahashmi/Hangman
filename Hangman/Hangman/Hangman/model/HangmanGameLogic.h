//
//  HangmanGameLogic.h
//  Hangman
//
//  Created by Hamza Hashmi on 10/18/13.
//  Copyright (c) 2013 hamza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangmanGameLogic : NSObject

@property (nonatomic) int numberOfGuesses;
@property (strong, nonatomic) NSMutableArray* wordLetters;
@property (strong, nonatomic) NSMutableArray* visibleLetters; //display:1, don't display:0
@property (strong, nonatomic) NSString* currentWord;
@property (strong, nonatomic) NSMutableString* currentLettersGuessedCorrectly;
@property (strong, nonatomic) NSString* gameStatus;


@property (nonatomic) int howManyLeft;


+ (id)sharedInstance;

-(void) callMatch:(NSString *) word;


@end
