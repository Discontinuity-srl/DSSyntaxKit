//
//  DSAppDelegate.h
//  DSSyntaxKit
//
//  Created by Fabio Pelosin on 01/10/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DSSyntaxTextView.h"

@interface DSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet DSSyntaxTextView *codeTextView;

@property (nonatomic, assign) NSArray  *themeNames;
@property (nonatomic, assign) NSArray  *syntaxNames;
@property (nonatomic, assign) NSString *currentTheme;
@property (nonatomic, assign) NSString *currentSyntax;

@property (nonatomic) BOOL lineNumebersVisible;

@end
