//
//  LeeSegmentedControl.h
//  JscnMboss
//
//  Created by Lee on 13-12-19.
//  Copyright (c) 2013年 asiainfo-linkage. All rights reserved.
//  分段控件

#import <UIKit/UIKit.h>
#define VIEW_TAG_START 8000

typedef enum {
    IconPositionRight,
    IconPositionLeft,
} IconPosition;

typedef void(^selectionBlock)(NSUInteger segmentIndex);//自定义block

@protocol LeeSegmentedControlDelegate <NSObject>

@required

@optional
-(void)SelectSegmentedControlAtIndex:(NSInteger)index;

@end

@interface LeeSegmentedControl : UIView

@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) IconPosition iconPosition;
@property (assign,nonatomic)id<LeeSegmentedControlDelegate> delegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items iconPosition:(IconPosition)position andSelectionBlock:(selectionBlock)block;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items iconPosition:(IconPosition)position andLines:(NSInteger)lines andSelectionBlock:(selectionBlock)block;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items iconPosition:(IconPosition)position andSelectionBlock:(selectionBlock)block andCurrentSelected:(NSInteger)currentSelected;

@end
