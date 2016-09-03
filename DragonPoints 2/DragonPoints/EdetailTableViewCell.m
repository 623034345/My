//
//  EdetailTableViewCell.m
//  DragonPoints
//
//  Created by shangce on 16/8/4.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "EdetailTableViewCell.h"

@implementation EdetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_star setImageDeselected:@"star2"
                   halfSelected:@"starB"
                   fullSelected:@"rating_show"
                    andDelegate:self];
    _star.isIndicator = YES;
}
- (void)ratingChanged:(float)newRating
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
