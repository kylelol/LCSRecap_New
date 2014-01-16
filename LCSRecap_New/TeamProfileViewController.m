//
//  TeamProfileViewController.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/3/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "TeamProfileViewController.h"
#import "TeamProfileHeadView.h"
#import "TeamHorizontalScroller.h"
#import "OVGraphView.h"
#import "OVGraphViewPoint.h"
#import "PlayerProfileThumbnailView.h"
#import "LCSRecapUtilities.h"
#import "TeamModel.h"
#import "PlayerModel.h"
#import "TeamGraphView.h"

@interface TeamProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, TeamGraphViewDelegate>
{
    TeamProfileHeadView *profileHeadView;
    TeamHorizontalScroller *scroller;
    UICollectionView *playerCollectionView;
    OVGraphView *graphView;
    TeamGraphView *teamGraphView;
}

@end

@implementation TeamProfileViewController

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
    
    [[LCSRecapUtilities sharedUtilities] getPlayersForTeam:self.team withCompletion:^(BOOL success, TeamModel *newTeam) {
        
        NSLog(@"%@", newTeam.players);
        self.team = newTeam;
        [playerCollectionView reloadData];
        
    }];
    
    [self configureTeamProfileHeadView];
    
    [self configureCollectionView];
   
    teamGraphView = [[[NSBundle mainBundle] loadNibNamed:@"TeamGraphView" owner:self options:nil]objectAtIndex:0];
    teamGraphView.frame = CGRectMake(0, 450, 320, 230);
    teamGraphView.delegate = self;
    [self.scrollView addSubview:teamGraphView];
    
    [self configureGraphView:0];
    

    self.scrollView.contentSize = CGSizeMake(320, profileHeadView.frame.size.height + playerCollectionView.frame.size.height + 270);
    
}

-(void)configureTeamProfileHeadView
{
    profileHeadView = (TeamProfileHeadView*)[[[NSBundle mainBundle] loadNibNamed:@"TeamProfileHeadView" owner:self options:nil]objectAtIndex:0];
    
    [[LCSRecapUtilities sharedUtilities] getTeamLogoForUrl:self.team.logoUrl withCompletion:^(BOOL success, UIImage *teamLogo) {
        profileHeadView.teamLogoImageView.image = teamLogo;
    }];
    
    [[LCSRecapUtilities sharedUtilities] getTeamLogoForUrl:self.team.teamBannerImage withCompletion:^(BOOL success, UIImage *teamLogo) {
        profileHeadView.teamProfileImageView.image = teamLogo;
    }];
    
    [self.scrollView addSubview:profileHeadView];
    
}

-(void)configureGraphView:(NSInteger)segment
{
    
    if (graphView)
    {
        [graphView removeFromSuperview];
        graphView = nil;
    }
    
    graphView = [[OVGraphView alloc] initWithFrame:CGRectMake(0, 20, 320, 200) ContentSize:CGSizeMake(320, 200)];
    graphView.plotContainer.graphcolor = [UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];
    
    switch (segment) {
        case 0:
            [graphView setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3000 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@2500 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@2000 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@4000 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@4500 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@1000 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@20000 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@3000 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@15000 ],
                                   ]];
            break;
        case 1:
            [graphView setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@320 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@100 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@900 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@999 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@200 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@400],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@500 ],
                                   ]];
            break;
        case 2:
            [graphView setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@6 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@9 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@3 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@4 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@11 ],
                                   [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@13 ],
                                   ]];
            break;
            
        default:
            break;
    }

    
    [teamGraphView addSubview:graphView];

}

-(void)configureCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    playerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, 320, 130) collectionViewLayout:layout];
    [playerCollectionView registerNib:[UINib nibWithNibName:@"PlayerProfileThumbnailView" bundle:nil] forCellWithReuseIdentifier:@"playerCell"];
    playerCollectionView.dataSource = self;
    playerCollectionView.delegate = self;
    playerCollectionView.backgroundColor = [UIColor colorWithRed:0.9372549f green:0.9372549f blue:0.95686275f alpha:1.0];
    [self.scrollView addSubview:playerCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerProfileThumbnailView *cell = (PlayerProfileThumbnailView*)[collectionView dequeueReusableCellWithReuseIdentifier:@"playerCell" forIndexPath:indexPath];
    PlayerModel* player = (PlayerModel*)self.team.players[indexPath.row];
    cell.playerLaneLabel.text = player.lane;
    cell.playerNameLabel.text = player.name;
    
    [[LCSRecapUtilities sharedUtilities] getTeamLogoForUrl:player.profileImage withCompletion:^(BOOL success, UIImage *teamLogo) {
        cell.playerPictureImageView.image = teamLogo;
    }];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.team.players.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 120);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"PlayerProfileVC" sender:nil];
}

#pragma mark - TeamGraphViewDelegate
-(void)didSwitchSegment:(NSInteger)selectedSegment
{
    [self configureGraphView:selectedSegment];
}

@end
