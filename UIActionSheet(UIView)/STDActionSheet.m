//
//  STDActionSheet.m
//  Stdecaux
//
//  Created by yangboshan on 14-7-1.
//  Copyright (c) 2014年 Logic Solutions, Inc. All rights reserved.
//

#import "STDActionSheet.h"

@interface STDActionSheet()

@property (nonatomic,strong) UIView* sheetView;

@property (nonatomic,weak) id<STDActionSheetDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *titleList;
@property (nonatomic,assign) NSInteger buttonCount;

@end

@implementation STDActionSheet

#define MARGIN_X 20
#define MARGIN_Y 20
#define MARGIN_TOP 30
#define MARGIN_BOTTOM MARGIN_TOP
#define BUTTON_SPACE 10
#define BUTTON_HEIGHT 50

-(id)initWithTitle:(NSString *)title delegate:(id<STDActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight);
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        _delegate = delegate;
        
        UITapGestureRecognizer* tapCancelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [tapCancelGesture setNumberOfTapsRequired:1];
        [self addGestureRecognizer:tapCancelGesture];
        [self setUserInteractionEnabled:YES];
        
        _titleList = [NSMutableArray array];
        
        if (destructiveButtonTitle) {
            [_titleList addObject:destructiveButtonTitle];
            _buttonCount++;
        }
        if (otherButtonTitles) {
            [_titleList addObjectsFromArray:otherButtonTitles];
            _buttonCount+= otherButtonTitles.count;
        }
        if (cancelButtonTitle) {
            [_titleList addObject:cancelButtonTitle];
            _buttonCount++;
        }
        _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              ScreenHeight,
                                                              ScreenWidth,
                                                              0)];
        _sheetView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_sheetView];
        
        for (int i = 0; i < _buttonCount; i++) {
            
            UIButton *actionSheetButton = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_X,
                                                                                     MARGIN_Y + i*(BUTTON_HEIGHT + BUTTON_SPACE),
                                                                                     ScreenWidth - 2*MARGIN_X,
                                                                                     BUTTON_HEIGHT)];
            
            actionSheetButton.layer.masksToBounds = YES;
            actionSheetButton.layer.cornerRadius = 2;
            actionSheetButton.layer.borderWidth = 0.5f;
            actionSheetButton.tag = i;
            
            actionSheetButton.layer.borderColor = RGBA(0,0,0,0.2).CGColor;
            actionSheetButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            
            [actionSheetButton setTitle:_titleList[i] forState:UIControlStateNormal];
            [actionSheetButton addTarget:self action:@selector(actionButtonTapped:)
                        forControlEvents:UIControlEventTouchUpInside];
            
            [actionSheetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [actionSheetButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            
            // is cancel button
            if (cancelButtonTitle && (i == _buttonCount - 1)) {
                [actionSheetButton setBackgroundColor:RGB(25, 193, 253)];
                [actionSheetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [actionSheetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                
                actionSheetButton.layer.borderColor = RGBA(0,
                                                           0,
                                                           0,
                                                           0.0).CGColor;
            }
            
            // destructive button
            if (destructiveButtonTitle && !i) {
                [actionSheetButton setBackgroundColor:[UIColor redColor]];
                [actionSheetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [actionSheetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                
                actionSheetButton.layer.borderColor = RGBA(0,
                                                           0,
                                                           0,
                                                           0.0).CGColor;
            }
            
            [_sheetView addSubview:actionSheetButton];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [_sheetView setFrame:CGRectMake(0,
                                            ScreenHeight - (_buttonCount*BUTTON_HEIGHT + 2*MARGIN_TOP + BUTTON_SPACE*(_buttonCount-1)),
                                            ScreenWidth,
                                            _buttonCount*BUTTON_HEIGHT + 2*MARGIN_TOP + BUTTON_SPACE*(_buttonCount-1))];
        } completion:^(BOOL finished) {
        }];
    }
    return self;
}

-(void)actionButtonTapped:(UIButton*)sender{
    
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:sender.tag];
    }
    [self tappedCancel];
}


-(void)showActionSheet{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

- (void)tappedCancel
{
    [UIView animateWithDuration:0.25 animations:^{
        
        [_sheetView setFrame:CGRectMake(0,
                                        ScreenHeight,
                                        ScreenWidth,
                                        0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
