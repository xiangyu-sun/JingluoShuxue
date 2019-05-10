//
//  JingluoType.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/20/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import Foundation

let 气血循环流注: [十二经脉] = [.手太阴肺经, .手阳明大肠经, .足阳明胃经, .足太阴脾经, .手少阴心经, .手太阳小肠经, .足太阳膀胱经, .足少阴肾经, .手厥阴心包经, .手少阳三焦经, .足少阳胆经, .足厥阴肝经]

let 十四经脉: [经络组成] = [十二经脉.手太阴肺经,  十二经脉.手阳明大肠经,  十二经脉.足阳明胃经,  十二经脉.足太阴脾经,  十二经脉.手少阴心经,  十二经脉.手太阳小肠经,  十二经脉.足太阳膀胱经,  十二经脉.足少阴肾经,  十二经脉.手厥阴心包经,  十二经脉.手少阳三焦经,  十二经脉.足少阳胆经,  十二经脉.足厥阴肝经,  奇经八脉.督脉]

protocol 经络组成 {
    
}


//    case 十二经别
//    case 十二经筋
//
//    case 十二皮部
//
//    case 十五络脉
//    case 浮络
//    case 孙络

enum 十二经脉: String, 经络组成{
    case 手太阴肺经 = "手太阴肺经"
    case 手少阴心经 = "手少阴心经"
    case 手厥阴心包经 = "手厥阴心包经"
    case 手阳明大肠经 = "手阳明大肠经"
    case 手太阳小肠经 = "手太阳小肠经"
    case 手少阳三焦经 = "手少阳三焦经"
    case 足太阴脾经 = "足太阴脾经"
    case 足少阴肾经 = "足少阴肾经"
    case 足厥阴肝经 = "足厥阴肝经"
    case 足阳明胃经 = "足阳明胃经"
    case 足太阳膀胱经 = "足太阳膀胱经"
    case 足少阳胆经 = "足少阳胆经"
    
    func 是阳吗() -> Bool {
        return self.rawValue.contains("阳")
    }
}
enum 奇经八脉: String, 经络组成{
    case 督脉 = "督脉"
    case 任脉 = "任脉"
    case 冲脉 = "冲脉"
    case 代脉 = "代脉"
    case 阴维脉 = "阴维脉"
    case 阳维脉 = "阳维脉"
    case 阴脉 = "阴脉"
    case 阳脉 = "阳脉"
}

enum 人体部位 {
    case 头面
    case 面额部
    case 颊部
    case 头顶
    case 头后部
    case 枕项部
    case 耳颞部
    case 目系
    case 巅顶
    case 舌根
    case 舌本
    case 舌下
    case 胸部
    case 腋下
    case 肩部
    case 肩胛部
    case 肋部
    case 腹胸
    case 前胸
    case 前腹部
    case 背部
    case 侧部
    case 上肢
    case 下肢
    case 颌部
}

