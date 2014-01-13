//
//  HistoryViewController.h
//  Matchismo
//
//  Created by DPayne on 1/7/14.
//  Copyright (c) 2014 Sanctuary of Darkness. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryViewController;

@protocol HistoryViewControllerDelegate <NSObject>
- (void)historyViewControllerDidSave:(HistoryViewController *)controller;
@end

@interface HistoryViewController : UIViewController

@property (nonatomic, weak) id <HistoryViewControllerDelegate> delegate;
@property (strong, nonatomic)NSAttributedString *contentForBox;

- (IBAction)done:(id)sender;

@end
