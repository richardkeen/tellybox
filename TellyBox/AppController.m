//
//  AppController.m
//  Radio
//
//  Created by Duncan Robertson on 15/12/2008.
//  Copyright 2008 Whomwah. All rights reserved.
//

#import "AppController.h"
#import "MainWindowController.h"
#import "PreferencesWindowController.h"

@implementation AppController

+ (void)initialize
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
  NSString *errorDesc = nil;
  NSPropertyListFormat format;
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"];
  NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
  NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                         propertyListFromData:plistXML
                                         mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                         format:&format 
                                         errorDescription:&errorDesc];
  if (!temp) {
    NSLog(errorDesc);
    [errorDesc release];
  }
  
  [defaultValues setObject:[temp objectForKey:@"Stations"] forKey:@"Stations"];
  [defaultValues setObject:[temp objectForKey:@"EmpSizes"] forKey:@"EmpSizes"];
  [defaultValues setObject:[temp objectForKey:@"DefaultStation"] forKey:@"DefaultStation"];
  [defaultValues setObject:[temp objectForKey:@"DefaultEmpSize"] forKey:@"DefaultEmpSize"];
  [defaultValues setObject:[temp objectForKey:@"DefaultEmpOriginX"] forKey:@"DefaultEmpOriginX"];
  [defaultValues setObject:[temp objectForKey:@"DefaultEmpOriginY"] forKey:@"DefaultEmpOriginY"];
  [defaults registerDefaults:defaultValues];
}

- (void)awakeFromNib
{
  [GrowlApplicationBridge setGrowlDelegate:self];
  drMainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
	[[drMainWindowController window] makeMainWindow];
	[[drMainWindowController window] makeKeyAndOrderFront:self];
}

- (void)dealloc
{
	[drMainWindowController release];
	[super dealloc];
}

- (void)displayPreferenceWindow:(id)sender
{
	if (!preferencesWindowController) {
    preferencesWindowController = [[PreferencesWindowController alloc] init];
	}
	[preferencesWindowController showWindow:self];
}

- (void)applicationDidUnhide:(NSNotification *)aNotification
{
  [drMainWindowController redrawEmp];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSRect wf = [[drMainWindowController window] frame];
  
  [ud setInteger:wf.origin.x forKey:@"DefaultEmpOriginX"];
  [ud setInteger:wf.origin.y forKey:@"DefaultEmpOriginY"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)visitIplayerSite:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://www.bbc.co.uk/iplayer"];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)visitTermsAndCondSite:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://iplayerhelp.external.bbc.co.uk/help/about_iplayer/termscon"];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)visitHelpSite:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://iplayerhelp.external.bbc.co.uk/help/"];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

@end
