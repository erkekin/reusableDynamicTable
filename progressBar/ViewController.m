//
//  ViewController.m
//  progressBar
//
//  Created by Erk Ekin on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "AFNetworking.h"
#import "Model.h"

@interface ViewController ()
@property NSInteger x;
@end

@implementation ViewController
- (IBAction)showModel:(id)sender {
    
    for(int x =0;x < 950;x++){
        NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:x inSection:0];
        [self.tableView selectRowAtIndexPath:selectedCellIndexPath animated:false scrollPosition:UITableViewScrollPositionMiddle];
        [self tableView:self.tableView didSelectRowAtIndexPath:selectedCellIndexPath];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.array = [NSMutableArray  array];
    
    for (int i = 0; i<1000; i++) {
        
        Model* model= [[Model alloc] initWithBlock:^{
            
            
        }];
        
        [self.array addObject:model];
        
        
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSURL *url = [NSURL URLWithString:@"http://ios.anadolu.edu.tr/lab/getArray.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [responseObject enumerateObjectsUsingBlock:^(NSDictionary* dictionary, NSUInteger idx, BOOL *stop) {
            Model *mod=self.array[idx];
            [mod setValue:dictionary[@"title"] forKey:@"title"];
            [mod setValue:dictionary[@"link"] forKey:@"link"];
            
        }];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"hata  %@",error);
    }];
    [operation start];
    
    
    
    
}

-(void)updateCellForModel:(Model*)model{
    
    NSUInteger  index =    [self.array indexOfObject:model];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    TableViewCell * cell = (TableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if ( [[self.tableView visibleCells] containsObject:cell]) {
        
        cell.progressBar.progress = model.progress;
    }
}
#pragma mark TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pass";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Model * model = self.array[indexPath.row];
    
    cell.progressLabel.text = model.title;
    cell.progressBar.progress=model.progress;
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    Model * model = self.array[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:model.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [model startDownload:request andVC:self];
    
    
}

-(void)updateDataStructureWithProgress:(NSNumber *)progress andIndex:(NSUInteger)index{
    Model *mod= self.array[index];
    mod.progress=[progress floatValue];
    
}
- (void)updateUI{
    
    [self.array enumerateObjectsUsingBlock:^(Model * model, NSUInteger modelIndex, BOOL *stop) {
        if (model.progress>0) {
            
            
            
        }
    }];
    
}

@end
