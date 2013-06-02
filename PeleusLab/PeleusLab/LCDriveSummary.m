//
//  LCDriveSummary.m
//  data-parser
//
//  Created by chris.liu on 5/28/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDriveSummary.h"

@implementation LCDriveSummary

@synthesize timestamp;
@synthesize startTime, startLat, startLng, startEle;
@synthesize endTime, endLat, endLng, endEle;
@synthesize time, airPressure, fuelLV, bat, temp, dist;
@synthesize maxSPD, bstFuel, avgSPD, avgFuel, totalFuel, lstFuelLV;
@synthesize acc, brk, overSPD, idleSPD, sliding;
@synthesize fastRate, slowRate, jamRate;
@synthesize errorCodes;

@end
