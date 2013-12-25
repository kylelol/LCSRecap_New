//
//  ViewController.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "ViewController.h"
#import "LCSRecapUtilities.h"
#import "SeasonModel.h"
#import "SeasonEventCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *seasonsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = nil;
    
    [[LCSRecapUtilities sharedUtilities] getAllSeasonsForRegion:@"NA"
                                                 withCompletion:^(BOOL success, NSError *error, NSArray *seasons){
                                                     if (success)
                                                     {
                                                         self.seasonsArray = seasons;
                                                         [self.tableView reloadData];
                                                     }
                                                 }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SeasonEventCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveCurrentState
{
    [[LCSRecapUtilities sharedUtilities] saveCurrentState];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.seasonsArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((SeasonModel*)[self.seasonsArray objectAtIndex:section]).events count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SeasonEventCell *cell = (SeasonEventCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    SeasonModel *currentSeason = [self.seasonsArray objectAtIndex:indexPath.section];
    //cell.textLabel.text = [currentSeason getEventNameAtIndex:indexPath.row];
    cell.seasonEventNameLabel.text = [currentSeason getEventNameAtIndex:indexPath.row]; 
    
   // cell.backgroundView = nil;
   // cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((SeasonModel*)[self.seasonsArray objectAtIndex:section]).name;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

@end
