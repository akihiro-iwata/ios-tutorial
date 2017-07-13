//
//  Shows.swift
//  ios-tutorial
//
//  Created by 岩田彬広 on 2017/07/12.
//  Copyright © 2017年 com.Akihiro.Iwata. All rights reserved.
//

import Foundation

class Shows: NSObject {

    let ShowId: String
    let LastUpdateDate: String
    
    public func initWithDictionary(dic: NSDictionary) {
        
        //check if all required properties are present
        let incomingKeys = dic.allKeys
        
        

    
    }
    
    public init(showId: String, lastUpdateDate: String){
        self.ShowId = showId
        self.LastUpdateDate = lastUpdateDate
    }
    
    

}
