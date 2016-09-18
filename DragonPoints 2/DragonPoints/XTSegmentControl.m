//
//  SegmentControl.m
//  GT
//
//  Created by tage on 14-2-26.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "XTSegmentControl.h"

static float XTSegmentControlHspace;

#define XTSegmentControlItemFont (15.0f)

#define XTSegmentControlLineHeight (3)

#define XTSegmentControlAnimationTime (0.3)

#define ItemSelectedColor UICOLOR_HEX(0xea4b35)

#define ItemNormalColor UICOLOR_HEX(0x2d3e52)

@interface XTSegmentControlItem : UIView

@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation XTSegmentControlItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) - XTSegmentControlHspace, CGRectGetHeight(self.bounds));
            label.font = UIFONT(XTSegmentControlItemFont);
            label.text = title;
            label.textColor = ItemNormalColor;
            label.backgroundColor = [UIColor clearColor];
            label;
        });
        [self addSubview:_titleLabel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface XTSegmentControl ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *contentView;

@property (nonatomic , strong) UIView *leftShadowView;

@property (nonatomic , strong) UIView *rightShadowView;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) NSMutableArray *itemFrames;

@property (nonatomic , strong) NSMutableArray *items;

@property (nonatomic) NSInteger currentIndex;

@property (nonatomic , assign) id <XTSegmentControlDelegate> delegate;

@property (nonatomic , copy) XTSegmentControlBlock block;

@end

@implementation XTSegmentControl

- (id)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem
{
    if (self = [super initWithFrame:frame]) {
        
        _contentView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            scrollView.backgroundColor = [UIColor clearColor];
            scrollView.delegate = self;
            scrollView.showsHorizontalScrollIndicator = NO;
            [self addSubview:scrollView];
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
            [scrollView addGestureRecognizer:tapGes];
            [tapGes requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
            scrollView;
        });
        
        _leftShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, CGRectGetHeight(self.bounds))];
        _leftShadowView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [self addSubview:_leftShadowView];
        
        _rightShadowView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contentView.frame), 0, 0.5, CGRectGetHeight(self.bounds))];
        _rightShadowView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [self addSubview:_rightShadowView];
        
        [self initItemsWithTitleArray:titleItem];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id<XTSegmentControlDelegate>)delegate
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.block = selectedHandle;
    }
    return self;
}

- (void)doTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    
    __weak typeof(self) weakSelf = self;
    
    [_itemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGRect rect = [obj CGRectValue];
        
        if (CGRectContainsPoint(rect, point)) {
            
            [weakSelf selectIndex:idx];
            
            [weakSelf transformAction:idx];
            
            *stop = YES;
        }
    }];
}

- (void)transformAction:(NSInteger)index
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(XTSegmentControlDelegate)] && [self.delegate respondsToSelector:@selector(segmentControl:selectedIndex:)]) {
        
        [self.delegate segmentControl:self selectedIndex:index];
        
    }else if (self.block) {
        
        self.block(index);
    }
}

- (void)initItemsWithTitleArray:(NSArray *)titleArray
{
    _itemFrames = @[].mutableCopy;
    _items = @[].mutableCopy;
    float spaceLength = 0;
    for (NSString *title in titleArray) {
#ifdef __IPHONE_7_0
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:(15.0f)]}];
//                NSLog(@"尺寸：%@",[title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:(15.0f)]}]);

#else
        CGSize size = [title sizeWithFont:FONT(XTSegmentControlItemFont)];
#endif
        spaceLength += size.width;
    }
    XTSegmentControlHspace = (SCREEN_WIDTH - spaceLength)/(titleArray.count + 1);
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i]; 
#ifdef __IPHONE_7_0
//         CGSize size = CGSizeMake([SCREEN_WIDTH / titleArray.count,2], 2);
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:(15.0f)]}];
#else
        CGSize size = [title sizeWithFont:FONT(XTSegmentControlItemFont)];
#endif
        
        float x = i > 0 ? CGRectGetMaxX([_itemFrames[i-1] CGRectValue]) : XTSegmentControlHspace;
        float y = 0;
        float width = XTSegmentControlHspace + size.width + 10;
        float height = CGRectGetHeight(self.bounds);
        CGRect rect = CGRectMake(x, y, width, height);
        [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
    }
    
    for (int i = 0; i < titleArray.count; i++) {
        CGRect rect = [_itemFrames[i] CGRectValue];
        NSString *title = titleArray[i];
        XTSegmentControlItem *item = [[XTSegmentControlItem alloc] initWithFrame:rect title:title];
        item.backgroundColor = [UIColor clearColor];
        if (i == 0) {
            item.titleLabel.textColor = ItemSelectedColor;
        }
        [_items addObject:item];
        [_contentView addSubview:item];
    }

    [_contentView setContentSize:CGSizeMake(CGRectGetMaxX([[_itemFrames lastObject] CGRectValue]), CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectIndex:0];
    
    [self resetShadowView:_contentView];
}

