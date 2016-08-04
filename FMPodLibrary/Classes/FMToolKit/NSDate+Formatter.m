//
//  NSDate+Formatter.m
//  Garfield-Common
//
//  Created by Jack Zhou on 7/8/14.
//
//

#import "NSDate+Formatter.h"
#import "UtilsMacro.h"
static int secondsOneMinute = 60;
static int secondsOneHour = 60*60;
static int secondsOneDay = 60*60*24;
static int secondsOneWeek = 60*60*24*7;
static int secondsOneMonth = 60*60*24*30;
static int secondsOneYear =  60*60*24*30*12;
@implementation NSDate (Formatter)
- (NSString *)formatterModel1
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self];
    if(time>=secondsOneMonth) {
        return [dateFormatter stringFromDate:self];
    }
    return [self formatterModel2];
}

-(NSString *)formatterModel2
{
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self];
    if(time>=secondsOneYear){
        int year = time/secondsOneYear;
        return F(@"%d年前", year);
    }
    else if(time>=secondsOneMonth) {
        int month = time/secondsOneMonth;
        return F(@"%d个月前", month);
    }else if (time>=secondsOneWeek){
        int week = time/secondsOneWeek;
        NSArray * weeks= @[@"一",@"二",@"三",@"四"];
        return F(@"%@周前", weeks[week-1]);
    }else if(time<secondsOneWeek && time>=secondsOneDay){
        int day = time/secondsOneDay;
        return [NSString stringWithFormat:@"%d天前",day];
    }else if(time<secondsOneDay && time>=secondsOneHour) {
        int hour = time/secondsOneHour;
        return [NSString stringWithFormat:@"%d小时前",hour];
    }else if(time<secondsOneHour && time>=secondsOneMinute) {
        int min = time/secondsOneMinute;
        return [NSString stringWithFormat:@"%d分钟前",min];
    }else {
        return @"刚刚";
    }
}

-(NSString *)formatterModel3
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:self];
}

-(NSString *)formatterModel4
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy年MM月"];
    return [dateFormatter stringFromDate:self];
}

-(NSString *)formatterModel5
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *time = [dateFormatter stringFromDate:self];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    NSString *yesterday = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-secondsOneDay]];
    if([time isEqualToString:today]){
        [dateFormatter setDateFormat:@"HH:mm"];
        return F(@"今天  %@", [dateFormatter stringFromDate:self]);
    }
    else if([time isEqualToString:yesterday]){
        [dateFormatter setDateFormat:@"HH:mm"];
        return F(@"昨天  %@", [dateFormatter stringFromDate:self]);
    }
    else{
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *thisYear = [dateFormatter stringFromDate:[NSDate date]];
        time = [dateFormatter stringFromDate:self];
        if (![thisYear isEqualToString:time]) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm"];
            return [dateFormatter stringFromDate:self];
        }
        else{
            [dateFormatter setDateFormat:@"MM-dd  HH:mm"];
            return [dateFormatter stringFromDate:self];
        }
    }
}

-(NSString *)formatterModel6
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:self];
}
@end
