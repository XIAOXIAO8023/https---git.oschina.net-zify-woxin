//
//  LeeSegmentedControl.m
//  JscnMboss
//
//  Created by Lee on 13-12-19.
//  Copyright (c) 2013年 asiainfo-linkage. All rights reserved.
//

#import "LeeSegmentedControl.h"
#define segment_corner 0.0

@interface LeeSegmentedControl()
@property (nonatomic,strong) NSMutableArray *segments;
@property (nonatomic) NSUInteger currentSelected;
@property (nonatomic,strong) NSMutableArray *separators;
@property (nonatomic,copy) selectionBlock selBlock;
@end


@implementation LeeSegmentedControl
@synthesize delegate = _delegate;
@synthesize iconPosition = _iconPosition;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items iconPosition:(IconPosition)position andSelectionBlock:(selectionBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Selection block
        _selBlock=block;
        
        //Background Color
        self.backgroundColor=[UIColor whiteColor];
        
        //初始化
        CGFloat buttonWidth = frame.size.width/items.count;
        NSInteger itemNum=0;
        for(NSDictionary *item in items){
            NSString *text=item[@"text"];
            NSString *icon=item[@"icon"];
            
            //根据需要重组界面
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonWidth*itemNum, 0, buttonWidth, frame.size.height);
            button.tag = VIEW_TAG_START + 10*itemNum;
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.segments addObject:button];
            //添加图片 后续添加
            
            //添加文字
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.borderWidth, 0.0f, buttonWidth-self.borderWidth*2, frame.size.height-2.0f)];
            label.tag = VIEW_TAG_START + 10*itemNum + 1;
            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
            [label setBackgroundColor:[UIColor clearColor]];
            label.text = text;
            
            //添加VIEW
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.borderWidth, frame.size.height-2.0f, buttonWidth-self.borderWidth*2, 2.0f)];
            line.tag = VIEW_TAG_START + 10*itemNum + 2;
            line.backgroundColor = [UIColor whiteColor];
            
            //Adding to self view
            [button addSubview:label];
            [button addSubview:line];
            [self addSubview:button];
            
            //Adding separator
            if((itemNum!=0)&&(itemNum<items.count)){
                UIView *separatorView=[[UIView alloc] initWithFrame:CGRectMake(itemNum*buttonWidth, 0, self.borderWidth, frame.size.height)];
                [self addSubview:separatorView];
                [self.separators addObject:separatorView];
            }
            
            itemNum++;
        }

        //Applying corners
//        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=segment_corner;
        
        //Default selected 0
        _currentSelected=0;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items iconPosition:(IconPosition)position andLines:(NSInteger)lines andSelectionBlock:(selectionBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Selection block
        _selBlock=block;
        
        //Background Color
        self.backgroundColor=[UIColor whiteColor];
        
        //初始化
        CGFloat buttonWidth = frame.size.width/(items.count/lines);
        CGFloat buttonHeight = frame.size.height/lines;
        NSInteger itemNum=0;
        for(NSDictionary *item in items){
            NSString *text=item[@"text"];
            NSString *icon=item[@"icon"];
            
            NSInteger yRowNum = itemNum/(items.count/lines);
            NSInteger xRowNum = itemNum%(items.count/lines);
            
            //根据需要重组界面
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonWidth*xRowNum, buttonHeight*yRowNum, buttonWidth, buttonHeight);
            button.tag = VIEW_TAG_START + 100 + 10*itemNum;
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.segments addObject:button];
            //添加图片 后续添加
            
            //添加文字
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.borderWidth, 0.0f, buttonWidth-self.borderWidth*2, buttonHeight-2.0f)];
            label.tag = VIEW_TAG_START + 100 + 10*itemNum + 1;
            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
            [label setBackgroundColor:[UIColor clearColor]];
            label.text = text;
            
            //添加VIEW
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.borderWidth, buttonHeight-2.0f, buttonWidth-self.borderWidth*2, 2.0f)];
            line.tag = VIEW_TAG_START + 100 + 10*itemNum + 2;
            line.backgroundColor = [UIColor whiteColor];
            
            //Adding to self view
            [button addSubview:label];
            [button addSubview:line];
            [self addSubview:button];
            
            //Adding separator
            if((xRowNum!=0)&&(xRowNum<(items.count/lines))){
                UIView *separatorView=[[UIView alloc] initWithFrame:CGRectMake(xRowNum*buttonWidth, buttonHeight*yRowNum, self.borderWidth, buttonHeight)];
                [self addSubview:separatorView];
                [self.separators addObject:separatorView];
            }
            
            itemNum++;
        }
        
        //Applying corners
        //        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=segment_corner;
        
        //Default selected 0
        _currentSelected=0;
        
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame items:(NSArray *)items iconPosition:(IconPosition)position andSelectionBlock:(selectionBlock)block andCurrentSelected:(NSInteger)currentSelected{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Selection block
        _selBlock=block;
        
        //Background Color
        self.backgroundColor=[UIColor whiteColor];
        
        //初始化
        CGFloat buttonWidth = frame.size.width/items.count;
        NSInteger itemNum=0;
        for(NSDictionary *item in items){
            NSString *text=item[@"text"];
            NSString *icon=item[@"icon"];
            
            //根据需要重组界面
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonWidth*itemNum, 0, buttonWidth, frame.size.height);
            button.tag = VIEW_TAG_START + 10*itemNum;
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.segments addObject:button];
            //添加图片 后续添加
            
            //添加文字
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.borderWidth, 0.0f, buttonWidth-self.borderWidth*2, frame.size.height-2.0f)];
            label.tag = VIEW_TAG_START + 10*itemNum + 1;
            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
            [label setBackgroundColor:[UIColor clearColor]];
            label.text = text;
            
            //添加VIEW
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.borderWidth, frame.size.height-2.0f, buttonWidth-self.borderWidth*2, 2.0f)];
            line.tag = VIEW_TAG_START + 10*itemNum + 2;
            line.backgroundColor = [UIColor whiteColor];
            
            //Adding to self view
            [button addSubview:label];
            [button addSubview:line];
            [self addSubview:button];
            
            //Adding separator
            if((itemNum!=0)&&(itemNum<items.count)){
                UIView *separatorView=[[UIView alloc] initWithFrame:CGRectMake(itemNum*buttonWidth, 0, self.borderWidth, frame.size.height)];
                [self addSubview:separatorView];
                [self.separators addObject:separatorView];
            }
            
            itemNum++;
        }
        
        //Applying corners
        //        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=segment_corner;
        
        //Default selected 0
        _currentSelected=currentSelected;
        
    }
    return self;
}

