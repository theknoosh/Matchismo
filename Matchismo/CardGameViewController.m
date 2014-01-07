//
//  CardGameViewController.m
//  Matchismo
//
//  Created by DPayne on 11/18/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

// @property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *gamePrompts;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}
    
-(Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    long chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.game.threeCardMode = NO;
    [self.game chooseCardAtIndex:chosenButtonIndex];

    [self updateUI];
 
}

- (IBAction)touchSetCardButton:(UIButton *)sender {
    long chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.game.threeCardMode = YES;
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
}

- (IBAction)dealTheCards:(id)sender {
    [self.game resetGame];
    [self updateUI];
    self.gamePrompts.text = @"No match";
    self.game = nil;
}

-(void)updateUI
{
    Card *card;
    for (UIButton *cardButton in self.cardButtons) {
        long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        card = [self.game cardAtIndex:cardButtonIndex];
        
        NSMutableAttributedString *buttonLabel = [self titleForCard:card];
        
        NSString *test = @"tst";
        
        if ([self.game threeCardMode]) {
            [cardButton setAttributedTitle:buttonLabel forState:UIControlStateNormal];
        }else { [cardButton setTitle:test forState:UIControlStateNormal];
        }
        // TODO: Crash on this line on 6th loop (mostly)
        

        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
        self.gamePrompts.attributedText = self.game.getMatchedCards; // Displays sets on screen
        // self.gamePrompts.attributedText = self.game.getCurrentCard; // test of attributed string
    }
}

-(NSMutableAttributedString *)titleForCard:(Card *)card
{
    NSMutableAttributedString *blank = [[NSMutableAttributedString alloc]initWithString:@"x"];
    return card.isChosen ? card.contents:blank;
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    
    if (self.game.threeCardMode) {
        return [UIImage imageNamed:card.isChosen ? @"cardfront":@"setBack-1x"];
    }else {
        return [UIImage imageNamed:card.isChosen ? @"cardfront":@"cardback"];
    }
}

#pragma mark - PlayerDetailsViewControllerDelegate

- (void)historyViewControllerDidSave:(HistoryViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"history"]) {
        
        HistoryViewController *historyViewController = segue.destinationViewController;
        historyViewController.delegate = self;
    }
}

@end
