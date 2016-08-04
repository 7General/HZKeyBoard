//
//  KeyBoardView.m
//  KeyBoard
//
//  Created by 王会洲 on 16/1/11.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "KeyBoardView.h"
#import "UIImage+FitWithImage.h"
#import "UIControl+Category.h"
#import "HZCommanFunc.h"





@interface KeyBoardView ()




/** 控制面板 */
@property (nonatomic, strong) UIView * KeyBoardConsoleView;

/** 数字按钮 */
@property(nonatomic,strong)UIButton * NumberBtn;

/**  字符按钮*/
@property(nonatomic,strong)UIButton * CharacterBtn;

/**中文按钮*/
@property(nonatomic,strong)UIButton * EnglishBtn;


/**数字键盘数据源*/
@property (nonatomic, strong) NSMutableArray * numberArray;
/**  字符加盘数据源*/
@property (nonatomic, strong) NSMutableArray * CharacterArry;
@property (nonatomic, strong) NSMutableArray * SmallCharacterArry;
/** 符号键盘数据源*/
@property (nonatomic, strong) NSMutableArray * EnglishArry;


@end
@implementation KeyBoardView

-(UIView *)KeyBoardConsoleView {
    if (!_KeyBoardConsoleView) {
        _KeyBoardConsoleView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-KeyBoardHeightScale , SCREEN_WIDTH, KeyBoardHeightScale)];
        
        
        _KeyBoardConsoleView.backgroundColor = [UIColor colorWithRed:210/255.0f green:213/255.0f blue:219/255.0f alpha:1];
    }
    return _KeyBoardConsoleView;
}
/**
 *  数字键盘
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)numberArray {
    if (!_numberArray) {
        _numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"切换",@"0",@"删除"].mutableCopy;
    }
    return _numberArray;
}

-(NSMutableArray *)CharacterArry {
    if (!_CharacterArry) {
        _CharacterArry = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"大",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删",@"123",@"中",@"空格",@"换行"].mutableCopy;
    }
    return _CharacterArry;
}

-(NSMutableArray *)SmallCharacterArry {
    if (!_SmallCharacterArry) {
        _SmallCharacterArry = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"小",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"删",@"123",@"中",@"空格",@"换行"].mutableCopy;
    }
    return _SmallCharacterArry;
}

-(NSMutableArray *)EnglishArry {
    if (!_EnglishArry) {
        _EnglishArry = @[@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"_",@"-",@"+",@"=",@"|",@"(",@")",@"[",@"]",@"{",@"}",@";",@":",@"?",@"/",@"<",@">",@",",@".",@"~",@"删",@"123",@"英",@"空格",@"return"].mutableCopy;
    }
    return _EnglishArry;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
        self.OtherConnectStr = self.ConnectStr = @"";
        self.OtherJumpStr = self.JumpStr = @"";
        
        self.OtherselectState = self.selectState = YES;
        self.DeleteDone = NO;
        
        // ******第二项数据
        self.ConnectStrSecond = self.JumpStrSecond = @"";
        self.DeleteDoneSecond = NO;
        
        // ******第三项数据
        self.ConnectStrThird = self.JumpStrThird = @"";
        self.DeleteDoneThird = NO;
        
        // ******第四项数据
        self.ConnectStrFourth = self.JumpStrFourth = @"";
        self.DeleteDoneFourth = NO;
        /**
         *  默认为选项一
         */
        self.TextSelectPostion = TextFiledFirst;
    }
    return self;
}


+ (instancetype)KeyBoardMenu {
    return [[self alloc] init];
}


