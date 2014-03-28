//
//  Load.h
//  NewAFTemplateProject
//
//  Created by shane davis on 28/03/2014.
//  Copyright (c) 2014 shane davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Load : NSManagedObject

@property (nonatomic, retain) NSString * custName;
@property (nonatomic, retain) NSString * delvNumber;
@property (nonatomic) double id;

@end
