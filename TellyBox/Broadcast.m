//
//  Broadcast.m
//  Telly
//
//  Created by Duncan Robertson on 06/01/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "Broadcast.h"
#import "NSString-Utilities.h"

@implementation Broadcast

@synthesize title, subtitle, displayTitle, displaySubtitle;
@synthesize shortSynopsis, pid, duration;
@synthesize bStart, bEnd, available, availableText;

-(id)init
{
  [self dealloc];
  @throw [NSException exceptionWithName:@"DSRBadInitCall" 
                                 reason:@"Initialize Broadcast with initUsingBroadcastXML:" 
                               userInfo:nil];
  return nil;
}

- (id)initUsingBroadcastXML:(NSXMLNode *)node
{
  if (![super init])
    return nil;
  
  NSError *error;
  NSXMLNode *episode = [[node nodesForXPath:@".//programme[@type=\"episode\"]" 
                                      error:&error] objectAtIndex:0];
  if (error != nil) {
    NSLog(@"An Error occured: %@", error);
    return nil;
  }
  
  [self setDisplayTitle:[NSString stringForXPath:@"display_titles/title" ofNode:episode]];
  [self setDisplaySubtitle:[NSString stringForXPath:@"display_titles/subtitle" ofNode:episode]];
  [self setShortSynopsis:[NSString stringForXPath:@"short_synopsis" ofNode:episode]];
  [self setPid:[NSString stringForXPath:@"pid" ofNode:episode]];
  [self setBStart:[self fetchDateForXPath:@"start" withNode:node]];
  [self setBEnd:[self fetchDateForXPath:@"end" withNode:node]];
  [self setDuration:[NSString stringForXPath:@"duration" ofNode:node]];
  [self setAvailable:[self fetchDateForXPath:@"media[@format=\"video\"]/expires" withNode:episode]];
  [self setAvailableText:[NSString stringForXPath:@"media[@format=\"video\"]/availability" ofNode:episode]];
  
  return self;
}

- (NSDate *)fetchDateForXPath:(NSString *)string withNode:(NSXMLNode *)node
{
  NSString *stringValue = [NSString stringForXPath:string ofNode:node];
  
  if (stringValue == nil)
    return nil;
  
  NSDate *date = [NSDate dateWithNaturalLanguageString:stringValue]; 
  return date;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"\ntitle:%@\npid:%@\nstart:%@", displayTitle, pid, bStart];
}

@end
