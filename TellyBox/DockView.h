//
//  DockView.h
//  TellyBox
//
//  Created by Duncan Robertson on 11/03/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DockView : NSView {
  NSImage *networkIcon;
  NSImage *appIcon;
  int windowId;
}

@property (nonatomic, retain) NSImage *networkIcon;
@property (nonatomic, assign) int windowId;

- (id)initWithFrame:(NSRect)frame withKey:(NSString *)key;

@end