-(UIView *)NumberKeyBoardShowView {
    
    for (UIView * subView in self.KeyBoardConsoleView.subviews) {
        [subView removeFromSuperview];
    }
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 4; j++) {
            self.NumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.NumberBtn setFrame:CGRectMake(NumberPaddingHScale + (NumberPaddingHScale + NumberButtonWidthScale) * i, NumberPaddingHScale + (NumberPaddingHScale + NumberButtonHeightScale) * j, NumberButtonWidthScale, NumberButtonHeightScale)];
            
            
            [self.NumberBtn setBackgroundColor:[UIColor whiteColor]];
            //self.NumberBtn.layer.borderWidth = 0.5;
            self.NumberBtn.adjustsImageWhenHighlighted = NO;
            [self.NumberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.NumberBtn.titleLabel.font = KeyBoardNumberFont;
            self.NumberBtn.tag = i +3 *j;
            [self.NumberBtn setTitle:[self.numberArray objectAtIndex:self.NumberBtn.tag] forState:UIControlStateNormal];
            [self.KeyBoardConsoleView addSubview:self.NumberBtn];
            [self.NumberBtn addTarget:self action:@selector(NumberDidSelect:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    
    return self.KeyBoardConsoleView;
}


-(void)NumberDidSelect:(UIButton *)sender {
    // 删除
    if (sender.tag ==11) {
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (![self.ConnectStr isEqualToString:@""]) {
                    NSArray * tempArry = [[self.ConnectStr substringWithRange:NSMakeRange(0, self.ConnectStr.length - 1)] componentsSeparatedByString:@","];
                    /**截取非最后一位*/
                    NSString * NotInlastObjc = @"";
                    for (NSInteger index = 0; index < tempArry.count - 1; index++) {
                        NotInlastObjc = [[NotInlastObjc stringByAppendingString:tempArry[index]] stringByAppendingString:@","];
                    }
                    
                    /**截取完成赋值给connectStr*/
                    self.ConnectStr = NotInlastObjc;
                    self.JumpStr = self.ConnectStr;
                    
                    NSString * resShowStr = IsStrEmpty(self.JumpStr)  ? @"~" : [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)] ;
                    
                    /**赋值删除完成标志*/
                    self.DeleteDone = IsStrEmpty(self.JumpStr);
                    [self runDelegateFromButtonTag:resShowStr andButtonTage:sender.tag];
                }
            }
                break;
            case TextFiledSecond:
            {
                if (![self.ConnectStrSecond isEqualToString:@""]) {
                    
                    NSArray * tempArry = [[self.ConnectStrSecond substringWithRange:NSMakeRange(0, self.ConnectStrSecond.length - 1)] componentsSeparatedByString:@","];
                    /**截取非最后一位*/
                    NSString * NotInlastObjc = @"";
                    for (NSInteger index = 0; index < tempArry.count - 1; index++) {
                        NotInlastObjc = [[NotInlastObjc stringByAppendingString:tempArry[index]] stringByAppendingString:@","];
                    }
                    
                    /**截取完成赋值给connectStr*/
                    self.ConnectStrSecond = NotInlastObjc;
                    self.JumpStrSecond = self.ConnectStrSecond;
                    
                    NSString * resShowStr = IsStrEmpty(self.JumpStrSecond)  ? @"~" : [self.JumpStrSecond substringWithRange:NSMakeRange(0, self.JumpStrSecond.length - 1)] ;
                    /**赋值删除完成标志*/
                    self.DeleteDoneSecond = IsStrEmpty(self.JumpStrSecond);
                    [self runSecondDelegateFromButtonTag:resShowStr andButtonTage:sender.tag];
                }
            }
                break;
                
            case TextFiledThird:
            {
                if (![self.ConnectStrThird isEqualToString:@""]) {
                    NSArray * tempArry = [[self.ConnectStrThird substringWithRange:NSMakeRange(0, self.ConnectStrThird.length - 1)] componentsSeparatedByString:@","];
                    /**截取非最后一位*/
                    NSString * NotInlastObjc = @"";
                    for (NSInteger index = 0; index < tempArry.count - 1; index++) {
                        NotInlastObjc = [[NotInlastObjc stringByAppendingString:tempArry[index]] stringByAppendingString:@","];
                    }
                    
                    /**截取完成赋值给connectStr*/
                    self.ConnectStrThird = NotInlastObjc;
                    self.JumpStrThird = self.ConnectStrThird;
                    
                    NSString * resShowStr = IsStrEmpty(self.JumpStrThird)  ? @"~" : [self.JumpStrThird substringWithRange:NSMakeRange(0, self.JumpStrThird.length - 1)] ;
                    /**赋值删除完成标志*/
                    self.DeleteDoneThird = IsStrEmpty(self.JumpStrThird);
                    [self runThirdDelegateFromButtonTag:resShowStr andButtonTage:sender.tag];
                }
            }
                break;
                
            case TextFiledFourth:
            {
                if (![self.ConnectStrFourth isEqualToString:@""]) {
                    NSArray * tempArry = [[self.ConnectStrFourth substringWithRange:NSMakeRange(0, self.ConnectStrFourth.length - 1)] componentsSeparatedByString:@","];
                    /**截取非最后一位*/
                    NSString * NotInlastObjc = @"";
                    for (NSInteger index = 0; index < tempArry.count - 1; index++) {
                        NotInlastObjc = [[NotInlastObjc stringByAppendingString:tempArry[index]] stringByAppendingString:@","];
                    }
                    
                    /**截取完成赋值给connectStr*/
                    self.ConnectStrFourth = NotInlastObjc;
                    self.JumpStrFourth = self.ConnectStrFourth;
                    
                    NSString * resShowStr = IsStrEmpty(self.JumpStrFourth)  ? @"~" : [self.JumpStrFourth substringWithRange:NSMakeRange(0, self.JumpStrFourth.length - 1)] ;
                    /**赋值删除完成标志*/
                    self.DeleteDoneFourth = IsStrEmpty(self.JumpStrFourth);
                    [self runFourthDelegateFromButtonTag:resShowStr andButtonTage:sender.tag];
                }
            }
                break;
                
            default:
                break;
        }
        
        // 切换
    }else if (sender.tag == 9){
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:sender.tag];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            case TextFiledSecond:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getOtherKeyBoardViewValueFromButton:self.OtherJumpStr DidSelectButTag:sender.tag];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            default:
                break;
        }
    }
    // 正常点击
    else{
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                NSString * baseStr = __BASE64([self.numberArray objectAtIndex:sender.tag]);
                self.JumpStr = [[self.ConnectStr stringByAppendingString:baseStr] stringByAppendingString:@","];
                self.ConnectStr = self.JumpStr;
                self.JumpStr = [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)];
