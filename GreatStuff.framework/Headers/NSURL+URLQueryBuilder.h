//
//  NSURL+URLQueryBuilder.h
//  NSURLComponents
//
//  Created by Yaroslav Arsenkin on 26.10.15.
//  Copyright © 2015 Iaroslav Arsenkin. All rights reserved.
//  Website: http://arsenkin.com
//

@import Foundation;

@interface NSURL (URLQueryBuilder)
NS_ASSUME_NONNULL_BEGIN

/*!
 Builds the request URL from incoming base URL and queries.
 
 @params URL String object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithString:(NSString *)URL queryElements:(NSDictionary<NSString *,NSString *> *)queryElements;

/*!
 Builds the request URL from incoming base URL and queries.
 
 @params URL URL object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithURL:(NSURL *)URL queryElements:(NSDictionary<NSString *,NSString *> *)queryElements;

/*!
 Builds the request URL from incoming base URL and queries, with ability to resolve URL against its base URL.
 
 @params URL String object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 @params resolveAgainstBaseURL BOOL object, that states, whether resolving against base URL should be done or not.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithString:(NSString *)URL queryElements:(NSDictionary<NSString *, NSString *> *)queryElements resolveAgainstBaseURL:(BOOL)resolve;

/*!
 Builds the request URL from incoming base URL and queries, with ability to resolve URL against its base URL.
 
 @params URL URL object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 @params resolveAgainstBaseURL BOOL object, that states, whether resolving against base URL should be done or not.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithURL:(NSURL *)URL queryElements:(NSDictionary<NSString *, NSString *> *)queryElements resolveAgainstBaseURL:(BOOL)resolve;

/*!
 Builds the request URL from incoming base URL and queries as well as ability to write NSURLComponents object that has been used to generate the URL for further use.
 
 @params URL String object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 @params URLComponent NSURLComponents, that has been created to generate the URL, is going to be written to this variable.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithString:(NSString *)URL queryElements:(NSDictionary<NSString *, NSString *> *)queryElements URLComponent:(NSURLComponents * _Nullable * _Nullable)URLComponent;

/*!
 Builds the request URL from incoming base URL and queries as well as ability to write NSURLComponents object that has been used to generate the URL for further use.
 
 @params URL URL object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 @params URLComponent NSURLComponents, that has been created to generate the URL, is going to be written to this variable.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithURL:(NSURL *)URL queryElements:(NSDictionary<NSString *, NSString *> *)queryElements URLComponent:(NSURLComponents * _Nullable * _Nullable)URLComponent;

/*!
 Builds the request URL from incoming base URL and queries, with ability to resolve URL against its base URL, as well as ability to write NSURLComponents object that has been used to generate the URL for further use.
 
 @params URL String object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 @params resolveAgainstBaseURL BOOL object, that states, whether resolving against base URL should be done or not.
 @params URLComponent NSURLComponents, that has been created to generate the URL, is going to be written to this variable.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithString:(NSString *)URL queryElements:(NSDictionary<NSString *, NSString *> *)queryElements resolveAgainstBaseURL:(BOOL)resolve URLComponent:( NSURLComponents * _Nullable * _Nullable)URLComponent;

/*!
 Builds the request URL from incoming base URL and queries, with ability to resolve URL against its base URL, as well as ability to write NSURLComponents object that has been used to generate the URL for further use.
 
 @params URL String object, that represents base URL.
 @params queryElements Dictionary of query elements. Key is query name and value is query's value.
 @params resolveAgainstBaseURL BOOL object, that states, whether resolving against base URL should be done or not.
 @params URLComponent NSURLComponents, that has been created to generate the URL, is going to be written to this variable.
 
 @return NSURL Complete request URL ready for use.
 */
+ (NSURL *)gs_queryWithURL:(NSURL *)URL queryElements:(NSDictionary<NSString *, NSString *> *)queryElements resolveAgainstBaseURL:(BOOL)resolve URLComponent:(NSURLComponents * _Nullable * _Nullable)URLComponent;

NS_ASSUME_NONNULL_END
@end
