// CDKittAttributes.h
// 
// Copyright (c) 2013 Aron Cedercrantz
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

