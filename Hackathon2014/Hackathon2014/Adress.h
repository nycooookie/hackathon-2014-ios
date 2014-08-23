//
//  Adress.h
//  Hackathon2014
//
//  Created by Swiss App Innovation on 23.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Adress : NSObject

@property (nonatomic) NSInteger taskNo;
@property (nonatomic) float laengengrad;
@property (nonatomic) float breitengrad;

- (id) initWithTaskNo:(NSInteger)task laengengrad:(float)lg undbreitengrad:(float)bg;

@end
