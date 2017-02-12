//
//  TagDetails.m
//

#import <Foundation/Foundation.h>
#import "TagDetails.h"

@implementation TagDetails

@synthesize name;
@synthesize media_count;

-(BOOL) isValid
{
    return (name && media_count);
}

@end
