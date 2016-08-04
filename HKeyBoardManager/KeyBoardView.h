//
//  KeyBoardView.h
//  KeyBoard
//
//  Created by 王会洲 on 16/1/11.
//  Copyright © 2016年 王会洲. All rights reserved.
//


#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

#import <UIKit/UIKit.h>
#import "Config.h"



typedef enum  {
    NumberKeyBoard = 1,             // 数字键盘
    CharacterKeyBoard,               // 大写字符键盘
    SmallCharacterKeyBoard,     // 小写字符键盘
    EnglishKeyBoard                    // 英文符号键盘
} KeyBoardType;


typedef enum  {
    TextFiledFirst = 1,             // 首个文本框
    TextFiledSecond = 2,             // 2文本框
    TextFiledThird = 3,             //3文本框
    TextFiledFourth = 4,             // 4文本框
    TextFiledOther,                //
} UISelectTextPostion;


@protocol KeyBoardShowViewDelegate <NSObject>
/**
 * 获取从键盘中点击的值（数字）
 */
@required
-(void)getKeyBoardViewValueFromButton:(NSString * )ButtonTxt DidSelectButTag:(NSInteger) BtnTag;

/**
 *  第二文本框输入数据获取
 */
@optional
/**获取第二个*/
- (void)getSecondKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag;
/**获取第三个*/
- (void)getThirdKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag;
/**获取第四个*/
- (void)getFourthKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag;

- (void)getOtherKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag;


@end

typedef void(^ChangKeyBoard)(UIView *);


@interface KeyBoardView : UIView


@property (nonatomic, assign) id<KeyBoardShowViewDelegate>  delegate;

@property (nonatomic, copy) ChangKeyBoard  BlockChnagkeyBoard;

@property (nonatomic, assign) UISelectTextPostion  TextSelectPostion;
/**
 *  键盘类型
 */
@property (nonatomic, assign) KeyBoardType  showKeyBoardType;

/**
 *  连接字符串
 */
@property (nonatomic, strong) NSString * ConnectStr;

@property (nonatomic, strong) NSString * JumpStr;

@property (nonatomic, assign) BOOL  selectState;
/**是否全部删除数据*/
@property (nonatomic, assign) BOOL DeleteDone;



@property (nonatomic, strong) NSString * OtherConnectStr;

@property (nonatomic, strong) NSString * OtherJumpStr;

@property (nonatomic, assign) BOOL  OtherselectState;

//*************第二个数据
@property (nonatomic, strong) NSString * ConnectStrSecond;

@property (nonatomic, strong) NSString * JumpStrSecond;
/**是否全部删除数据*/
@property (nonatomic, assign) BOOL DeleteDoneSecond;

//*************第三个数据
@property (nonatomic, strong) NSString * ConnectStrThird;

@property (nonatomic, strong) NSString * JumpStrThird;
/**是否全部删除数据*/
@property (nonatomic, assign) BOOL DeleteDoneThird;

//*************第四个数据
@property (nonatomic, strong) NSString * ConnectStrFourth;

@property (nonatomic, strong) NSString * JumpStrFourth;
/**是否全部删除数据*/
@property (nonatomic, assign) BOOL DeleteDoneFourth;


/**
 *  初始化键盘
 *
 *  @return
 */
+ (instancetype)KeyBoardMenu;


/**
 *  数字键盘弹出界面
 */
-(UIView *)NumberKeyBoardShowView;

/**
 *  字符键盘弹出界面
 */
-(UIView *)CharacterKeyBoardShowView;

/**
 *  英文键盘弹出界面
 */
-(UIView *)EnglishKeyBoardShowView;

@end
