//
//  DSet.m
//  DataStream
//
//  Created by MAN on 4/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DSet.h"
#import "DataStream/DataStream-Swift.h"

@implementation DSet
    
    + (void)setup:(NSString *)string {
        [DataStream setupWithAPPWithKey:string];
    }

@end
