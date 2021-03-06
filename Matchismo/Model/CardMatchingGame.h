//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by DPayne on 11/27/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)resetGame;
-(NSAttributedString *)getMatchedCards;
-(NSAttributedString *)getCurrentCard;

@property (nonatomic, readonly)NSInteger score;
@property (nonatomic,assign)BOOL threeCardMode;
@property (nonatomic, readonly)NSMutableArray *cardMatches;
@property (nonatomic)Card *lastCard;

@end
