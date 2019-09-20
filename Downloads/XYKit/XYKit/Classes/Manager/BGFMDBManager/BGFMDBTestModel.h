//
//  BGFMDBTestModel.h
//  BaseObjSet
//
//  Created by 元潇 on 2018/12/20.
//  Copyright © 2018 元潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h" // model必须引用该头文件

@class BGFMDBTestModel, User, Human;
NS_ASSUME_NONNULL_BEGIN

@interface BGFMDBTestModel : NSObject {
@public
    int testAge;
    NSString* testName;
}

@property(nonatomic,copy)NSString* XXXXXXname;
@property(nonatomic,copy)NSString* name;
//@property(nonatomic,strong)NSNumber* num;
//@property(nonatomic,assign)int age;
@property(nonatomic,copy)NSString* sex;
//@property(nonatomic,copy)NSString* eye;
//@property(nonatomic,copy)NSString* sex_old;
//@property(nonatomic,strong)NSArray* students;
//@property(nonatomic,strong)NSDictionary* infoDic;
//@property(nonatomic,strong)User* user;//第一层类嵌套
//@property(nonatomic,strong)User* user1;
//
@property(nonatomic,assign)int bint1;
//@property(nonatomic,assign)short bshort;
//@property(nonatomic,assign)signed bsigned;
//@property(nonatomic,assign)long long blonglong;
//@property(nonatomic,assign)unsigned bunsigned;
//@property(nonatomic,assign)float bfloat;
//@property(nonatomic,assign)double bdouble;
//@property(nonatomic,assign)CGFloat bCGFloat;
//@property(nonatomic,assign)NSInteger bNSInteger;
//@property(nonatomic,assign)long blong;
@property(nonatomic,assign)BOOL addBool;

//@property(nonatomic,assign)CGRect rect;
//@property(nonatomic,assign)CGPoint point;
//@property(nonatomic,assign)CGSize size;
//@property(nonatomic,assign)NSRange range;
//
//@property(nonatomic,strong)NSMutableArray* arrM;
//@property(nonatomic,strong)NSMutableArray* datasM;
//@property(nonatomic,strong)NSMutableDictionary* dictM;
//@property(nonatomic,strong)NSSet* nsset;
//@property(nonatomic,strong)NSMutableSet* setM;
//@property(nonatomic,strong)NSMapTable* mapTable;
//@property(nonatomic,strong)NSHashTable* hashTable;
//
//@property(nonatomic,strong)NSDate* date;
//@property(nonatomic,strong)NSData* data2;
////@property(nonatomic,strong)NSMutableData* dataM;
//@property(nonatomic,strong)UIImage* image;
//@property(nonatomic,strong)UIColor* color;
//@property(nonatomic,strong)NSAttributedString* attriStr;
//
//@property(nonatomic,strong)NSURL* Url;
//
@property(nonatomic,strong)Human *human;
@end


@interface Human : NSObject

@property(nonatomic,copy)NSString* sex;
@property(nonatomic,copy)NSString* body;
@property(nonatomic,assign)NSInteger humanAge;
@property(nonatomic,assign)int age;
@property(nonatomic,assign)int num;
@property(nonatomic,assign)int counts;
@property(nonatomic,copy)NSString* food;
@property(nonatomic,strong)NSData* data;
@property(nonatomic,strong)NSArray* array;
@property(nonatomic,strong)NSDictionary* dict;
@end

@interface Student : NSObject

@property(nonatomic,copy)NSString* num;
@property(nonatomic,strong)NSArray* names;
@property(nonatomic,strong)Human* human;
@property(nonatomic,assign)int count;
@end

@interface User : NSObject

@property(nonatomic,strong)NSDictionary* attri;
@property(nonatomic,strong)NSNumber* userNumer;
@property(nonatomic,strong)Student* student;//第二层类嵌套 , 可以无穷嵌套...
@property(nonatomic,strong)BGFMDBTestModel *userP;
@property(nonatomic,assign)int userAge;
@property(nonatomic,copy)NSString* name;
@end


@interface Man : NSObject

@property(nonatomic,copy)NSString* Man_name;
@property(nonatomic,strong)NSNumber* Man_num;
@property(nonatomic,assign)int Man_age;
@property(nonatomic,strong)UIImage* image;

@end

@class T1;
@interface testT:NSObject
@property(nonatomic,strong) id t1;
@end

@interface T1:  NSObject
@property(nonatomic,copy) NSString* name;
@end

@interface T2: T1
@property(nonatomic,copy) NSString* t2;
@end

@interface T3 : T1
@property(nonatomic,copy) NSString* t3;
@property(nonatomic,strong) id t2;
@end

NS_ASSUME_NONNULL_END
