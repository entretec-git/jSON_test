//
//  RainModel.h
//  JSON_HelloWord
//
//  Created by mike on 24/02/13.
//  Copyright (c) 2013 mike. All rights reserved.
//

#import "JSONModel.h"
#import "LocationModel.h"

@protocol RainModel @end

@interface RainModel : JSONModel

//@property (strong, nonatomic) NSString* name;
//@property (strong, nonatomic) NSString* status;
//@property (strong, nonatomic) NSString* use;
@property (nonatomic, strong) NSString * rainfall_area;
@property (nonatomic, strong) NSNumber * rainfall_coeff;
@property (nonatomic, strong) NSNumber * rainfall_hour;
@property (nonatomic, strong) NSNumber * rainfall_index;
@property (nonatomic, strong) NSNumber * rainfall_year;


    //@property (strong, nonatomic) LocationModel* location;


@end
