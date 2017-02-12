//
//  InstagramViewController.m
//

#import <Foundation/Foundation.h>
#import "InstagramViewController.h"

//Used: https://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
@implementation InstagramViewController
@synthesize access_token;
@synthesize userMediaButton;
@synthesize mediaLocationButton;
@synthesize mediaSearchTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Access token= %@",access_token);
    _manager = [[InstagramManager alloc] init];
    _manager.communicator = [[InstagramCommunicator alloc] init];
    [_manager.communicator setAccess_token:access_token];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;//kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //Localization
    [userMediaButton setTitle:NSLocalizedString(@"User Media",@"User media") forState:UIControlStateNormal];
    [mediaLocationButton setTitle:NSLocalizedString(@"Location Media",@"Location media") forState:UIControlStateNormal];

    [_manager fetchRecentUserMedia];
}

#pragma Methods
-(void) setLikeButtonText:(MediaDetails*)media andButton:(UIButton*)btn{
    if ([media user_has_liked])
    {
        [btn setTitle:NSLocalizedString(@"Unlike", @"Unlike") forState:UIControlStateNormal];
    }
    else{
        [btn setTitle:NSLocalizedString(@"like", @"like") forState:UIControlStateNormal];
    }
}

# pragma Delegates

- (void)didReceiveMedias:(NSArray *)medias
{
    _medias = medias;
    NSLog(@"Number of medias: %lu",(unsigned long)[_medias count]);
    [self.tableView reloadData];
}

- (void)fetchingMediasFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

#pragma Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _medias.count;
}

//Top (5+25+5) Bottom (10+20+5) = 70
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width + 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MediaCell";
    MediaCell *cell = (MediaCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MediaDetails *media = [_medias objectAtIndex:indexPath.row];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ NSURL *url = [NSURL URLWithString:[media getStandardResUrl]]; NSData *data = [NSData dataWithContentsOfURL:url]; UIImage* image = [[UIImage alloc]initWithData:data]; dispatch_async(dispatch_get_main_queue(), ^{ [cell.mediaUIImange setImage:image]; }); });
    [cell.userLabel setText:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"User", @"User name"),[media getUserName]]];
    [cell.likesLabel setText:[NSString stringWithFormat:@"Likes: %d",[media getLikes].intValue]];
    [self setLikeButtonText:media andButton:cell.likeButton];
    
    cell.likeButton.tag = indexPath.row;
    [cell.likeButton addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

# pragma Actions

- (IBAction)buttonUserMediaPressed:(id)sender {
    [_manager fetchRecentUserMedia];
}

- (IBAction)buttonLocationMediaPressed:(id)sender {
    [self.mediaSearchTextField resignFirstResponder];
    if ([CLLocationManager locationServicesEnabled]){
        [_manager fetchMediaByLocation:_locationManager.location.coordinate];
    }
    else
    {
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (IBAction)startSearchByField:(id)sender {
    NSString* searchText = mediaSearchTextField.text;
    if (searchText)
    {
        [_manager fetchMediaFromTag:searchText];
    }
}

-(void)likeButtonClicked:(UIButton*)sender{
    [self.mediaSearchTextField resignFirstResponder];
    MediaDetails *media = [_medias objectAtIndex:sender.tag];
    [_manager likeOrUnlikeMedia:[media mediaId] andLike:!media.user_has_liked];
    media.user_has_liked = !media.user_has_liked;
    [self setLikeButtonText:media andButton:sender];
}
@end
