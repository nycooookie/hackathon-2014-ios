//
//  MathController.m
//  Hackathon2014
//
//  Created by Swiss App Innovation on 23.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "MathController.h"

static bool const isMetric = YES;
static float const metersinKm = 1000;
static float const metersinMile = 1609.344;

@implementation MathController

+ (NSString *)stringifyDistance:(float)meters {
    float unitDivider;
    NSString *unitName;
    
    // metric
    if (isMetric) {
        unitName = @"km";
        unitDivider = metersinKm;
    } else {
        unitName = @"mi";
        unitDivider = metersinMile;
    }
    return [NSString stringWithFormat:@"%.2f %@", (meters / unitDivider), unitName];
}

@end
