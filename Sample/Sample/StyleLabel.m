//
//  StyleLabel.m
//  Sample
//
//  Created by africa on 2019/11/22.
//  Copyright © 2019 africa. All rights reserved.
//

#import "StyleLabel.h"
#import "FontStyle.h"

@implementation StyleLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setStyle:(NSString *)style {
    self.font = [FontStyle fontForStyle:style];
}

@end
