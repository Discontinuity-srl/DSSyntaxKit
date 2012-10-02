//
//  NSString+DSStandardLib.m
//  DSStandardLib
//
//  Created by Fabio Pelosin on 27/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "NSString+DSCategory.h"

@implementation NSString (DSCategory)

- (NSRange)range {
  return NSMakeRange(0, self.length);
}

- (NSString*)matchForPattern:(NSString*)pattern {
  NSRegularExpression *regex = [NSRegularExpression
                                regularExpressionWithPattern:pattern
                                options:0
                                error:nil];
  NSTextCheckingResult* match = [regex firstMatchInString:self
                                                  options:0
                                                    range:self.range];
  return [self substringWithRange:match.range];
}

- (NSArray*)matchesForPattern:(NSString*)pattern {
  NSRegularExpression *regex = [NSRegularExpression
                                regularExpressionWithPattern:pattern
                                options:0
                                error:nil];
  return [regex matchesInString:self
                        options:0
                          range:self.range];
}


- (NSString*)indentation {
  return [self matchForPattern:@"^([\\t\\p{Zs}])*"];
}

///-----------------------------------------------------------------------------
/// Adapted: http://benscheirman.com/2010/04/handy-categories-on-nsstring
///-----------------------------------------------------------------------------

-(BOOL)isValid {
  if([[self stringByStrippingWhitespace] isEqualToString:@""])
    return NO;
  return YES;
}

-(BOOL)contains:(NSString *)string {
  NSRange range = [self rangeOfString:string];
  return (range.location != NSNotFound);
}

-(NSString *)stringByStrippingWhitespace {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSArray *)splitOnChar:(char)ch {
  NSMutableArray *results = [[NSMutableArray alloc] init];
  int start = 0;
  for(int i=0; i<[self length]; i++) {

    BOOL isAtSplitChar = [self characterAtIndex:i] == ch;
    BOOL isAtEnd = i == [self length] - 1;

    if(isAtSplitChar || isAtEnd) {
      // Take the substring &amp; add it to the array
      NSRange range;
      range.location = start;
      range.length = i - start + 1;

      if(isAtSplitChar)
        range.length -= 1;

      [results addObject:[self substringWithRange:range]];
      start = i + 1;
    }

    // Handle the case where the last character was the split char.
    // We need an empty trailing element in the array.
    if(isAtEnd && isAtSplitChar)
      [results addObject:@""];
  }

  return results;
}

-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
  NSString *rightPart = [self substringFromIndex:from];
  return [rightPart substringToIndex:to-from];
}

///-----------------------------------------------------------------------------
/// Adapted: http://www.cocoanetics.com/2009/04/nsstring-category-compressing-whitespace
///-----------------------------------------------------------------------------

- (NSString *)stringByCompressingWhitespaceTo:(NSString *)seperator {
	NSArray *comps = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSMutableArray *nonemptyComps = [NSMutableArray new];
	for (NSString *oneComp in comps) {
		if (![oneComp isEqualToString:@""]) {
			[nonemptyComps addObject:oneComp];
		}
	}
	return [nonemptyComps componentsJoinedByString:seperator];  // already marked as autoreleased
}

///-----------------------------------------------------------------------------
/// Adapted: http://cocoadev.com/wiki/NSStringCategory
///-----------------------------------------------------------------------------

- (NSArray*)tokensSeparatedByCharactersFromSet:(NSCharacterSet*)separatorSet {
  NSScanner*      scanner      = [NSScanner scannerWithString:self];
  NSCharacterSet* tokenSet     = [separatorSet invertedSet];
  NSMutableArray* tokens       = [NSMutableArray array];
  [scanner setCharactersToBeSkipped:separatorSet];
  while (![scanner isAtEnd]) {
    NSString  *destination = [NSString string];
    if ([scanner scanCharactersFromSet:tokenSet intoString:&destination]) {
      [tokens addObject:[NSString stringWithString:destination]];
    }
  }
  return [NSArray arrayWithArray:tokens];
}

- (BOOL) containsCharacterFromSet:(NSCharacterSet *)set {
  return ([self rangeOfCharacterFromSet:set].location != NSNotFound);
}

- (BOOL)writeToPathIfNeeded:(NSString*)path {
  NSString *saved = [NSString stringWithContentsOfFile:path
                                              encoding:NSUTF8StringEncoding
                                                 error:nil];
  if([self isEqualToString:saved]) {
    return YES;
  }
  return [self writeToFile:path
                atomically:TRUE
                  encoding:NSUTF8StringEncoding
                     error:nil];
}

- (BOOL)containsString:(NSString *)aString {
  return [self containsString:aString ignoringCase:NO];
}

- (BOOL)containsString:(NSString *)aString ignoringCase:(BOOL)flag {
  unsigned mask = (flag ? NSCaseInsensitiveSearch : 0);
  NSRange range = [self rangeOfString:aString options:mask];
  return (range.length > 0);
}

