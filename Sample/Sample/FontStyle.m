//
//  FontStyle.m
//  Sample
//
//  Created by africa on 2019/11/22.
//  Copyright © 2019 africa. All rights reserved.
//

#import "FontStyle.h"

@implementation FontStyle

+ (UIFont*)fontForStyle:(NSString*)style {
    if ([style isEqualToString:@"p"]) {
        return [UIFont systemFontOfSize:18];
    } else if ([style isEqualToString:@"h1"]) {
         return [UIFont boldSystemFontOfSize:24];
    } else if ([style isEqualToString:@"h2"]) {
        return [UIFont boldSystemFontOfSize:36];
    }

    return [UIFont systemFontOfSize:10];
}

@end
