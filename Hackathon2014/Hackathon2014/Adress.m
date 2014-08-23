//
//  Adress.m
//  Hackathon2014
//
//  Created by Swiss App Innovation on 23.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "Adress.h"

@implementation Adress

@synthesize laengengrad = _laengengrad;
@synthesize breitengrad = _breitengrad;
@synthesize taskNo = _taskNo;

- (id) initWithTaskNo:(NSInteger)task laengengrad:(float)lg undbreitengrad:(float)bg {
    if ((self = [super init])) {
        _laengengrad = lg;
        _breitengrad = bg;
        _taskNo = task;
    }
    return self;
}

@end