-(NSArray *) splitToSize:(unsigned)size {
  NSMutableArray *splitStrings = [NSMutableArray array];
  NSString *tempString;
  NSUInteger count = [self length] / size;
  NSUInteger loc = 0;
  for (NSUInteger i=0; i < count; i++) {
    loc = size;
    tempString = [self substringWithRange:NSMakeRange(loc,size)];
    [splitStrings addObject: [tempString copy]];
  }
  loc = size;
  tempString = [self substringFromIndex:loc];
  [splitStrings addObject: [tempString copy]];
  return splitStrings;
}

-(NSString *)removeTabsAndReturns {
  NSMutableString *outputString = [NSMutableString string];
  NSCharacterSet *charSet;
  NSString *temp;
  NSScanner *scanner = [NSScanner scannerWithString:self];
  charSet = [NSCharacterSet characterSetWithCharactersInString:@"\n\r\t"];
  while ([scanner scanUpToCharactersFromSet:charSet intoString:&temp])
  {
    [outputString appendString:temp];
  }
  return [outputString copy];
}

-(NSString*)newlineToCR {
  NSMutableString *str = [NSMutableString string];
  [str setString: self];
  [str replaceOccurrencesOfString:@"\n" withString:@"\r"
                          options:NSLiteralSearch range:NSMakeRange (0, [str length])];
  return [str copy];
}

-(NSString *)safeFilePath { int numberWithName = 1; BOOL isDir; NSString *safePath = [[NSString alloc] initWithString:self];
  if ([[NSFileManager defaultManager] fileExistsAtPath:safePath
                                           isDirectory:&isDir]){
    while ([[NSFileManager defaultManager] fileExistsAtPath:safePath
                                                isDirectory:&isDir]) {
      safePath = [[NSString alloc] initWithFormat:@"%@ %d.%@",
                  [self stringByDeletingPathExtension],
                  numberWithName,[self pathExtension]];
      numberWithName++;
    }
  }
  return safePath; }

-(NSRange)whitespaceRangeForRange:(NSRange)characterRange {
  NSString *string = [self copy];
  NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  NSUInteger areamax = NSMaxRange(characterRange);
  NSUInteger length = [string length];

  NSRange start = [string rangeOfCharacterFromSet:whitespaceSet
                                          options:NSBackwardsSearch range:NSMakeRange(0, characterRange.location)];
  if (start.location == NSNotFound)
  {
    start.location = 0;
  }
  else
  {
    start.location = NSMaxRange(start);
  }

  NSRange end = [string rangeOfCharacterFromSet:whitespaceSet
                                        options:0 range:NSMakeRange(areamax, length - areamax)];
  if (end.location == NSNotFound)
    end.location = length;

  NSRange searchRange = NSMakeRange(start.location, end.location - start.location);
  //last whitespace to next whitespace
  return searchRange;
}

- (NSString*)substringAfterRange:(NSRange)range {
  return [self substringFromIndex:NSMaxRange(range)];
}

-(BOOL)isValidURL {
  return ([NSURL URLWithString:self] != nil);
}

///-----------------------------------------------------------------------------
/// Adapted: http://www.ruby-doc.org/core-1.9.3/String.html
///-----------------------------------------------------------------------------

/**
 #capitalize
 #capitalize!
 #casecmp
 #center
 #chars
 #chomp
 #chomp!
 #chop
 #chop!
 #chr
 #clear
 #codepoints
 #concat
 #count
 #crypt
 #delete
 #delete!
 #downcase
 #downcase!
 #dump
 #each_byte
 #each_char
 #each_codepoint
 #each_line
 #empty?
 #encode
 #encode!
 #encoding
 #end_with?
 #eql?
 #force_encoding
 #getbyte
 #gsub
 #gsub!
 #hash
 #hex
 #include?
 #index
 #initialize_copy
 #insert
 #inspect
 #intern
 #length
 #lines
 #ljust
 #lstrip
 #lstrip!
 #match
 #next
 #next!
 #oct
 #ord
 #partition
 #prepend
 #replace
 #reverse
 #reverse!
 #rindex
 #rjust
 #rpartition
 #rstrip
 #rstrip!
 #scan
 #setbyte
 #size
 #slice
 #slice!
 #split
 #squeeze
 #squeeze!
 #start_with?
 #strip
 #strip!
 #sub
 #sub!
 #succ
 #succ!
 #sum
 #swapcase
 #swapcase!
 #to_c
 #to_f
 #to_i
 #to_r
 #to_s
 #to_str
 #to_sym
 #tr
 #tr!
 #tr_s
 #tr_s!
 #unpack
 #upcase
 #upcase!
 #upto
 #valid_encoding?
 */


@end
