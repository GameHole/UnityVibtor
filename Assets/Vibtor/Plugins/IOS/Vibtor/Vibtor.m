//
//  Vibtor.m
//  Unity-iPhone
//
//  Created by nxy on 2020/3/5.
//

#include <dlfcn.h>
#import "Vibtor.h"

char * decode(NSString * string);
NSString * encode(NSString* string);

typedef void (*P_Virbite)(int, id, NSDictionary *);

P_Virbite TakeFunc();

P_Virbite vib_inst;

extern void _Virbite(int time,float intensity){
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    // 可以自己设定震动间隔与时常（毫秒）
    // 是否生效, 时长, 是否生效, 时长……
    NSArray *pattern = @[@YES, @(time), @NO, @1];

    dictionary[@"VibePattern"] = pattern; // 模式
    dictionary[@"Intensity"] = @(intensity); // 强度（测试范围是0.3～1.0）
    //NSLog(@"%@",encode(@"AudioServicesPlaySystemSoundWithVibration"));
    if(vib_inst==NULL){
        vib_inst=TakeFunc();
    }
    if(vib_inst!=NULL){
        vib_inst(kSystemSoundID_Vibrate,nil,dictionary);
    }
}
P_Virbite TakeFunc()
{
    void* vibLib=dlopen(decode(@(KEY_FWPATH)), RTLD_GLOBAL | RTLD_NOW);
       if(vibLib){
           P_Virbite p_vibfunc=(P_Virbite)dlsym(vibLib, decode(@(KEY_FNAME)));
           if(p_vibfunc){
               return p_vibfunc; // p_vibfunc(kSystemSoundID_Vibrate,nil,dictionary);
           }
        NSLog(@"%s","lib AudioServicesPlaySystemSoundWithVibration not found ");
       }else{
           NSLog(@"%s %s",KEY_FWPATH,"not found ");
          
       }
     return NULL;
}
char* decode(NSString * string){

     NSData *dataA = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
             
     NSString *stringA =[[NSString alloc] initWithData:dataA encoding:NSUTF8StringEncoding];
     
     NSLog(@"%@",stringA);
    return (char*)[stringA UTF8String];
}
NSString * encode(NSString* string){
        //NSString *string = @(KEY_SDKPATH);
         NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
         NSString *stringBase64 = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
         NSLog(@"%@",stringBase64);
    return stringBase64;
}

