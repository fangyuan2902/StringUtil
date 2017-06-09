//
//  StringUtil.m
//  StringUtil
//
//  Created by kzf on 2017/6/6.
//  Copyright © 2017年 kzf. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

//是否为空
+ (BOOL)isNullOrEmpty:(NSString *)str {
    return ([str isEqualToString:@""] || str == nil);
}

//验证码验证 推广码 交易密码
+(BOOL)validateValidateCode:(NSString *)validate {
    NSString *passwordRegex = @"^\\d{6}$";
    NSPredicate *validateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [validateTest evaluateWithObject:[self trimSpacesOfString:validate]];
}

//手机号码验证
+ (BOOL)validateMobilePhone:(NSString *)mobile {
    //手机号以1开头，11个 \d 数字字符
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:[self trimSpacesOfString:mobile]];
}

//验证输入的密码为数字、大小写字母和标点符号
+(BOOL)validatePassword:(NSString *)password {
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:password]];
}
//身份证号
+ (BOOL)validateIdentity:(NSString *)identityCard {
    if (identityCard.length <= 0) {
        return false;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:identityCard]];
}

//身份证号后六位
+ (BOOL)validateIdentityForNum:(NSString *)identityCard {
    if (identityCard.length <= 0) {
        return false;
    }
    NSString *regex2 = @"^(\\d{5})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:identityCard]];
}

//验证银行卡号
+ (BOOL)validateBankCard:(NSString *)bankCardNumber {
    if (bankCardNumber.length <= 0) {
        return false;
    }
    NSString *cardNumRegex = @"^(\\d{16,19})$";
    NSPredicate *cardNumPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cardNumRegex];
    return [cardNumPredicate evaluateWithObject:[self trimSpacesOfString:bankCardNumber]];
}

//去掉空格
+ (NSString *)trimSpacesOfString:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//验证输入昵称4~14个字符，2~7个汉字
+(BOOL)valiNickName:(NSString *)string {
    NSString *regex = @"^([\u4e00-\u9fa5]{2,7})|([A-Za-z0-9 ]{4,14})$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

/**
 textfield能被输入字符的判断
 @param textString 输入字符
 @param string 判断字符
 @return return value description
 */
+ (BOOL)compareOriginalString:(NSString *)textString withJudgeString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:string] invertedSet];
    NSString *filtered = [[textString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return ([textString isEqualToString:filtered]);
}

//手机号码加空格，格式为xxx xxxx xxxx
+ (NSMutableString *)setGapWith:(NSString *)string {
    string = [StringUtil trimSpacesOfString:string];
    NSMutableString *newPhoneString = [NSMutableString stringWithString:string];
    if (newPhoneString.length > 3) {
        [newPhoneString insertString:@" " atIndex:3];
    }
    if (newPhoneString.length > 8) {
        [newPhoneString insertString:@" " atIndex:8];
    }
    return newPhoneString;
}

//时间格式
+ (NSDateFormatter *)dateFormatterWithFormatString:(NSString *)format {
    NSMutableDictionary *threadDic = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDic objectForKey:format];
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:format];
        [threadDic setObject:dateFormatter forKey:format];
    }
    return dateFormatter;
}

/**
 根据内容改变尺寸
 @param text 输入字符
 @param size 尺寸
 @param font 字体
 @return return value description
 */
+ (CGSize)boundingRectWithText:(NSString *)text maxSize:(CGSize)size font:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName : font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

//字符串添加千分位
+ (NSString *)setDetailLabelText:(NSString *)countString {
    if (![countString isKindOfClass:[NSString class]]) {
        return nil;
    }
    int count = 0;
    NSArray *arr = [countString componentsSeparatedByString:@"."];
    long long int a = ((NSString *)arr.firstObject).longLongValue;
    while (a != 0) {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:arr.firstObject];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    if (arr.count > 1) {
        [newstring appendString:[NSString stringWithFormat:@".%@", arr.lastObject]];
    }
    return newstring;
}

//手机号加星号
+ (NSString *)changeOrgialString:(NSString *)string {
    string = [StringUtil trimSpacesOfString:string];
    return [StringUtil starsReplacedOfString:string withinRange:NSMakeRange(3, 4)];
}

/**
 打上星号
 @param string 字符串
 @param range 范围
 @return return value description
 */
+ (NSString* )starsReplacedOfString:(NSString *)string withinRange:(NSRange)range {
    if (string == nil || [string length] < range.location + range.length) {
        return string;
    }
    NSMutableString* newStr = [[NSMutableString alloc] initWithString:string];
    [newStr replaceCharactersInRange:range withString:[[NSString string] stringByPaddingToLength:range.length withString: @"*" startingAtIndex:0]];
    return newStr;
}

//获取姓名的姓
+ (NSString *)firstCharactorWithString:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}

/**
 判断是否是纯汉字
 
 @param string 字符
 @return return value description
 */
+ (BOOL)isChineseWithString:(NSString *)string {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

/**
 判断是否含有汉字
 
 @param string 字符
 @return return value description
 */
+ (BOOL)includeChineseWithString:(NSString *)string {
    for(int i=0; i< [string length];i++) {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff) {
            return YES;
        }
    }
    return NO;
}

@end
