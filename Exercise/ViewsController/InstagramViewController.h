//
//  InstagramViewController.h
//

#ifndef InstagramViewController_h
#define InstagramViewController_h

#import <UIKit/UIKit.h>

#import "MediaDetails.h"
#import "InstagramManager.h"
#import "InstagramCommunicator.h"
#import "MediaCell.h"

@interface InstagramViewController : UIViewController<InstagramManagerDelegate, CLLocationManagerDelegate, UITableViewDelegate> {
    NSArray *_medias;
    InstagramManager *_manager;
    CLLocationManager *_locationManager;
}
@property (nonatomic, strong) NSString* access_token;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *userMediaButton;
@property (strong, nonatomic) IBOutlet UITextField *mediaSearchTextField;
@property (strong, nonatomic) IBOutlet UIButton *mediaLocationButton;
- (IBAction)buttonUserMediaPressed:(id)sender;
- (IBAction)buttonLocationMediaPressed:(id)sender;
- (IBAction)startSearchByField:(id)sender;
@end

#endif /* InstagramViewController_h */
