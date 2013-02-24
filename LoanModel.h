//
//  LoanModel.h
//  JSON_HelloWord
//
//  Created by mike on 24/02/13.
//  Copyright (c) 2013 mike. All rights reserved.
//

#import "JSONModel.h"
#import "LocationModel.h"

@protocol LoanModel @end

@interface LoanModel : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* status;
@property (strong, nonatomic) NSString* use;

@property (strong, nonatomic) LocationModel* location;


@end
