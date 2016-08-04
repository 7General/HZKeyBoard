//
//  MainViewController.m
//  MemaryBase
//
//  Created by 王会洲 on 16/8/2.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MainViewController.h"
#import "KeyBoardConfig.h"
#import "PushViewController.h"
#import "HZCommanFunc.h"

typedef enum : NSUInteger {
    firstText,
    SecText,
    ThirdText,
    FourthText,
} selectTextType;


@interface MainViewController ()<KeyBoardShowViewDelegate,UITextFieldDelegate>
@property (nonatomic, weak) UITextField * inputFiled;
@property (nonatomic, weak) UITextField * inputFiled2;
@property (nonatomic, weak) UITextField * inputFiled3;
@property (nonatomic, weak) UITextField * inputFiled4;

@property (nonatomic, strong) KeyBoardView * keyBoardView;
@property (nonatomic, strong) NSString * pleaceText;



@property (nonatomic, assign) selectTextType  selectType;

@property (nonatomic, strong) NSString * phoneTextPleace;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pleaceText = @"";
    
    self.keyBoardView = [KeyBoardView KeyBoardMenu];
    self.keyBoardView.delegate = self;
    
    UITextField * inputFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    inputFiled.borderStyle = UITextBorderStyleRoundedRect;
    inputFiled.delegate = self;
    [self.view addSubview:inputFiled];
    self.inputFiled = inputFiled;
    self.inputFiled.inputView = [self.keyBoardView NumberKeyBoardShowView];
    
    
    UIButton * pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(10, 150, 50, 50);
    pushButton.backgroundColor = [UIColor redColor];
    [pushButton addTarget:self action:@selector(GoView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    UITextField * inputFiled2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 210, 300, 40)];
    inputFiled2.borderStyle = UITextBorderStyleRoundedRect;
    inputFiled2.delegate = self;
    [self.view addSubview:inputFiled2];
    self.inputFiled2 = inputFiled2;
    self.inputFiled2.inputView = [self.keyBoardView NumberKeyBoardShowView];
    
    UITextField * inputFiled3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 260, 300, 40)];
    inputFiled3.borderStyle = UITextBorderStyleRoundedRect;
    inputFiled3.delegate = self;
    [self.view addSubview:inputFiled3];
    self.inputFiled3 = inputFiled3;
    self.inputFiled3.inputView = [self.keyBoardView NumberKeyBoardShowView];
    
    UITextField * inputFiled4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 310, 300, 40)];
    inputFiled4.borderStyle = UITextBorderStyleRoundedRect;
    inputFiled4.delegate = self;
    [self.view addSubview:inputFiled4];
    self.inputFiled4 = inputFiled4;
    self.inputFiled4.inputView = [self.keyBoardView NumberKeyBoardShowView];
    
    //[self tranceBaseToString];
    
    
#ifndef DEBUG
    NSLog(@"----44444444输入数据");
#endif
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.inputFiled) {
        self.keyBoardView.TextSelectPostion = TextFiledFirst;
    }
    if (textField == self.inputFiled2) {
        self.keyBoardView.TextSelectPostion = TextFiledSecond;
    }
    if (textField == self.inputFiled3) {
        self.keyBoardView.TextSelectPostion = TextFiledThird;
    }
    if (textField == self.inputFiled4) {
        self.keyBoardView.TextSelectPostion = TextFiledFourth;
    }
}




-(void)GoView {
    PushViewController * push = [[PushViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
    
    NSDictionary * dict = @{@"phone":[self tranceBaseToString]};
}


-(void)getKeyBoardViewValueFromButton:(NSString * )ButtonTxt DidSelectButTag:(NSInteger) BtnTag {
    NSLog(@"----输入数据：%@",ButtonTxt);
    self.pleaceText = [self returnByArryCount:ButtonTxt];
    self.inputFiled.text = self.pleaceText;
    self.phoneTextPleace = ButtonTxt;
}

- (void)getSecondKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag {
    NSLog(@"----222222输入数据：%@",ButtonTxt);
    self.inputFiled2.text = [self returnByArryCount:ButtonTxt];
}
- (void)getThirdKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag {
    NSLog(@"----33333输入数据：%@",ButtonTxt);
    self.inputFiled3.text = [self returnByArryCount:ButtonTxt];
}

- (void)getFourthKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag {
    NSLog(@"----44444444输入数据：%@",ButtonTxt);
    self.inputFiled4.text = [self returnByArryCount:ButtonTxt];
}



-(NSString *)returnByArryCount:(NSString *)text {
    NSString * strRetun = @"";
    if ([text isEqualToString:@"~"]) {
        strRetun = @"";
    }else {
        NSArray * tempArry = [text componentsSeparatedByString:@","];
        for (NSInteger index = 0; index < tempArry.count; index++) {
            strRetun = [strRetun stringByAppendingString:@"*"];
        }
    }
   return strRetun;
}
-(NSString *)tranceBaseToString {
  NSString * resStr = @"";
    for (NSString * item in [self.phoneTextPleace componentsSeparatedByString:@","]) {
        resStr = [resStr stringByAppendingString:__TEXT(item)];
    }
    return resStr;
}
@end
