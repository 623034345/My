//
//  TableViewCell.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _Rating.isBig = YES;
    
    [_Rating setImageDeselected:@"star2"
                     halfSelected:@"starB"
                     fullSelected:@"rating_show"
                      andDelegate:self];
    _Rating.isIndicator = YES;
}
- (void)ratingChanged:(float)newRating
{
    
}
- (CGFloat)viewHeightWithView:(UIView *)view
{
    [view sizeToFit];
    return CGRectGetHeight(view.frame);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
