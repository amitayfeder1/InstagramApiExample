//
//  ViewController.h
//

#import <UIKit/UIKit.h>
#import "InstagramViewController.h"
@interface LogInViewController : UIViewController<UIWebViewDelegate> {
    NSString* accessToken;   
}

@property (weak, nonatomic) IBOutlet UIWebView *loginWebView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarItemButton;

@end

