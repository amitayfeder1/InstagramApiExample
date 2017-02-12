//
//  ViewController.m
//

#define INSTAGRAM_AUTHURL @"https://api.instagram.com/oauth/authorize/"
#define INSTAGRAM_APIURl                                @"https://api.instagram.com/v1/"
#define INSTAGRAM_CLIENT_ID                             @"your client id"
#define INSTAGRAM_CLIENTSERCRET                         @"your client secert"
#define INSTAGRAM_REDIRECT_URI                          @"https://www.yourURI.com"
#define INSTAGRAM_SCOPE                                 @"likes+public_content"
#define TYPE_OF_AUTO                                    @"SIGNED"  //@"UNSIGNED"

#import "LogInViewController.h"

@implementation LogInViewController
@synthesize loginWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loadingLabel setText:NSLocalizedString(@"Loading ....", @"Loading")];
    NSString* authURL = nil;
    if ([TYPE_OF_AUTO isEqualToString:@"UNSIGNED"])
    {
        authURL = [NSString stringWithFormat: @"%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True",
                   INSTAGRAM_AUTHURL,
                   INSTAGRAM_CLIENT_ID,
                   INSTAGRAM_REDIRECT_URI,
                   INSTAGRAM_SCOPE];
        
    }
    else
    {
        authURL = [NSString stringWithFormat: @"%@?client_id=%@&redirect_uri=%@&response_type=code&scope=%@&DEBUG=True",
                   INSTAGRAM_AUTHURL,
                   INSTAGRAM_CLIENT_ID,
                   INSTAGRAM_REDIRECT_URI,
                   INSTAGRAM_SCOPE];
    }
    [loginWebView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: authURL]]];
    [loginWebView setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    return [self checkRequestForCallbackURL: request];
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [loginWebView.layer removeAllAnimations];
    loginWebView.userInteractionEnabled = NO;
    [UIView animateWithDuration: 0.1 animations:^{
          loginWebView.alpha = 0.2;
    }];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingLabel setHidden:true];
    [loginWebView.layer removeAllAnimations];
    loginWebView.userInteractionEnabled = YES;
    [UIView animateWithDuration: 0.1 animations:^{
        loginWebView.alpha = 1.0;
    }];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self webViewDidFinishLoad:webView];
}

- (BOOL) checkRequestForCallbackURL: (NSURLRequest*) request
{
    NSString* urlString = [[request URL] absoluteString];
    if([urlString hasPrefix: INSTAGRAM_REDIRECT_URI])
    {
        if ([TYPE_OF_AUTO isEqualToString:@"UNSIGNED"])
        {// extract and handle access token
            NSRange range = [urlString rangeOfString: @"#access_token="];
            [self handleAuth: [urlString substringFromIndex: range.location+range.length]];
            return NO;
        }
        else
        {// extract and handle code
            NSRange range = [urlString rangeOfString: @"code="];
            [self httpPostWithCustomDelegate:[urlString substringFromIndex: range.location+range.length]];
            return NO;
        }
    }
    return YES;
}

-(void) httpPostWithCustomDelegate:(NSString *)code
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *post = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",INSTAGRAM_CLIENT_ID,INSTAGRAM_CLIENTSERCRET,INSTAGRAM_REDIRECT_URI,code];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSURL * url = [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                                [self handleAuth:[dict valueForKey:@"access_token"]];
                                                           }
                                                       }];
    [dataTask resume];
}

- (void) handleAuth: (NSString*)authToken
{
    accessToken = authToken;
    [self performSegueWithIdentifier:@"MoveToImagesView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"MoveToImagesView"]) {
        InstagramViewController* ivc = (InstagramViewController*)[segue destinationViewController];
        ivc.access_token = accessToken;;
    }
}

- (IBAction)reloadButtonPressed:(id)sender{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self viewDidLoad];
}
@end
