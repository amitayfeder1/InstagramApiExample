//
//  MediaCell.h
//

#ifndef MediaCell_h
#define MediaCell_h

#import <UIKit/UIKit.h>

@interface MediaCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UIImageView *mediaUIImange;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;

@end
#endif /* MediaCell_h */
