//
//  SetCard.m
//  Matchismo
//
//  Created by DPayne on 12/11/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards
{
    int score =0;
    if ([otherCards count]==1) {
        SetCard *otherCard = [otherCards firstObject];
        /* if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }*/
    }
    
    return score;
}

@synthesize suit = _suit; // because we provide both the setter and the getter



+(NSArray *)validSuits
{
    return @[@"▲",@"▲ ▲",@"▲ ▲ ▲",
             @"●",@"● ●",@"● ● ●",
             @"■",@"■ ■",@"■ ■ ■"];
}

+(NSArray *)validColors
{
    return @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
}

// TODO: Each card, each color, Outline, Solid, Tint

-(void)setSuit:(NSString *)suit
{
    if ([[SetCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSMutableAttributedString *)contents
{
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:self.suit];
    NSInteger _stringLength=[self.suit length];
    [attString addAttribute:NSForegroundColorAttributeName value:self.color range:NSMakeRange(0, _stringLength)];
    
    // NSArray *rankStrings = [PlayingCard rankStrings];
    // return [rankStrings[self.rank] stringByAppendingString:self.suit];
    return nil;
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end
