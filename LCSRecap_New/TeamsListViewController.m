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
#import "TeamListCell.h"
#import "TeamListCollectionViewCell.h"
#import "TeamProfileViewController.h"

@interface TeamsListViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

//@property (nonatomic, strong) NSArray *teamsDictionaryArray;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

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
    [self.tableView registerNib:[UINib nibWithNibName:@"TeamList" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TeamListCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"teamCell"];
    
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

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.teamsDictionaryArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeamListCollectionViewCell *cell = (TeamListCollectionViewCell*)[cv dequeueReusableCellWithReuseIdentifier:@"teamCell" forIndexPath:indexPath];
    
        TeamModel *team = (TeamModel*)self.teamsDictionaryArray[indexPath.row];
    
    cell.teamNameLabel.text = team.teamName;
    
    [[LCSRecapUtilities sharedUtilities] getTeamLogoForUrl:team.logoUrl withCompletion:^(BOOL success, UIImage *teamLogo) {
        cell.teamImageView.image = teamLogo;
    }];
    
    
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"TeamProfileVC" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"TeamProfileVC"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        ((TeamProfileViewController*)segue.destinationViewController).team = self.teamsDictionaryArray[selectedIndexPath.row];
    }
}


#pragma mark - UITableViewDelegate

/*-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.teamsDictionaryArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)self.teamsDictionaryArray[section]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamListCell *cell = (TeamListCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TeamModel *team = (TeamModel*)[self.teamsDictionaryArray[indexPath.section] objectAtIndex:indexPath.row];
    
    // NSLog(@"%@", team);
    ((TeamListCell*)cell).teamNameLabel.text = team.teamName;
    
    [[LCSRecapUtilities sharedUtilities] getTeamLogoForUrl:team.logoUrl withCompletion:^(BOOL success, UIImage *teamLogo) {
        ((TeamListCell*)cell).teamImageView.image = teamLogo;
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}*/

@end
