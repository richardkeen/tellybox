//
//  Broadcast.h
//  Telly
//
//  Created by Duncan Robertson on 06/01/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Broadcast : NSObject {
  NSString *title;
  NSString *subtitle;
  NSString *displayTitle;
  NSString *displaySubtitle;
  NSString *shortSynopsis;
  NSString *pid;
  NSString *duration;
  NSDate   *bStart;
  NSDate   *bEnd;
  NSDate   *available;
  NSString *availableText;
}

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;
@property(nonatomic,copy) NSString *displayTitle;
@property(nonatomic,copy) NSString *displaySubtitle;
@property(nonatomic,copy) NSString *shortSynopsis;
@property(nonatomic,copy) NSString *pid;
@property(nonatomic,copy) NSString *duration;
@property(nonatomic,retain) NSDate *bStart;
@property(nonatomic,retain) NSDate *bEnd;
@property(nonatomic,retain) NSDate *available;
@property(nonatomic,copy) NSString *availableText;

- (id)initUsingBroadcastXML:(NSXMLNode *)node;
- (NSDate *)fetchDateForXPath:(NSString *)string withNode:(NSXMLNode *)node;

@end
