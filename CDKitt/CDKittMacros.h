// CDKittMacros.h
// 
// Copyright (c) 2012 Aron Cedercrantz
//
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
// 
// Redistributions of source code must retain the above copyright notice, this 
// list of conditions and the following disclaimer. Redistributions in binary 
// form must reproduce the above copyright notice, this list of conditions and 
// the following disclaimer in the documentation and/or other materials 
// provided with the distribution. Neither the name of the nor the names of 
// its contributors may be used to endorse or promote products derived from 
// this software without specific prior written permission. 
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
// POSSIBILITY OF SUCH DAMAGE.


#pragma mark - Open URLs and Paths
/** @name Open URLs and Paths */
/// Open an URL
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	#define CD_OPEN_URL(url)	[[UIApplication sharedApplication] openURL:(url)]
#else
	#define CD_OPEN_URL(url)	[[NSWorkspace sharedWorkspace] openURL:(url)]
#endif // TARGET_OS_IPHONE
/// Open a path.
#define CD_OPEN_PATH(path)		CD_OPEN_URL([NSURL URLWithString:(path)])


#pragma mark - Weak Pointers
/** @name Weak Pointers */
/// Creates a weak pointer with the given name _weakVar_ to the given variable
/// _var_.
#define CDWeak(var, weakVar)	__weak typeof((var)) weakVar = (var)
/// Creates a weak pointer to `self` named `weakSelf`.
#define CDWeakSelf()			CDWeak(self, weakSelf)
///
#define CDStrong(var, strongVar)	__strong strongVar = (var)
/// Creates a strong pointer to `self` from a weak pointer named `weakSelf`.
/// You must have used `CDWeakSelf()` before this macro.
#define CDStrongSelf()			CDStrong(weakSelf, self)


#pragma mark - Core Foundation Memory Management
/** @name Core Foundation Memory Management */
/// Unlike CFRelease CDCFRelease also supports NULL.
#define CDCFRelease(cf)			do { if ((cf) != NULL) { CFRelease((cf)); } } while(0)


#pragma mark - Boxing Values in Objective-C Objects
/** @name Boxing Values in Objective-C Objects */
/// Box a value _val_ using `NSValue`.
///
/// By Phil Jordan (@pmjordan) – https://twitter.com/pmjordan/status/221902596506529792
#define CD_BOXED(val)		({ typeof(val) _tmp_val = (val); [NSValue valueWithBytes:&(_tmp_val) objCType:@encode(typeof(val))]; })


#pragma mark - Class to String
/** @name Selector to String */
#define CDStringFromInstance(inst)		NSStringFromClass([(inst) class])
#define CDStringFromClassInstance(cls)	NSStringFromClass(cls)
#if DEBUG
	#define CDStringFromClass(cls)		NSStringFromClass([cls class])
#else
	#define CDStringFromClass(cls)		@#cls
#endif // DEBUG


#pragma mark - Selector to String
/** @name Selector to String */
#if DEBUG
	#define CDStringFromSelector(sel)	NSStringFromSelector(@selector(sel))
#else
	#define CDStringFromSelector(sel)	@#sel
#endif // DEBUG


#pragma mark - String from BOOL
#define CDStringFromBOOL(b)	((b) ? @"YES" : @"NO") 


#pragma mark - Fix QA1490 Static Library Categories Bug
/** @name Fix QA1490 Static Library Categories Bug */
/**
 * Force a category to be loaded when an app starts up.
 *
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 * Also see https://github.com/jverkoey/nimbus for the source of this code snippet.
 */
#define _CD_FIX_CATEGORY_BUG_QA1490(name)	@interface CD_FIX_CATEGORY_BUG_QA1490_##name : NSObject @end \
@implementation CD_FIX_CATEGORY_BUG_QA1490_##name @end
#define CD_FIX_CATEGORY_BUG_QA1490(class, category)	_CD_FIX_CATEGORY_BUG_QA1490(class ## category)


#pragma mark - Debug Constants
/** @name Debug Constants */
/// The logging prefix for a “notice” class message.
#define CDKittLoggingNoticePrefix		@"=== "
/// The logging prefix for a “waring” class message.
#define CDKittLoggingWarningPrefix		@"+++ "
/// The logging prefix for a “error” class message.
#define CDKittLoggingErrorPrefix		@"*** "