- (void)addRedLine
{
    if (!_lineView&&_hadLine == YES) {
        CGRect rect = [_itemFrames[0] CGRectValue];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - XTSegmentControlHspace, XTSegmentControlLineHeight)];
        _lineView.layer.cornerRadius = 2;
        _lineView.backgroundColor = ItemSelectedColor;
        [_contentView addSubview:_lineView];
    }
}

- (void)selectIndex:(NSInteger)index
{
    [self addRedLine];
    
    if (index != _currentIndex) {
        
        CGRect rect = [_itemFrames[index] CGRectValue];
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect), CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - XTSegmentControlHspace, XTSegmentControlLineHeight);
        [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
            _lineView.frame = lineRect;
        }];
        for (int i = 0; i<_items.count; i++) {
            XTSegmentControlItem *item = _items[i];
            if (i == index) {
                item.titleLabel.textColor = ItemSelectedColor;
            }else{
                item.titleLabel.textColor = ItemNormalColor;
            }
        }
        _currentIndex = index;
    }
    [self setScrollOffset:index];
}

- (void)moveIndexWithProgress:(float)progress
{
    float delta = progress - _currentIndex;

    CGRect origionRect = [_itemFrames[_currentIndex] CGRectValue];;
    
    
    CGRect origionLineRect = CGRectMake(CGRectGetMinX(origionRect), CGRectGetHeight(origionRect) - XTSegmentControlLineHeight, CGRectGetWidth(origionRect) - XTSegmentControlHspace, XTSegmentControlLineHeight);
    
    CGRect rect;
    
    if (delta > 0) {
        
        if (_currentIndex == _itemFrames.count - 1) {
            return;
        }
        
        rect = [_itemFrames[_currentIndex + 1] CGRectValue];
        
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect), CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) -XTSegmentControlHspace, XTSegmentControlLineHeight);
        
        CGRect moveRect = CGRectZero;
        
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) + delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        
        _lineView.frame = moveRect;
        
        _lineView.center = CGPointMake(CGRectGetMidX(origionLineRect) + delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)), CGRectGetMidY(origionLineRect));
        
        if (delta > 1) {
            
            _currentIndex ++;
        }
        
    }else if (delta < 0){
        
        if (_currentIndex == 0) {
            return;
        }
        
        rect = [_itemFrames[_currentIndex - 1] CGRectValue];
        
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect), CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - XTSegmentControlHspace, XTSegmentControlLineHeight);
        
        CGRect moveRect = CGRectZero;
        
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) - delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        
        _lineView.frame = moveRect;
        
        _lineView.center = CGPointMake(CGRectGetMidX(origionLineRect) - delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)), CGRectGetMidY(origionLineRect));

        if (delta < -1) {
            
            _currentIndex --;
        }
    }    
}

- (void)endMoveIndex:(NSInteger)index
{
    [self selectIndex:index];
}

- (void)setScrollOffset:(NSInteger)index
{
    CGRect rect = [_itemFrames[index] CGRectValue];

    float midX = CGRectGetMidX(rect);
    
    float offset = 0;
    
    float contentWidth = _contentView.contentSize.width;
    
    float halfWidth = CGRectGetWidth(self.bounds) / 2.0;
    
    if (midX < halfWidth) {
        offset = 0;
    }else if (midX > contentWidth - halfWidth){
        offset = contentWidth - 2 * halfWidth;
    }else{
        offset = midX - halfWidth;
    }
    [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
        [_contentView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resetShadowView:scrollView];
}

- (void)resetShadowView:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0) {
        
        _leftShadowView.hidden = NO;
        
        if (scrollView.contentOffset.x == scrollView.contentSize.width - CGRectGetWidth(scrollView.bounds)) {
            _rightShadowView.hidden = YES;
        }else{
            _rightShadowView.hidden = NO;
        }
        
    }else if (scrollView.contentOffset.x == 0) {
        _leftShadowView.hidden = YES;
        if (_contentView.contentSize.width < CGRectGetWidth(_contentView.frame)) {
            _rightShadowView.hidden = YES;
        }else{
            _rightShadowView.hidden = NO;
        }
    }
}


int ExceMinIndex(float f)
{
    int i = (int)f;
    if (f != i) {
        return i+1;
    }
    return i;
}

@end

