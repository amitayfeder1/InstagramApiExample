//
//  MediaDetails.m
//

#import <Foundation/Foundation.h>
#import "MediaDetails.h"

@implementation MediaDetails
@synthesize user;
@synthesize likes;
@synthesize link;
@synthesize images;
@synthesize created_time;
@synthesize user_has_liked;
@synthesize mediaId;

-(NSString*) getUserName
{
    NSString* userName = [user valueForKey:@"username"];
    if (!userName)
    {
        userName = @"Missing user";
    }
    return userName;
}
-(NSNumber*) getLikes
{
    NSNumber *numOfLikes = [likes valueForKey:@"count"];
    return numOfLikes;
}

-(NSString*) getLowResUrl
{
    NSString* url;
    if (images)
    {
        NSDictionary* lowRes = [images valueForKey:@"low_resolution"];
        if (lowRes)
        {
            url = [lowRes valueForKey:@"url"];
        }
    }
    return url;
}

-(NSString*) getStandardResUrl
{
    NSString* url;
    if (images)
    {
        NSDictionary* lowRes = [images valueForKey:@"standard_resolution"];
        if (lowRes)
        {
            url = [lowRes valueForKey:@"url"];
        }
    }
    return url;
}


-(BOOL) isValid
{
    return (link && user && [self getLowResUrl] && mediaId);
}

@end