#pragma mark Logging Output
/** @name Logging Output */
#if DEBUG
	// Private, don’t use.
	#define _DLog(prefix, ...)					NSLog(@"%@%s %@", (prefix), __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
	#define _DCLog(condition, prefix, ...)		do { if ((condition)) { _DLog((prefix), __VA_ARGS__); } } while(0)

	/// Always logs a given message.
	///
	/// @warning In debug mode it will trigger an assertion instead of just
	/// loggin the message to the standard output.
	#define ALog(...)							[[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:__VA_ARGS__]
#else // !DEBUG
	// Private, don’t use.
	#define _DLog(prefix, ...)					do { } while(0)
	#define _DCLog(condition, prefix, ...)		_DLog(prefix, __VA_ARGS__)

	/// Always logs a given message.
	///
	/// @warning In debug mode it will trigger an assertion instead of just
	/// loggin the message to the standard output.
	#define ALog(...)							NSLog(@"%@%s %@", CDKittLoggingErrorPrefix, __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#endif // DEBUG

/// Logs the given message if we are in debug mode.
#define DLog(...)								_DLog(CDKittLoggingNoticePrefix, __VA_ARGS__)
/// Logs the given message as a notice if we are in debug mode.
#define DLogNotice(...)							DLog(__VA_ARGS__)
/// Logs the given message as a warning if we are in debug mode.
#define DLogWarning(...)							_DLog(CDKittLoggingWarningPrefix, __VA_ARGS__)
/// Logs the given message as a error if we are in debug mode.
#define DLogError(...)							_DLog(CDKittLoggingErrorPrefix, __VA_ARGS__)

/// Just logs the current method’s name.
#define DLogMethod()							DLog(@"")

/// Logs the given message if the cupplied condition _condition_ is true and we
/// are in debug mode. The message is logged as a notice.
#define DCLog(condition, ...)					_DCLog((condition), CDKittLoggingNoticePrefix, __VA_ARGS__)
/// Logs the given notice if the cupplied condition _condition_ is true and we
/// are in debug mode.
#define DCLogNotice(condition, ...)				DCLog((condition), __VA_ARGS__)
/// Logs the given warning if the cupplied condition _condition_ is true and we
/// are in debug mode.
#define DCLogWarning(condition, ...)			_DCLog((condition), CDKittLoggingWarningPrefix, __VA_ARGS__)
/// Logs the given error if the cupplied condition _condition_ is true and we
/// are in debug mode.
#define DCLogError(condition, ...)				_DCLog((condition), CDKittLoggingErrorPrefix, __VA_ARGS__)

/// Always log the message as long as the condition is met.
#define ACLog(condition, ...)					do { if ((condition)) { ALog(__VA_ARGS__); } } while(0)


#pragma mark - Assertions
/** @name Assertions */
/**
 * A better assert.
 *
 * NSAssert is too runtime dependant, and assert() doesn't log.
 * http://www.mikeash.com/pyblog/friday-qa-2013-05-03-proper-use-of-asserts.html
 * Implementation taken from https://gist.github.com/steipete/5664345.
 *
 * Can either be used with only the evaluation argument or, also with a
 * description:
 * - `CDAssert(x > 0);`
 * - `CDAssert(y > 3, @"Bad value for y, it must be larger than three (3)");`
 */
#if NS_BLOCK_ASSERTIONS
	#define CDAssert(expression, ...) \
		do { if(!(expression)) { \
		NSLog(@"%@", [NSString stringWithFormat: @"%@Assertion failure: %s in %s on line %s:%d. %@", CDKittLoggingErrorPrefix, #expression, __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat:@"" __VA_ARGS__]]); }} while(0)
#else
	#define CDAssert(expression, ...) \
		do { if(!(expression)) { \
		NSLog(@"%@", [NSString stringWithFormat: @"%@Assertion failure: %s in %s on line %s:%d. %@", CDKittLoggingErrorPrefix, #expression, __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat:@"" __VA_ARGS__]]); \
		abort(); }} while(0)
#endif


/**
 * Mimic's C++'s assert_cast in Objective-C.
 *
 * By @schwa (https://gist.github.com/schwa/532188).
 *
 * **Usage example:**
 *
 *     - (MyView *)myView {
 *         return CDAssertCast(MyView, self.view);
 *     }
 */
#define CDAssertCast(theClass, theObject) ({ NSAssert2([(theObject) isKindOfClass:[theClass class]], @"Object %@ not of class %@", theObject, NSStringFromClass([theClass class])); (theClass *)(theObject); })
#define CDCast(theClass, theObject) ({ (theClass *)(theObject); })
