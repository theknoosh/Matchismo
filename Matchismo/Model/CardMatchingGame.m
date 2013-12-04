//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by DPayne on 11/27/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // of Card
@property (nonatomic, weak)Card *card1;
@property (nonatomic, weak)Card *card2;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards)_cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    Card *otherCard1,*otherCard2;
    int cardsFound = 0;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }else {
            // match against other chosen cards
            if (self.threeCardMode) {
                for (Card *otherCard in self.cards) {
                // if (self.threeCardMode) {
    
                    if (otherCard.isChosen &&  !otherCard.isMatched) {
                        cardsFound++;
                        if (cardsFound>2) break;
                        if (cardsFound == 1) {
                            otherCard1 = otherCard;
                            otherCard.chosen = YES;
                        }else {
                            otherCard2 = otherCard;
                            otherCard.chosen = YES;
                            break; // three cards chosen, break out of loop
                        }
                    }
                }
                int matchScore = 0;
                if (cardsFound == 2) {
                    int score1 = [card match:@[otherCard1]];
                    if (score1)NSLog(@"%@ matches %@, %d points", card.contents,otherCard1.contents,score1);
                    int score2 = [card match:@[otherCard2]];
                    if (score2)NSLog(@"%@ matches %@ %d points", card.contents, otherCard2.contents,score2);
                    int score3 = [otherCard1 match:@[otherCard2]];
                    if (score3)NSLog(@"%@ matches %@ %d points",otherCard1.contents,otherCard2.contents,score3);
                    matchScore = score1+score2+score3;
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard1.matched = YES;
                        otherCard2.matched = YES;
                        card.matched = YES;
                    }else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard1.chosen = NO;
                        otherCard2.chosen = NO;
                        NSLog(@"No Match");
                    }
                    NSLog(@"----------------");
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            
            }else{
                // match against other chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen &&  !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
}

// Reset all the cards in the deck
-(void)resetGame
{
    // If card is chosen, unchoose it
    for (Card *card in self.cards) {
        if (card.isChosen)card.chosen = NO;
        if (card.isMatched)card.matched = NO;
        
    }
    // reset score to 0
    self.score = 0;
}

@end
