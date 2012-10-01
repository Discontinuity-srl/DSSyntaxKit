//
//  DSAppDelegate.m
//  DSCodeTextViewProject
//
//  Created by Fabio Pelosin on 01/10/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSAppDelegate.h"

@implementation DSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [self populateSyntaxes];
  [self populateThemes];
  [self setCurrentSyntax:@"Ruby"];
  [self setCurrentTheme:self.themeNames[0]];
  [self setLineNumebersVisible:TRUE];
}

#pragma mark - Code TextView usage demonstration

- (void)setCurrentTheme:(NSString *)currentTheme {
  _currentTheme = currentTheme;
  NSString *path = [self pathForThemeNamed:currentTheme];
  DSSyntaxTheme *theme = [DSSyntaxTheme themeWithXcodeTheme:path];
  [_codeTextView setTheme:theme];
}

- (void)setCurrentSyntax:(NSString *)currentSyntax {
  _currentSyntax = currentSyntax;
  NSString *sample = [self sampleForSyntaxNamed:currentSyntax];
  [_codeTextView setString:sample];
}

- (void)setLineNumebersVisible:(BOOL)visible {
  _lineNumebersVisible = visible;
  [_codeTextView setLineNumbersVisible:visible];
}



#pragma mark - Population

- (NSDictionary *)syntaxes {
  return @{
  @"Ruby" : @"installer.rb"
  };
}

/** Populates the syntax definitions */
- (void)populateSyntaxes {
  self.syntaxNames = [[self.syntaxes allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

NSString *const kXcodeThemesFolder = @"~/Library/Developer/Xcode/UserData/FontAndColorThemes/";

/** Populates the themes using the Xcode ones */
- (void)populateThemes {
  NSFileManager *fm = [NSFileManager defaultManager];
  NSString *themesPath = [kXcodeThemesFolder stringByExpandingTildeInPath];
  NSArray *dirContents = [fm contentsOfDirectoryAtPath:themesPath error:nil];
  NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.dvtcolortheme'"];
  NSArray *themes = [dirContents filteredArrayUsingPredicate:fltr];
  NSMutableArray *themeNames = [NSMutableArray array];
  [themes enumerateObjectsUsingBlock:^(NSString* name, NSUInteger idx, BOOL *stop) {
    [themeNames addObject:[name stringByDeletingPathExtension]];
  }];
  self.themeNames = themeNames;
}

- (NSString*)pathForThemeNamed:(NSString*)name {
  NSString *path = [kXcodeThemesFolder stringByExpandingTildeInPath];
  path = [path stringByAppendingPathComponent:name];
  path = [path stringByAppendingPathExtension:@"dvtcolortheme"];
  return path;
}

- (NSString*)sampleForSyntaxNamed:(NSString*)name {
  NSString *path = [[NSBundle mainBundle] pathForResource:self.syntaxes[name]
                                                   ofType:nil];
  NSString *sample = [NSString stringWithContentsOfFile:path
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
  return sample;
}

@end
