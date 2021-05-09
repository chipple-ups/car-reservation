//
//  PlaceInfo.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/08.
//

import UIKit
import Firebase

class PlaceInfo: NSObject {
    var id: String
    var name: String?
    var info: String?
    var pay: String?
    var date: Date?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.info = postDic["info"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()



}
}
