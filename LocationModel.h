//
//  LocationModel.h
//  JSON_HelloWord
//
//  Created by mike on 24/02/13.
//  Copyright (c) 2013 mike. All rights reserved.
//

#import "JSONModel.h"

@interface LocationModel : JSONModel
@property (strong, nonatomic) NSString* country_code;
@property (strong, nonatomic) NSString* country;
@end
