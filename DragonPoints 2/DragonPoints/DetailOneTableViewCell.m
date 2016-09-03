//
//  DetailOneTableViewCell.m
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "DetailOneTableViewCell.h"

@implementation DetailOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_Rating setImageDeselected:@"star2"
                   halfSelected:@"starB"
                   fullSelected:@"rating_show"
                    andDelegate:self];
    _Rating.isIndicator = YES;

}
- (void)ratingChanged:(float)newRating
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
