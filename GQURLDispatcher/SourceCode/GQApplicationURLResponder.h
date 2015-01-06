//
//  GQApplicationURLResponder.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14/12/19.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQURLResponder.h"

@interface GQApplicationURLResponder : NSObject <GQURLResponder>

@property (nonatomic, strong, readonly) NSRegularExpression *responseURLStringRegularExpression;

@end
