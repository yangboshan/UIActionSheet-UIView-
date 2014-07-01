//
//  STDActionSheet.h
//  Stdecaux
//
//  Created by yangboshan on 14-7-1.
//  Copyright (c) 2014年 Logic Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUApp-Macro.h"

@class STDActionSheet;

@protocol STDActionSheetDelegate <NSObject>

-(void) actionSheet:(STDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface STDActionSheet : UIView

-(id)initWithTitle:(NSString*)title delegate:(id<STDActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

-(void)showActionSheet;

@end
