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
    var user: String?
    var place: String?
    var item: String?
    var noc: String?
    var date: Date?

    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        self.user = postDic["user"] as? String

        self.place = postDic["place"] as? String

        self.item = postDic["item"] as? String

        self.noc = postDic["noc"] as? String




}
}
