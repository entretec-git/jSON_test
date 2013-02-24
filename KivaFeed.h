//
//  KivaFeed.h
//  JSON_HelloWord
//
//  Created by mike on 24/02/13.
//  Copyright (c) 2013 mike. All rights reserved.
//

#import "JSONModel.h"
#import "RainModel.h"

@interface KivaFeed : JSONModel

@property (strong, nonatomic) NSArray<RainModel>* rain;


@end
