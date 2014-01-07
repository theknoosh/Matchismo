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
@property (nonatomic, readwrite)NSMutableArray *cardMatches;

@end

@implementation CardMatchingGame

-(NSAttributedString *)getMatchedCards{
    if (self.cardMatches.count == 0) {
        if (self.threeCardMode) {
            // return [NSString stringWithFormat:@"No Set"];
            NSAttributedString *attribString = [[NSAttributedString alloc]initWithString:@" No Set"];
            return attribString;
        } else {
            NSAttributedString *attribString = [[NSAttributedString alloc]initWithString:@" No Score"];
            return attribString;
        }
    }
    return self.cardMatches.lastObject;
}

-(NSAttributedString *)getCurrentCard{
    NSMutableAttributedString * attribString = [[NSMutableAttributedString alloc]initWithAttributedString:self.lastCard.contents];
    
    // append text at the end of an attribted string - does not actually replace anything!
    NSRange textRange = NSMakeRange([attribString length], 0);
    [attribString replaceCharactersInRange:textRange
                             withString:@" card selected"];

    [attribString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(textRange.location, attribString.length-textRange.location)];
    [attribString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:0.0] range:NSMakeRange(textRange.location, attribString.length-textRange.location)];
    
    return attribString;
}

-(NSMutableArray *)cards
{
    if (!_cards)_cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(Card *)lastCard
{
    if (!_lastCard) {
        _lastCard = [[Card alloc]init];
    }
    return _lastCard;
}

-(NSMutableArray *)cardMatches{
    if (!_cardMatches) _cardMatches = [[NSMutableArray alloc]init];
    return _cardMatches;
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
    self.lastCard = [self cardAtIndex:index];
    
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
                // 1. Number of shapes all the same or all different
                // 2. Shape all the same or all different
                // 3. Outline, filled, or striped all the same or all different
                // 4. Color all the same or all different
                
                if (cardsFound == 2) { // We have three cards (this instance and two others)
                    
                    bool match1;
                    for (int i=1; i<5; i++) { // Loop through the 4 attributes
                        match1 = [card match:@[otherCard1] withAttribToCheck:i];
                        if (match1) {
                            // first two cards match. If third card not a match, exit
                            if (![card match:@[otherCard2] withAttribToCheck:i]){
                                NSLog(@"All cards the same failed on loop %d, exiting",i);
                                otherCard1.chosen = NO;
                                otherCard2.chosen = NO;
                                card.chosen = YES;
                                self.score -= COST_TO_CHOOSE;
                                return;
                            }
                            NSLog(@"All cards the same pass %d successful",i);
                        }else {
                            // first two cards do not match. First two must NOT match last card else exit
                            if (![card match:@[otherCard2] withAttribToCheck:i]){;
                                if ([otherCard1 match:@[otherCard2] withAttribToCheck:i]){
                                    NSLog(@"All cards different failed on loop %d, exiting",i);
                                    otherCard1.chosen = NO;
                                    otherCard2.chosen = NO;
                                    card.chosen = YES;
                                    self.score -= COST_TO_CHOOSE;
                                    return;
                                }
                            }else {
                                NSLog(@"All cards different failed on loop %d",i);
                                otherCard1.chosen = NO;
                                otherCard2.chosen = NO;
                                card.chosen = YES;
                                self.score -= COST_TO_CHOOSE;
                                return;
                            }
                            NSLog(@"All cards different pass %d successful",i);
                        }
                        
  
                    }
                }else {
                    card.chosen = YES;
                    return;
                }
                // TODO: We have a set, do stuff here and return
                NSLog(@"Set found");
                card.matched = YES;
                otherCard1.matched = YES;
                otherCard2.matched = YES;
                card.chosen = YES;
                NSMutableAttributedString *cardResult = [[NSMutableAttributedString alloc]initWithString:@" Set "];
                [cardResult appendAttributedString:card.contents];
                
                NSUInteger sLength = [cardResult length];
                [cardResult replaceCharactersInRange:NSMakeRange([cardResult length] , 0)
                                            withString:@" card,"];
                [cardResult addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(sLength,[cardResult length]-sLength)];
                [cardResult addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:0.0] range:NSMakeRange(sLength,[cardResult length]-sLength)];
                
                [cardResult appendAttributedString:otherCard1.contents];
                sLength = [cardResult length];
                [cardResult replaceCharactersInRange:NSMakeRange([cardResult length] , 0)
                                          withString:@" card and"];
                [cardResult addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(sLength,[cardResult length]-sLength)];
                [cardResult addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:0.0] range:NSMakeRange(sLength,[cardResult length]-sLength)];

                [cardResult appendAttributedString:otherCard2.contents];
                sLength = [cardResult length];
                [cardResult replaceCharactersInRange:NSMakeRange([cardResult length] , 0)
                                          withString:@" card"];
                [cardResult addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(sLength,[cardResult length]-sLength)];
                [cardResult addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:0.0] range:NSMakeRange(sLength,[cardResult length]-sLength)];

                
                [self.cardMatches addObject:cardResult];
                //[self.cardMatches addObject:[NSString stringWithFormat:@"Set found %@, %@, and %@ -- %d points", [card.contents string], [otherCard1.contents string], [otherCard2.contents string], 25 + MATCH_BONUS]];

                self.score -= COST_TO_CHOOSE;
            }else{
                // FOR TWO CARD MODE
                // match against other chosen cards
                for (Card *otherCard in self.cards) {
                    
                    if (otherCard.isChosen &&  !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            NSLog(@"%@ matches %@, points %d", [card.contents string],[otherCard.contents string],matchScore+MATCH_BONUS);
                            
                            [self.cardMatches addObject:[NSString stringWithFormat:@"%@ matches %@, %d points", [card.contents string], [otherCard.contents string], matchScore + MATCH_BONUS]];
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {
                            [self.cardMatches addObject:@"No match"];
                            NSLog(@"No Match");
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