//                if (self.DeleteDone && !IsStrEmpty(self.JumpStr)) {
//                    self.JumpStr = [NSString stringWithFormat:@",%@",self.JumpStr];
//                }
                
                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:sender.tag];
            }
                break;
            case TextFiledSecond:
            {
                NSString * baseStr = __BASE64([self.numberArray objectAtIndex:sender.tag]);
                self.JumpStrSecond = [[self.ConnectStrSecond stringByAppendingString:baseStr] stringByAppendingString:@","];
                self.ConnectStrSecond = self.JumpStrSecond;
                self.JumpStrSecond = [self.JumpStrSecond substringWithRange:NSMakeRange(0, self.JumpStrSecond.length - 1)];
//                if (self.DeleteDoneSecond) {
//                    self.JumpStrSecond = [NSString stringWithFormat:@",%@",self.JumpStrSecond];
//                }
                [self runSecondDelegateFromButtonTag:self.JumpStrSecond andButtonTage:sender.tag];
            }
                break;
                
            case TextFiledThird:
            {
                NSString * baseStr = __BASE64([self.numberArray objectAtIndex:sender.tag]);
                self.JumpStrThird = [[self.ConnectStrThird stringByAppendingString:baseStr] stringByAppendingString:@","];
                self.ConnectStrThird = self.JumpStrThird;
                self.JumpStrThird = [self.JumpStrThird substringWithRange:NSMakeRange(0, self.JumpStrThird.length - 1)];
//                if (self.DeleteDoneThird) {
//                    self.JumpStrThird = [NSString stringWithFormat:@",%@",self.JumpStrThird];
//                }
                [self runThirdDelegateFromButtonTag:self.JumpStrThird andButtonTage:sender.tag];
            }
                break;
            case TextFiledFourth:
            {
                NSString * baseStr = __BASE64([self.numberArray objectAtIndex:sender.tag]);
                self.JumpStrFourth = [[self.ConnectStrFourth stringByAppendingString:baseStr] stringByAppendingString:@","];
                self.ConnectStrFourth = self.JumpStrFourth;
                self.JumpStrFourth = [self.JumpStrFourth substringWithRange:NSMakeRange(0, self.JumpStrFourth.length - 1)];
//                if (self.DeleteDoneFourth) {
//                    self.JumpStrFourth = [NSString stringWithFormat:@",%@",self.JumpStrFourth];
//                }
                [self runFourthDelegateFromButtonTag:self.JumpStrFourth andButtonTage:sender.tag];
            }
                break;
                
                
            default:
                break;
        }
        
        
        
    }
    
}
-(UIView *)CharacterKeyBoardShowView {
    /**
     大写字母
     */
    for (UIView * subView in self.KeyBoardConsoleView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i =0; i < 10; i++) {
        for (int j = 0; j < 4; j++) {
            self.CharacterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (j == 0 && i < 10) {
                [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae + i * (CharBtnWidthScale + PaddingRightScale), PaddingTopScale, CharBtnWidthScale, CharBtnHeightScale)];
                self.CharacterBtn.tag = i ;
                [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%d",(int)self.CharacterBtn.tag + CharacterKey]];
                
                
            }else if (j == 1 && i <9 ){
                
                CGFloat secY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j;
                
                
                [self.CharacterBtn setFrame:CGRectMake(MarddingSecondLeftSclae + i * (CharBtnWidthScale + PaddingRightScale), secY, CharBtnWidthScale, CharBtnHeightScale)];
                self.CharacterBtn.tag = i +10 *j ;
                
                [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%d",(int)self.CharacterBtn.tag + CharacterKey]];
                
            }
            else if (j == 2 && i  <9){
                CGFloat thirdY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j;
                if (j== 2 && i == 0) {
                    [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae, thirdY , BigToSmallWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%d",(int)self.CharacterBtn.tag + CharacterKey]];
                    
                }else if(j== 2 && i == 8){
                    [self.CharacterBtn setFrame:CGRectMake(SCREEN_WIDTH - PaddingRightScale - BigToSmallWidthScale,thirdY , BigToSmallWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }else {
                    
                    CGFloat padding =   i !=1? PaddingRightScale :0.0;
                    CGFloat leftDistance = MarddingLeftSclae + BigToSmallWidthScale + PaddingThirdRightScale;
                    
                    [self.CharacterBtn setFrame:CGRectMake(leftDistance+ (i - 1)* (CharBtnWidthScale + padding ), thirdY, CharBtnWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }
                
            }
            else if(j ==3 && i <4){
                CGFloat fourthY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j ;
                
                if (j == 3 && i < 2) {
                    
                    [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae + i * (NumberChnageWidthScale +PaddingRightScale),fourthY  , NumberChnageWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                    
                }else if (j == 3 && i == 2){
                    [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae + i * (NumberChnageWidthScale +PaddingRightScale), fourthY, SpeaceButtonWidthScale, CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }else if(j == 3 && i == 3){
                    [self.CharacterBtn setFrame:CGRectMake(SCREEN_WIDTH - MarddingLeftSclae * 2 - ReturnButtonWidthScale, fourthY, ReturnButtonWidthScale ,CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }
                
                
            }
            //按键背景
            UIImage * CharacterBtnImage = [UIImage imageNamed:@"whiteBack"];
            CharacterBtnImage = [CharacterBtnImage stretchableImageWithLeftCapWidth:CharacterBtnImage.size.width * 0.5 topCapHeight:CharacterBtnImage.size.height * 0.5];
            //按键高亮背景
            UIImage * CharacterBtnHightedImage = [UIImage imageNamed:@"congsoleImage"];
            CharacterBtnHightedImage = [CharacterBtnHightedImage stretchableImageWithLeftCapWidth:CharacterBtnHightedImage.size.width * 0.5 topCapHeight:CharacterBtnHightedImage.size.height * 0.5];
            [self.CharacterBtn setBackgroundImage:CharacterBtnImage forState:UIControlStateNormal];
            [self.CharacterBtn setBackgroundImage:CharacterBtnHightedImage forState:UIControlStateHighlighted];
            
            [self.CharacterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.CharacterBtn.titleLabel.font = KeyBoardFont;
            self.CharacterBtn.adjustsImageWhenHighlighted = NO;
            
            if (self.selectState) {
                //小写
                [self.CharacterBtn setTitle: [self.SmallCharacterArry objectAtIndex:self.CharacterBtn.tag]forState:UIControlStateNormal];
                
            }else{
                //大写
                [self.CharacterBtn setTitle: [self.CharacterArry objectAtIndex:self.CharacterBtn.tag]forState:UIControlStateNormal];
                
            }
            [self.KeyBoardConsoleView addSubview:self.CharacterBtn];
            [self.CharacterBtn addTarget:self action:@selector(CharacterDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return self.KeyBoardConsoleView;
}

-(void)CharacterDidSelect:(UIButton *)sender {
    if (sender.tag == 19) {
        if (self.selectState) {
            //            [sender setTitle:@"小" forState:UIControlStateNormal];
            //            self.CharacterArry[sender.tag] = @"小";
            self.OtherselectState = self.selectState = NO;
            
        }else {
            //            [sender setTitle:@"大" forState:UIControlStateNormal];
            //            self.CharacterArry[sender.tag] = @"大";
            self.OtherselectState =  self.selectState = YES;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
            [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:[sender.OrderTags integerValue]];
            __weak typeof(self) weakSelf = self;
            if (self.BlockChnagkeyBoard) {
                weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
            }
            
        }
        
        //删除
    }else if (sender.tag == 27){
        switch (self.TextSelectPostion) {
                
            case TextFiledFirst:
            {
                if (![self.ConnectStr isEqualToString:@""]) {
                    self.JumpStr = [self.ConnectStr substringToIndex:[self.ConnectStr length]-1];
                    self.ConnectStr = self.JumpStr;
                    [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
                    
                }
            }
                break;
            case TextFiledOther:
            {
                if (![self.OtherConnectStr isEqualToString:@""]) {
                    self.OtherJumpStr = [self.OtherConnectStr substringToIndex:[self.OtherConnectStr length]-1];
                    self.OtherConnectStr = self.OtherJumpStr;
                    [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
                    
                }
            }
                break;
            default:
                break;
        }
        
        
        // 数字
    }else if (sender.tag == 28){
        //        NSLog(@"当前旋转的Textfiled---:%u",self.TextSelectPostion);
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:[sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf NumberKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            case TextFiledOther:
            {
                
                //                NSLog(@"切换数字键");
                if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getOtherKeyBoardViewValueFromButton:self.OtherJumpStr DidSelectButTag:[sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf NumberKeyBoardShowView]);
                    }
                    
                }
            }
            default:
                break;
        }
        
        
        
        
        // 中
    }else if (sender.tag == 29){
        
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:[sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf EnglishKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            case TextFiledOther:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getOtherKeyBoardViewValueFromButton:self.OtherJumpStr DidSelectButTag:[sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf EnglishKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            default:
                break;
        }
        
        // 空格
    }else if (sender.tag == 30){
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                self.JumpStr = [self.ConnectStr stringByAppendingString:@" "];
                self.ConnectStr = self.JumpStr;
                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            case TextFiledOther:
            {
                self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:@" "];
                self.OtherConnectStr = self.OtherJumpStr;
                [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            default:
                break;
        }
        
        
        // return
    }else if (sender.tag == 31){
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                self.JumpStr = [self.ConnectStr stringByAppendingString:@"\n"];
                self.ConnectStr = self.JumpStr;
                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            case TextFiledOther:
            {
                self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:@"\n"];
                self.OtherConnectStr = self.OtherJumpStr;
                [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            default:
                break;
        }
        
        // 正常点击
    }else{
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                //                NSLog(@"点击flag%d",self.selectState);
                if (self.selectState) {
                    //                    NSLog(@"-----大写");
                    self.JumpStr = [self.ConnectStr stringByAppendingString:[self.CharacterArry objectAtIndex:sender.tag]];
                    self.ConnectStr = self.JumpStr;
                    [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
                    
                }else{
                    //                    NSLog(@"小写+++++++");
                    self.JumpStr = [self.ConnectStr stringByAppendingString:[self.SmallCharacterArry objectAtIndex:sender.tag]];
                    self.ConnectStr = self.JumpStr;
                    [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
                }
            }
                break;
            case TextFiledOther:
            {
                //                NSLog(@"点击flag%d",self.OtherselectState);
                if (self.OtherselectState) {
                    //                    NSLog(@"-----大写");
                    self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:[self.CharacterArry objectAtIndex:sender.tag]];
                    self.OtherConnectStr = self.OtherJumpStr;
                    [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
                    
                }else{
                    //                    NSLog(@"小写+++++++");
                    self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:[self.SmallCharacterArry objectAtIndex:sender.tag]];
                    self.OtherConnectStr = self.OtherJumpStr;
                    [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
                }
            }
                break;
            default:
                break;
                
        }
        
        
    }
}

-(UIView *)EnglishKeyBoardShowView {
    
    for (UIView * subView in self.KeyBoardConsoleView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 4; j++) {
            self.EnglishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (j ==2 && i < 9) {
                
                CGFloat secY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j;
                if (j == 2 && i == 0) {
                    
                    [self.EnglishBtn setFrame:CGRectMake(MarddingSecondLeftSclae, secY, CharBtnWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +10*j  ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                    
                } else if (j == 2 && i == 9) {
                    [self.EnglishBtn setFrame:CGRectMake(SCREEN_WIDTH - MarddingSecondLeftSclae - CharBtnWidthScale, secY, CharBtnWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +10*j   ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }else {
                    [self.EnglishBtn setFrame:CGRectMake(MarddingSecondLeftSclae + i * (CharBtnWidthScale + PaddingRightScale), secY, CharBtnWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +10*j  ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }
                
                
            }else if (j == 3 && i < 4){
                
                CGFloat fourthY = PaddingTopScale  + (CharBtnHeightScale + PaddingButtomScale) * j ;
                
                if (j == 3 && i < 2) {
                    
                    [self.EnglishBtn setFrame:CGRectMake(MarddingLeftSclae + i * (NumberChnageWidthScale +PaddingRightScale),fourthY  , NumberChnageWidthScale , CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +9 *j+2  ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                    
                }else if (j == 3 && i == 2){
                    [self.EnglishBtn setFrame:CGRectMake(MarddingLeftSclae + i * (NumberChnageWidthScale +PaddingRightScale), fourthY, SpeaceButtonWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +9 *j+2  ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }else if(j == 3 && i == 3){
                    [self.EnglishBtn setFrame:CGRectMake(SCREEN_WIDTH - MarddingLeftSclae * 2 - ReturnButtonWidthScale, fourthY, ReturnButtonWidthScale ,CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +9 *j+2  ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }
                
            }else if ((j == 1 || j == 0) && i < 10){
                
                
                CGFloat secY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j;
                if (j == 0 && i == 0) {
                    [self.EnglishBtn setFrame:CGRectMake(MarddingLeftSclae, secY, CharBtnWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +10*j  ;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }else if (j == 0 && i == 9) {
                    [self.EnglishBtn setFrame:CGRectMake(SCREEN_WIDTH - MarddingLeftSclae - CharBtnWidthScale, secY, CharBtnWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +10*j;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }else {
                    [self.EnglishBtn setFrame:CGRectMake(MarddingLeftSclae + i * (CharBtnWidthScale + PaddingRightScale), secY, CharBtnWidthScale, CharBtnHeightScale)];
                    self.EnglishBtn.tag = i +10*j;
                    
                    [self.EnglishBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.EnglishBtn.tag + EnglishKey]];
                }
                
            }
            [self.EnglishBtn setBackgroundImage:[UIImage FitWithBackBgroudImage] forState:UIControlStateNormal];
            [self.EnglishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.EnglishBtn.titleLabel.font = KeyBoardFont;
            self.EnglishBtn.adjustsImageWhenHighlighted = NO;
            [self.EnglishBtn setTitle: [self.EnglishArry objectAtIndex:self.EnglishBtn.tag]forState:UIControlStateNormal];
            [self.KeyBoardConsoleView addSubview:self.EnglishBtn];
            [self.EnglishBtn addTarget:self action:@selector(EnglishDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self.KeyBoardConsoleView;
}

-(void)EnglishDidSelect:(UIButton *)sender {
    //删除
    if (sender.tag == 28) {
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (![self.ConnectStr isEqualToString:@""]) {
                    self.JumpStr = [self.ConnectStr substringToIndex:[self.ConnectStr length]-1];
                    self.ConnectStr = self.JumpStr;
                    [self runDelegateFromButtonTag:self.JumpStr andButtonTage: [sender.OrderTags integerValue]];
                }
            }
                break;
            case TextFiledOther:
            {
                if (![self.OtherConnectStr isEqualToString:@""]) {
                    self.OtherJumpStr = [self.OtherConnectStr substringToIndex:[self.OtherConnectStr length]-1];
                    self.OtherConnectStr = self.OtherJumpStr;
                    [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage: [sender.OrderTags integerValue]];
                }
            }
                break;
            default:
                break;
        }
        
        
        
    }else if (sender.tag == 29){
        //        NSLog(@"当前选择的Textfiled---->%u",self.TextSelectPostion);
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag: [sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf NumberKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            case TextFiledOther:
            {
                //                NSLog(@"切换数字键");
                if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getOtherKeyBoardViewValueFromButton:self.OtherJumpStr DidSelectButTag: [sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf NumberKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            default:
                break;
                
        }
        
        
        
    }else if (sender.tag == 30){
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:[sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            case TextFiledOther:
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherKeyBoardViewValueFromButton:DidSelectButTag:)]) {
                    [self.delegate  getOtherKeyBoardViewValueFromButton:self.OtherJumpStr DidSelectButTag:[sender.OrderTags integerValue]];
                    __weak typeof(self) weakSelf = self;
                    if (self.BlockChnagkeyBoard) {
                        weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
                    }
                    
                }
            }
                break;
            default:
                break;
                
        }
        
        
        
    }else if (sender.tag == 31){
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                self.JumpStr = [self.ConnectStr stringByAppendingString:@" "];
                self.ConnectStr = self.JumpStr;
                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            case TextFiledOther:
            {
                self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:@" "];
                self.OtherConnectStr = self.OtherJumpStr;
                [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            default:
                break;
        }
        
        
    }else if (sender.tag == 32){
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                self.JumpStr = [self.ConnectStr stringByAppendingString:@"\n"];
                self.ConnectStr = self.JumpStr;
                
                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            case TextFiledOther:
            {
                self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:@"\n"];
                self.OtherConnectStr = self.OtherJumpStr;
                
                [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:[sender.OrderTags integerValue]];
            }
                break;
            default:
                break;
        }
        
        
    }else{
        switch (self.TextSelectPostion) {
            case TextFiledFirst:
            {
                self.JumpStr = [self.ConnectStr stringByAppendingString:[self.EnglishArry objectAtIndex:sender.tag]];
                self.ConnectStr = self.JumpStr;
                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:sender.tag];
            }
                break;
            case TextFiledOther:
            {
                self.OtherJumpStr = [self.OtherConnectStr stringByAppendingString:[self.EnglishArry objectAtIndex:sender.tag]];
                self.OtherConnectStr = self.OtherJumpStr;
                [self runOtherDelegateFromButtonTag:self.OtherJumpStr andButtonTage:sender.tag];
            }
                break;
            default:
                break;
        }
        
    }
    
}


#pragma mark - 获取第一个文本框内容
-(void)runDelegateFromButtonTag:(NSString *)ButtonText andButtonTage:(NSInteger)TageValue {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
        [self.delegate  getKeyBoardViewValueFromButton:ButtonText DidSelectButTag:TageValue];
    }
}


#pragma mark - 获取第二个文本输入框内容
-(void)runSecondDelegateFromButtonTag:(NSString *)ButtonText andButtonTage:(NSInteger)TageValue {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getSecondKeyBoardViewValueFromButton:DidSelectButTag:)]) {
        [self.delegate  getSecondKeyBoardViewValueFromButton:ButtonText DidSelectButTag:TageValue];
    }
}

#pragma mark - 获取第三个文本输入框内容
-(void)runThirdDelegateFromButtonTag:(NSString *)ButtonText andButtonTage:(NSInteger)TageValue {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getThirdKeyBoardViewValueFromButton:DidSelectButTag:)]) {
        [self.delegate  getThirdKeyBoardViewValueFromButton:ButtonText DidSelectButTag:TageValue];
    }
}

#pragma mark - 获取第四个文本输入框内容
-(void)runFourthDelegateFromButtonTag:(NSString *)ButtonText andButtonTage:(NSInteger)TageValue {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getFourthKeyBoardViewValueFromButton:DidSelectButTag:)]) {
        [self.delegate  getFourthKeyBoardViewValueFromButton:ButtonText DidSelectButTag:TageValue];
    }
}


-(void)runOtherDelegateFromButtonTag:(NSString *)ButtonText andButtonTage:(NSInteger)TageValue {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getOtherKeyBoardViewValueFromButton:DidSelectButTag:)]) {
        [self.delegate  getOtherKeyBoardViewValueFromButton:ButtonText DidSelectButTag:TageValue];
    }
}

@end
