//
//  LocationDetails.m
//

#import <Foundation/Foundation.h>
#import "LocationDetails.h"

@implementation LocationDetails

@synthesize name;
@synthesize identifier;

-(BOOL) isValid
{
    return (name && identifier);
}

@end
