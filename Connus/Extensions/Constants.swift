//
//  Constants.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 24/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import Foundation
import Firebase

//Influencer document variables
let FIRSTNAME = "name"
let LASTNAME = "lastname"
let BIRTHDAY = "birthdate"
let GENDER = "gender"
let EMAIl = "email"
let COUNTRY = "country"
let PHONE = "phone"
let QUOTE = "quote"
let PROFILEURL = "profilepicture"

//Firebase collection paths
let INFLUENCERPATH = "influencers"
let COMPANIESPATH = "companies"
let BADGES = "badges"
let CHATS = "chats"

//Firestore
let db = Firestore.firestore()

//Firebase Storage
let storage = Storage.storage()
