//
//  ViewController.h
//  progressBar
//
//  Created by mac on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface ViewController : UIViewController < UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property (strong, nonatomic) NSMutableArray * array ;
@property (strong, nonatomic) IBOutlet UITableView * tableView;

-(void)updateCellForModel:(Model*)model;

@end
