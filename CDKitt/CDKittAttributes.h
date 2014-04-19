// CDKitt
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Aron Cedercrantz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


#pragma mark Method Requires Super Attribute
#if __has_attribute(objc_requires_super)
	#define CD_REQUIRES_SUPER_ATTRIBUTE __attribute__((objc_requires_super))
#else
	#define CD_REQUIRES_SUPER_ATTRIBUTE
#endif


#pragma mark - Deprecated Attributes
#if __has_attribute(deprecated) && __has_extension(attribute_deprecated_with_message)
	#define CD_DEPRECATED_MESSAGE(msg)	__attribute__((deprecated(msg)))
#elif __has_attribute(deprecated)
	#define CD_DEPRECATED_MESSAGE(msg)	__attribute__((deprecated))
#else
	#define CD_DEPRECATED_MESSAGE(msg)
#endif
#define CD_DEPRECATED CD_DEPRECATED_MESSAGE("")


#pragma mark - Unavailable Attributes
#if __has_attribute(unavailable) && __has_extension(attribute_unavailable_with_message)
	#define CD_UNAVAILABLE_MESSAGE(msg)	__attribute__((unavailable(msg)))
#elif __has_attribute(unavailable)
	#define CD_UNAVAILABLE_MESSAGE(msg)	__attribute__((unavailable))
#else
	#define CD_UNAVAILABLE_MESSAGE(msg)
#endif
#define CD_UNAVAILABLE CD_UNAVAILABLE_MESSAGE("")

