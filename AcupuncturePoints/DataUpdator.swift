//
//  DataUpdator.swift
//  AcupuncturePoints
//
//  Created by xiangyu sun on 10/20/17.
//  Copyright © 2017 xiangyu sun. All rights reserved.
//

import UIKit
import CoreData

class DataUpdator {
    
    init() {
        
    }
    
    func checkDataVersion(managedObjectContext: NSManagedObjectContext) {
        
        guard let name = Jingluo.entity().name else{
            return
        }
        let request = NSFetchRequest<NSNumber>(entityName: name)
    
        request.resultType = .countResultType
        
        let count = try? managedObjectContext.fetch(request)
        
        if count?.first?.int64Value == 0 {
            loadData(managedObjectContext: managedObjectContext)
        }
    }
    
    func loadData(managedObjectContext: NSManagedObjectContext) {
        let url = Bundle.main.url(forResource: "Shuxues", withExtension: "plist")!
        
        guard let dict = NSDictionary(contentsOf: url) else {
            return
        }
        
        let allshuxues = JSON(dict)
        let yangs = 气血循环流注.filter{ $0.是阳吗() }
        let yins = 气血循环流注.filter{ !$0.是阳吗() }
        
        let pairs = zip(yangs, yins)
        
        pairs.forEach { (yang, yin) in
            let yangJinLuo = setup(jingmai: yang, allshuxues: allshuxues, managedObjectContext: managedObjectContext)
            let yinJinLuo = setup(jingmai: yin, allshuxues: allshuxues, managedObjectContext: managedObjectContext)
            yinJinLuo.biao = yangJinLuo
        }
        
        
        addQixue(managedObjectContext: managedObjectContext)
        
        addShaoerQixue(managedObjectContext: managedObjectContext)
        
        try? managedObjectContext.save()
    }
    
    func setup(jingmai: 十二经脉, allshuxues: JSON, managedObjectContext: NSManagedObjectContext) ->  Jingluo{
        let jinluo = Jingluo(context: managedObjectContext)
        jinluo.name = jingmai.rawValue
        jinluo.jing = true
        jinluo.yang = jingmai.是阳吗()
        
        let shuxues = allshuxues[jingmai.rawValue].arrayValue
        
        shuxues.forEach({ (shuxueJSON) in
            let shuxue = Shuxue(context: managedObjectContext)
            shuxue.name = (shuxueJSON)["name"].string
            shuxue.locating = (shuxueJSON)["locating"].string
            shuxue.mainCures = (shuxueJSON)["mainCures"].string
            
            jinluo.addToShuxues(shuxue)
        })
        
        return jinluo
    }
    
    
    func addQixue(managedObjectContext: NSManagedObjectContext) {
        let allQixue = ["ToubuQiXue","FubuQixue","ShangzhiQixue","BeibuQixue","XiazhiQixue"]
        
        allQixue.forEach { (fileName) in
            let url = Bundle.main.url(forResource: fileName, withExtension: "plist")!
            
            guard let array = NSArray(contentsOf: url) else {
                return
            }
            
            let allshuxues = JSON(array).arrayValue
            
            allshuxues.forEach({ (qixue) in
                let shuxue = Shuxue(context: managedObjectContext)
                shuxue.name = (qixue)["name"].string
                shuxue.locating = (qixue)["locating"].string
                shuxue.mainCures = (qixue)["mainCures"].string
            })
        }
    }
    
    func addShaoerQixue(managedObjectContext: NSManagedObjectContext) {
        let fileName = "ShaoerShuxue"
        let url = Bundle.main.url(forResource: fileName, withExtension: "plist")!
        
        guard let array = NSArray(contentsOf: url) else {
            return
        }
        
        let allshuxues = JSON(array).arrayValue
        
        allshuxues.forEach({ (qixue) in
            let shuxue = Shuxue(context: managedObjectContext)
            shuxue.name = (qixue)["name"].string
            shuxue.locating = (qixue)["locating"].string
            shuxue.mainCures = (qixue)["mainCures"].string
            shuxue.effect = (qixue)["effect"].string
            shuxue.appliance = (qixue)["application"].arrayObject as NSObject?
            shuxue.earlyChildhood = true
        })
    }
    
}