#pragma mark - Lazy instantiations
-(NSMutableArray*)segments{
    if(!_segments)_segments=[[NSMutableArray alloc] init];
    return _segments;
}
-(NSMutableArray*)separators{
    if(!_separators)_separators=[[NSMutableArray alloc] init];
    return _separators;
}
#pragma mark - Actions
-(void)segmentSelected:(id)sender{
    if(sender){
        NSUInteger selectedIndex=[self.segments indexOfObject:sender];
        [self setEnabled:YES forSegmentAtIndex:selectedIndex];
        UIButton *button = (UIButton *) sender;
        if (@selector(SelectSegmentedControlAtIndex:)) {
            [self.delegate SelectSegmentedControlAtIndex:(NSInteger)(button.tag-VIEW_TAG_START)/10];
        }
        
        //Calling block
        if(self.selBlock){
            self.selBlock(selectedIndex);
        }
    }
}

#pragma mark - Getters
/**
 *	Returns if a specified segment is selected
 *
 *	@param	index	Index of segment to check
 *
 *	@return	BOOL selected
 */
-(BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index{
    return (index==self.currentSelected);
}

#pragma mark - Setters
-(void)updateSegmentsFormat{
    //Setting border color
    if(self.borderColor){
//        self.layer.borderWidth=self.borderWidth;
//        self.layer.borderColor=self.borderColor.CGColor;
    }else{
        self.layer.borderWidth=0;
    }
    
    //Updating segments color
    for(UIView *separator in self.separators){
        separator.backgroundColor=self.borderColor;
        separator.frame=CGRectMake(separator.frame.origin.x, separator.frame.origin.y,self.borderWidth , separator.frame.size.height);
    }
    
    //Modifying buttons with current State
    for (UIButton *segment in self.segments){
        
        //Setting format depending on if it's selected or not
        if([self.segments indexOfObject:segment]==self.currentSelected){
            //Selected-one
            UILabel *label = (UILabel *)[self viewWithTag:segment.tag+1];
            UIView *line = (UIView *)[self viewWithTag:segment.tag+2];
            if(self.selectedColor)
            {
//                label.textColor = self.selectedColor;
                label.backgroundColor = self.selectedColor;
//                line.backgroundColor = self.selectedColor;
//                self.backgroundColor =self.selectedColor;
                label.textColor = [UIColor whiteColor];
            }
            if (self.textFont) {
                label.font = self.textFont;
            }
            if (self.lineColor) {
                line.backgroundColor = self.lineColor;
            }
        }else{
            //Non selected
            UILabel *label = (UILabel *)[self viewWithTag:segment.tag+1];
            UIView *line = (UIView *)[self viewWithTag:segment.tag+2];
            if(self.color)
            {
            }
            if (self.backgroundColor) {
                label.backgroundColor = self.backgroundColor;
            }
            if (self.textColor) {
                label.textColor = self.textColor;
            }
            if (self.lineColor) {
                line.backgroundColor = self.lineColor;
            }
            if (self.textFont) {
                label.font = self.textFont;
            }
        }
    }
}
-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor=selectedColor;
    [self updateSegmentsFormat];
}
-(void)setColor:(UIColor *)color{
    _color=color;
    [self updateSegmentsFormat];
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor=textColor;
    [self updateSegmentsFormat];
}
-(void)setLineColor:(UIColor *)lineColor{
    _lineColor=lineColor;
    [self updateSegmentsFormat];
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth=borderWidth;
    [self updateSegmentsFormat];
}

-(void)setBorderColor:(UIColor *)borderColor{
    //Setting boerder color to all view
    _borderColor=borderColor;
    [self updateSegmentsFormat];
}
-(void)setTextFont:(UIFont *)textFont{
    _textFont=textFont;
    [self updateSegmentsFormat];
}
/**
 *	Method for select/unselect a segment
 *
 *	@param	enabled	BOOL if the given segment has to be enabled/disabled ( currently disable option is not enabled )
 *	@param	segment	Segment to be selected/unselected
 */
-(void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment{
    if(enabled){
        self.currentSelected=segment;
        [self updateSegmentsFormat];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
