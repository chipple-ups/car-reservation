//
//  myReserveInfo.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/13.
//

import UIKit
import Firebase

class myReserveInfo: NSObject {
    var id: String
    var name: String?
    var info: String?
    var pay: String?
    var address: String?

    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.info = postDic["info"] as? String

        self.address = postDic["address"] as? String

        self.pay = postDic["pay"] as? String





}
}
