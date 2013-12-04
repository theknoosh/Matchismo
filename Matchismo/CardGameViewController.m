//
//  CardGameViewController.m
//  Matchismo
//
//  Created by DPayne on 11/18/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}
    
-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.game.threeCardMode = self.modeSwitch.isOn;
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.modeSwitch.enabled = NO;

    [self updateUI];
 
}
- (IBAction)dealTheCards:(id)sender {
    [self.game resetGame];
    [self updateUI];
    self.game = nil;
    self.modeSwitch.enabled = YES;
}
- (IBAction)gameMode:(id)sender {
    
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront":@"cardBack"];
}

@end
