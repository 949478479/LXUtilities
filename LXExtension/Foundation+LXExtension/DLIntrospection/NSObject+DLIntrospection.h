//
//  NSObject+DLIntrospection.h
//  DLIntrospection
//
//  Created by Denis Lebedev on 12/27/12.
//  Copyright (c) 2012 Denis Lebedev. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DLIntrospection)

+ (NSArray<NSString *> *)dl_ivarList;
+ (NSArray<NSString *> *)dl_propertyList;

+ (NSArray<NSString *> *)dl_classMethodList;
+ (NSArray<NSString *> *)dl_instanceMethodList;

+ (NSString *)dl_inheritanceTree;
+ (NSArray<NSString *> *)dl_protocolList;

+ (void)dl_printIvarList;
+ (void)dl_printPropertyList;

+ (void)dl_printClassMethodList;
+ (void)dl_printInstanceMethodList;

+ (void)dl_printProtocolList;
+ (void)dl_printInheritanceTree;

@end

NSArray<NSString *> * DLClassList();
NSDictionary<NSString *, NSArray<NSString *> *> * DLDescriptionForProtocol(Protocol *proto);

void DLPrintClassList();
void DLPrintDescriptionForProtocol(Protocol *proto);

NS_ASSUME_NONNULL_END
