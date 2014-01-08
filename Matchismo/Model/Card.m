//
//  Card.m
//  Matchismo
//
//  Created by DPayne on 11/21/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score=0;
    for (Card *card in otherCards) {
        NSString *sCard = [card.contents string];
        NSString *sOtherCard = [[self contents]string];
        if ([sCard isEqualToString:sOtherCard]) {
            score = 1;
        }
    }
    return score;
}

-(int)match:(NSArray *)otherCards withAttribToCheck:(int)check
{
    return NO;
}


@end
