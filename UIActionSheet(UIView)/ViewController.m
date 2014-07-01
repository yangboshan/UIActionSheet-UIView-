//
//  ViewController.m
//  UIActionSheet(UIView)
//
//  Created by yangboshan on 14-7-1.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "STDActionSheet.h"


@interface ViewController ()<STDActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

}

-(void)actionSheet:(STDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionSheet:(id)sender {
    STDActionSheet* actionSheet = [[STDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@[@"拍照",@"从手机相册选择"]];
    [actionSheet showActionSheet];
}
@end
