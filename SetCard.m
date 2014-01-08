//
//  SetCard.m
//  Matchismo
//
//  Created by DPayne on 12/11/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards withAttribToCheck:(int)check
{
    if ([otherCards count]==1) {
        SetCard *otherCard = [otherCards firstObject];
        AttribToCheck atrribCheck = check;
        switch (atrribCheck) {
            case NUMBER:
                if (self.shapeNumber == otherCard.shapeNumber) {
                    return YES;
                }
                break;
            case SYMBOL:
                if (self.cardShape == otherCard.cardShape) {
                    return YES;
                }
                break;
            case SHADING:
                if (self.cardFill == otherCard.cardFill) {
                    return YES;
                }
                break;
            case COLOR:
                if (self.color == otherCard.color) {
                    return YES;
                }
                break;
            default:
                break;
        }
    }
    return NO;
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
    UIColor *_black = [UIColor blackColor];
    switch (self.cardFill) {
            
        case 1: // Outlined
            [attString addAttribute:NSStrokeColorAttributeName value:self.color range:NSMakeRange(0, _stringLength)];
            [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:4.0] range:NSMakeRange(0, _stringLength)];
            break;
        case 2: // Solid
            [attString addAttribute:NSForegroundColorAttributeName value:self.color range:NSMakeRange(0, _stringLength)];
            break;
        case 3: //Patterned??
            [attString addAttribute:NSStrokeColorAttributeName value:_black range:NSMakeRange(0, _stringLength)];
            [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:-5.0] range:NSMakeRange(0, _stringLength)];
            [attString addAttribute:NSForegroundColorAttributeName value:self.color range:NSMakeRange(0, _stringLength)];
            break;
            
        default:
            [attString addAttribute:NSForegroundColorAttributeName value:self.color range:NSMakeRange(0, _stringLength)];
            break;
    }
    
    // NSArray *rankStrings = [PlayingCard rankStrings];
    // return [rankStrings[self.rank] stringByAppendingString:self.suit];
    return attString;
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end
