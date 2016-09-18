//
//  CshopTableViewCell.m
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CshopTableViewCell.h"

@implementation CshopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_rating setImageDeselected:@"star2"
                  halfSelected:@"starB"
                  fullSelected:@"rating_show"
                   andDelegate:self];
    _rating.isIndicator = YES;
}
- (void)ratingChanged:(float)newRating
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
