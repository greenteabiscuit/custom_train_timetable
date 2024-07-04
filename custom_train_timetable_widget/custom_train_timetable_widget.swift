//
//  custom_train_timetable_widget.swift
//  custom_train_timetable_widget
//
//  Created by lvcha mmm on 2024/01/03.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    static var trainSchedule: [TimePoint] = [
        // 東十条平日
        TimePoint(hour: 04, min: 32, origin: "東十条", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 05, min: 34, origin: "東十条", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 06, min: 56, origin: "東十条", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 08, min: 46, origin: "赤羽", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 09, min: 08, origin: "赤羽", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 09, min: 31, origin: "赤羽", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 09, min: 49, origin: "赤羽", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 10, min: 01, origin: "赤羽", dest: "蒲田", departure: "東十条", dayType: .weekday),
        TimePoint(hour: 10, min: 31, origin: "赤羽", dest: "蒲田", departure: "東十条", dayType: .weekday),
        
        // 東十条休日
        TimePoint(hour: 04, min: 32, origin: "東十条", dest: "大船", departure: "東十条", dayType: .weekend),
        TimePoint(hour: 05, min: 34, origin: "東十条", dest: "大船", departure: "東十条", dayType: .weekend),
        TimePoint(hour: 07, min: 20, origin: "東十条", dest: "大船", departure: "東十条", dayType: .weekend),
        TimePoint(hour: 06, min: 31, origin: "赤羽", dest: "武蔵小杉", departure: "東十条", dayType: .weekend),
        TimePoint(hour: 15, min: 23, origin: "東十条", dest: "磯子", departure: "東十条", dayType: .weekend),
        
        // 王子神谷平日
        TimePoint(hour: 10, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        // Add some TimePoint instances to the array
        TimePoint(hour: 11, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 11, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 11, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 11, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 11, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),

        TimePoint(hour: 12, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 12, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 12, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 12, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 12, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),

        TimePoint(hour: 13, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 13, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 13, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 13, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 13, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        
        TimePoint(hour: 14, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 14, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 14, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 14, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 14, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),

        TimePoint(hour: 15, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 15, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 15, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 15, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 15, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),

        TimePoint(hour: 16, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 16, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 16, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 16, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),

        TimePoint(hour: 17, min: 0, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        
        TimePoint(hour: 22, min: 39, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 23, min: 20, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekday),
        TimePoint(hour: 23, min: 58, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekday),
        
        // 王子神谷休日
        TimePoint(hour: 7, min: 31, origin: "王子神谷", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 7, min: 47, origin: "王子神谷", dest: "横浜", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 9, min: 17, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 9, min: 30, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 9, min: 48, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 10, min: 00, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 10, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 10, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 10, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 10, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 11, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 11, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 11, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 11, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 11, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 12, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 12, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 12, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 12, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 12, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 13, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 13, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 13, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 13, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 13, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 14, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 14, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 14, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 14, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 14, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 15, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 15, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 15, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 15, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 15, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 16, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 16, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 16, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 16, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 16, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 17, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 17, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 17, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 17, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 17, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 18, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 18, min: 14, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 18, min: 26, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 18, min: 38, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 18, min: 50, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 19, min: 02, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 19, min: 29, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 19, min: 59, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),

        TimePoint(hour: 20, min: 06, origin: "赤羽岩淵", dest: "武蔵小杉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 20, min: 30, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 20, min: 59, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 21, min: 59, origin: "赤羽岩淵", dest: "横浜", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 22, min: 28, origin: "赤羽岩淵", dest: "日吉", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 23, min: 08, origin: "赤羽岩淵", dest: "白金高輪", departure: "王子神谷", dayType: .weekend),
        TimePoint(hour: 23, min: 31, origin: "赤羽岩淵", dest: "武蔵小杉", departure: "王子神谷", dayType: .weekend),
        
        TimePoint(hour: 5, min: 0, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 5, min: 12, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 5, min: 26, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 5, min: 36, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 5, min: 46, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 5, min: 57, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 5, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 12, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 17, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 27, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 35, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 38, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 42, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 50, origin: "代々木上原", dest: "松戸", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 6, min: 55, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 7, min: 5, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 7, min: 14, origin: "代々木上原", dest: "松戸", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 7, min: 21, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 7, min: 32, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 7, min: 41, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 7, min: 53, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 2, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 12, origin: "代々木上原", dest: "松戸", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 16, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 22, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 27, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 33, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 38, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 43, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 48, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 8, min: 56, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 6, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 8, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 19, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 22, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 28, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 31, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 40, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 43, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 9, min: 56, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 8, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 15, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 10, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 4, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 11, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 14, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 12, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 4, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 13, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 14, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 14, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 14, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 15, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 4, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 8, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 14, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 18, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 25, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 28, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 32, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 36, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 39, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 46, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 51, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 16, min: 59, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 8, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 12, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 22, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 25, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 33, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 37, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 44, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 47, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 53, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 56, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 17, min: 59, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 7, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 16, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 23, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 26, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 33, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 36, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 39, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 46, origin: "代々木上原", dest: "取手", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 18, min: 55, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 4, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 8, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 17, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 26, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 35, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 45, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 51, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 19, min: 55, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 5, origin: "代々木上原", dest: "柏", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 16, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 25, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 38, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 46, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 20, min: 57, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 21, min: 7, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 21, min: 16, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 21, min: 26, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 21, min: 35, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 21, min: 40, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 21, min: 50, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 1, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 7, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 12, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 18, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 23, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 29, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 35, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 46, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 52, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 22, min: 58, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 4, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 10, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 16, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 22, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 28, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 38, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 45, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 23, min: 52, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 0, min: 0, origin: "代々木上原", dest: "松戸", departure: "代々木上原", dayType: .weekday),
        TimePoint(hour: 5, min: 0, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 5, min: 12, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 5, min: 26, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 5, min: 38, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 5, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 5, min: 58, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 6, min: 6, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 6, min: 14, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 6, min: 23, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 6, min: 31, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 6, min: 44, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 6, min: 51, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 7, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 14, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 28, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 34, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 45, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 50, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 7, min: 55, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 6, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 11, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 16, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 25, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 30, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 35, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 45, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 50, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 8, min: 55, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 8, origin: "代々木上原", dest: "松戸", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 14, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 24, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 34, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 44, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 9, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 14, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 34, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 44, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 10, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 4, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 11, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 15, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 12, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 14, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 13, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 14, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 34, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 14, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 4, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 24, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 34, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 44, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 15, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 4, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 24, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 34, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 44, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 16, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 4, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 9, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 14, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 24, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 34, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 43, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 17, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 5, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 10, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 15, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 27, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 32, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 43, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 18, min: 54, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 5, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 10, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 15, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 21, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 32, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 44, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 19, min: 50, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 1, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 7, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 13, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 25, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 31, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 42, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 48, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 20, min: 54, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 0, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 12, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 24, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 29, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 36, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 48, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 21, min: 55, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 22, min: 3, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 22, min: 20, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 22, min: 31, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 22, min: 39, origin: "代々木上原", dest: "綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 22, min: 49, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 22, min: 58, origin: "代々木上原", dest: "北綾瀬", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 23, min: 6, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 23, min: 16, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 23, min: 27, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 23, min: 38, origin: "代々木上原", dest: "我孫子", departure: "代々木上原", dayType: .weekend),
        TimePoint(hour: 23, min: 55, origin: "代々木上原", dest: "松戸", departure: "代々木上原", dayType: .weekend),


    ]
    
    // Define the class with two Int fields: hour and min
    class TimePoint {
        var hour: Int
        var min: Int
        var date: Date
        var origin: String
        var departure: String
        var dest: String
        var dayType: DayType
        
        init(hour: Int, min: Int, origin: String, dest: String, departure: String, dayType: DayType) {
            let today = Calendar.current.startOfDay(for: Date())
            self.hour = hour
            self.min = min
            self.date = Calendar.current.date(bySettingHour: hour, minute: min, second: 0, of: today)!
            self.dest = dest
            self.origin = origin
            self.departure = departure
            self.dayType = dayType
        }
    }
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), id: "王子神谷", origin: "王子神谷", departure: "王子神谷", dayType: .weekend)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, id: "東十条", origin: "東十条", departure: "東十条", dayType: .weekend)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let seconds = Calendar.current.component(.second, from: currentDate)
        let startDate = Calendar.current.date(byAdding: .second, value: -seconds, to: currentDate)!
        let entries = (0 ..< 60).map {
            let date = Calendar.current.date(byAdding: .second, value: $0 * 60 - 1, to: startDate)!
            let otherDate = Calendar.current.date(byAdding: .second, value: $0 * 60, to: startDate)!
            let (first, second, origin, dayType) = getNextSchedule(now: otherDate, stationName: configuration.station.id)
            return SimpleEntry(date: date, configuration: configuration, id: configuration.station.id, closestDate: first, secondClosestDate: second, origin: origin ?? "", departure: configuration.station.origin, dayType: dayType)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    
    // func name: getNextSchedule
    // input: None
    // output: Date?, Date?
    // description:
    // 1. Get the current time
    // 2. Get the current weekday
    // 3. Get the current hour
    // 4. Get the current minute
    // 5. Call isWeekend by passing the current time
    // 6. if result is true, enumerate through the weekendSchedule array until
    // the difference between the current time and the time in the array is the least
    // and the current time is still before the time in the array
    // 7. if result is false, enumerate through the weekdaySchedule array until
    // the difference between the current time and the time in the array is the least
    // and the current time is still before the time in the array
    // 8. return the time in the array and the time in the array after that
    // if the time in the array is the last one, return nil for the second return value
    // 9. If there is none, return nil
    func getNextSchedule(now: Date, stationName: String) -> (Date?, Date?, String?, DayType) {
        let calendar = Calendar.current
        
        // Get the current hour and minute
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        
        // Get the current weekday
        let components = calendar.dateComponents([.weekday], from: now)
        
        if let weekday = components.weekday {
            // Sunday = 1, Saturday = 7, Weekdays = 2-6
            if weekday == 1 || weekday == 7 {
                // for weekend!
                let weekendSchedule = Provider.trainSchedule.filter { $0.dayType == .weekend && $0.departure == stationName }
                for (index, condition) in weekendSchedule.enumerated() {
                    if (hour < condition.hour) || (hour == condition.hour && minute < condition.min) {
                        if (index + 1 == weekendSchedule.count) {
                            return (condition.date, nil, condition.origin, .weekend)
                        }
                        return (condition.date, weekendSchedule[index + 1].date, condition.origin, .weekend)
                    }
                }
            } else {
                // for weekday
                let weekdaySchedule = Provider.trainSchedule.filter({$0.dayType == .weekday && $0.departure == stationName})
                
                for (index, condition) in weekdaySchedule.enumerated() {
                    if (hour < condition.hour) || (hour == condition.hour && minute < condition.min) {
                        if (index + 1 == weekdaySchedule.count) {
                            return (condition.date, nil, condition.origin, .weekday)
                        }
                        return (condition.date, weekdaySchedule[index + 1].date, condition.origin, .weekday)
                    }
                }
            }
        }
        return (nil, nil, nil, .weekday)
    }
}

enum DayType {
    case weekday
    case weekend
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let id: String
    var closestDate: Date? = .now
    var secondClosestDate: Date? = .now
    let origin: String
    let departure: String
    let dayType: DayType
}

struct custom_train_timetable_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                contentView
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("次のダイヤ")
                    .foregroundColor(.gray)
                if entry.secondClosestDate != nil {
                    Text("\(entry.secondClosestDate!, formatter: Self.dateFormatter)")
                    .foregroundColor(.gray)
                } else {
                    Text("なし")
                    .foregroundColor(.gray)
                }
                    
            }
        }
        .containerBackground(.clear, for: .widget)
    }
    
    @ViewBuilder
    private var contentView: some View {
        HStack {
            if entry.id == "東十条" {
                Circle()
                    .fill(Color(red: 0.39, green: 0.82, blue: 1.00))
                    .frame(width: 10, height: 10)
            } else {
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
            }
            if entry.dayType == .weekday {
                Text("平日\n\(entry.id)\n\(entry.origin)発").font(.system(size: 14))
            } else {
                Text("休日\n\(entry.id)\n\(entry.origin)発").font(.system(size: 14))
            }
            if entry.closestDate != nil {
                Text("\(entry.closestDate!, formatter: Self.dateFormatter)")
            } else {
                Text("なし")
            }
        }
        if entry.closestDate != nil {
            Text(entry.closestDate!, style: .timer)
                .font(.system(size: 30))
        }
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

struct custom_train_timetable_widget: Widget {
    let kind: String = "custom_train_timetable_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            custom_train_timetable_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent(station: StationName(id: "default", avatar: "🐼", healthLevel: 0.77, origin: "something"))
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent(station: StationName(id: "default", avatar: "🐼", healthLevel: 0.77, origin: "something"))
        return intent
    }
    
    fileprivate static var yoyogiUehara: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent(station: StationName(id: "default", avatar: "🐼", healthLevel: 0.77, origin: "something"))
        return intent
    }
}

#Preview(as: .systemSmall) {
    custom_train_timetable_widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, id: "東十条", origin: "赤羽", departure: "東十条", dayType: .weekday)
    SimpleEntry(date: .now, configuration: .starEyes, id: "王子神谷", origin: "赤羽岩淵", departure: "王子神谷", dayType: .weekday)
    SimpleEntry(date: .now, configuration: .yoyogiUehara, id: "代々木上原", origin: "代々木上原", departure: "代々木上原", dayType: .weekday)
}


