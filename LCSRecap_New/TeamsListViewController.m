//
//  TeamsListViewController.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 12/20/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamsListViewController.h"
#import "LCSRecapUtilities.h"
#import "TeamModel.h"

@interface TeamsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *teamsDictionaryArray;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation TeamsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[LCSRecapUtilities sharedUtilities] getAllTeamsForRegion:@"NA" withCompletion:^(BOOL success, NSError *error, NSArray *teams) {
        
        self.teamsDictionaryArray = teams;
        
        [self.tableView reloadData];
                
    }];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
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
    return self.teamsDictionaryArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)self.teamsDictionaryArray[section]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

@end
