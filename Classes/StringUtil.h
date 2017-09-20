//
//  StringUtil.h
//  StringUtil
//
//  Created by kzf on 2017/6/6.
//  Copyright © 2017年 kzf. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PHONENUMBER_LIMIT 11        //手机号
#define NICKNAME_LIMIT 16           //昵称
#define VERIFYCODE_LIMIT 6          //验证码
#define PASSWORD_LITTLELIMIT 8      //密码最少
#define PASSWORD_LIMIT 16           //密码最多
#define IDENTITY_LIMIT 18           //身份证号码
#define NUMBERS_ONLY @"1234567890"
#define NUMBERSDOT_ONLY @"1234567890."
#define ALPHA_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define IDCARDONLY @"xX0123456789"

@interface StringUtil : NSObject

//是否为空
+ (BOOL)isNullOrEmpty:(NSString *)str;

//验证码验证 推广码 交易密码
+(BOOL)validateValidateCode:(NSString *)validate;

//手机号码验证
+ (BOOL)validateMobilePhone:(NSString *)mobile;

//验证输入的密码
+(BOOL)validatePassword:(NSString *)password;

//身份证号
+ (BOOL)validateIdentity:(NSString *)identityCard;

//身份证号后六位
+ (BOOL)validateIdentityForNum:(NSString *)identityCard;

//验证银行卡号
+ (BOOL)validateBankCard:(NSString *)bankCardNumber;

//去掉空格
+ (NSString *)trimSpacesOfString:(NSString *)str;

//验证输入昵称4~14个字符，2~7个汉字
+(BOOL)valiNickName:(NSString *)string;

/**
 textfield能被输入字符的判断
 @param textString 输入字符
 @param string 判断字符
 @return return value description
 */
+ (BOOL)compareOriginalString:(NSString *)textString withJudgeString:(NSString *)string;

//手机号码加空格，格式为xxx xxxx xxxx
+ (NSMutableString *)setGapWith:(NSString *)string;

//时间格式
+ (NSDateFormatter *)dateFormatterWithFormatString:(NSString *)format;

//字符串添加千分位
+ (NSString *)setDetailLabelText:(NSString *)countString;

//手机号加星号
+ (NSString *)changeOrgialString:(NSString *)string;

/**
 打上星号
 @param string 字符串
 @param range 范围
 @return return value description
 */
+ (NSString* )starsReplacedOfString:(NSString *)string withinRange:(NSRange)range;

//获取姓名的姓
+ (NSString *)firstCharactorWithString:(NSString *)string;

/**
 判断是否是纯汉字
 
 @param string 字符
 @return return value description
 */
+ (BOOL)isChineseWithString:(NSString *)string;

/**
 判断是否含有汉字
 
 @param string 字符
 @return return value description
 */
+ (BOOL)includeChineseWithString:(NSString *)string;


@end
