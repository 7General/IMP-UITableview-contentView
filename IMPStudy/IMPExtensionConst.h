//
//  IMPExtensionConst.h
//  IMPStudy
//
//  Created by 王会洲 on 16/12/14.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>



// 构建错误
#define ExtensionBuildError(msg) \
NSError *error = [NSError errorWithDomain:msg code:250 userInfo:nil]; \


/**
 * 断言
 * @param condition   条件
 * @param returnValue 返回值
 */
#define ExtensionAssertError(condition, returnValue, msg) \
if ((condition) == NO) { \
ExtensionBuildError(msg); \
return returnValue;\
}




#define ExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define ExtensionAssert(condition) ExtensionAssert2(condition,)

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define ExtensionAssertParamNotNil2(param, returnValue) \
ExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define ExtensionAssertParamNotNil(param) ExtensionAssertParamNotNil2(param, )

