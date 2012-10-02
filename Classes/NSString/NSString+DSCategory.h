//
//  NSString+DSStandardLib.h
//  DSStandardLib
//
//  Created by Fabio Pelosin on 27/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DSCategory)

///-----------------------------------------------------------------------------
/// @name General
///-----------------------------------------------------------------------------

@property (nonatomic, readonly) NSRange range;

-(BOOL)isValid;

///-----------------------------------------------------------------------------
/// @name White spaces
///-----------------------------------------------------------------------------

- (NSString*)indentation;

///-----------------------------------------------------------------------------
/// @name Regular Expressions
///-----------------------------------------------------------------------------

/** Returns the substring matched by a regular expression pattern.

 @param pattern The pattern to use for the match.
 @return Returns the substring of the pattern.
 @exception NSException Thrown if the pattern is `nil` or empty.
 */
- (NSString*)matchForPattern:(NSString*)pattern;

/** Returns an array contianing the matches of a regular expression pattern.

 @param pattern The pattern to use for the match.
 @return An array of NSTextCheckingResult.
 @exception NSException Thrown if the pattern is `nil` or empty.
 */
- (NSArray*)matchesForPattern:(NSString*)pattern;

///-----------------------------------------------------------------------------
/// @name Derived from Ruby
///-----------------------------------------------------------------------------

@end
