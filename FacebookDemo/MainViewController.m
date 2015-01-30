//
//  MainViewController.m
//  FacebookDemo
//
//  Created by Timothy Lee on 10/22/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "MainViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "NodeCell.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *fbData;

- (void)reload;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NodeCell" bundle:nil] forCellReuseIdentifier:@"NodeCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.title = @"Home";
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)reload {
    [FBRequestConnection startWithGraphPath:@"/me/home"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              
                              self.fbData = result[@"data"];
                              [self.tableView reloadData];
                              NSLog(@"result: %@", result);
                          }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NodeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NodeCell"];
    cell.nameLabel.text = [self.fbData[indexPath.row] valueForKeyPath:@"from.name"];
    cell.typeLabel.text = [self.fbData[indexPath.row] valueForKeyPath:@"type"];
    cell.statusTypeLabel.text = [self.fbData[indexPath.row] valueForKeyPath:@"status_type"];
        return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fbData.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
