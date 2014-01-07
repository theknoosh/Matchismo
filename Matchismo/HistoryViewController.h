//
//  HistoryViewController.h
//  Matchismo
//
//  Created by DPayne on 1/3/14.
//  Copyright (c) 2014 Sanctuary of Darkness. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryViewController;

@protocol HistoryViewControllerDelegate <NSObject>
- (void)historyViewControllerDidSave:(HistoryViewController *)controller;
@end

@interface HistoryViewController : UIViewController

@property (nonatomic, weak) id <HistoryViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
