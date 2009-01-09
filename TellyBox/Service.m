//
//  Service.m
//  Telly
//
//  Created by Duncan Robertson on 06/01/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "Service.h"
#import "NSString-Utilities.h"

@implementation Service

@synthesize key, title, desc;
@synthesize outletKey, outletTitle, outletDesc;
@synthesize displayTitle;

-(id)init
{
  [self dealloc];
  @throw [NSException exceptionWithName:@"DSRBadInitCall" 
                                 reason:@"Initialize Service with initUsingServiceXML:" 
                               userInfo:nil];
  return nil;
}

- (id)initUsingServiceXML:(NSArray *)data;
{
  if (![super init])
    return nil;

  if ([data count] == 0)
    @throw [NSException exceptionWithName:@"DSRBadInitCall" 
                                   reason:@"Initialize has no data" 
                                 userInfo:nil];
  
  NSXMLNode *node = [data objectAtIndex:0];
  [self setKey:[NSString stringForXPath:@"@key" ofNode:node]];
  [self setTitle:[NSString stringForXPath:@"title" ofNode:node]];
  [self setOutletTitle:[NSString stringForXPath:@"outlet/title" ofNode:node]];
  [self setOutletKey:[NSString stringForXPath:@"outlet/@key" ofNode:node]];
  
  if ([self outletTitle]) {
    [self setDisplayTitle:[NSString stringWithFormat:@"%@ %@", [self title], [self outletTitle]]];
  } else {
    [self setDisplayTitle:[self title]];
  }
  
  return self;
}

@end
