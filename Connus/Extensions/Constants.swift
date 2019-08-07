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

//Colors
let lightBlueColor = UIColor(hexFromString: "008FFF")
let darkBlueColor = UIColor(hexFromString: "061D54")
let whiteColorInvisible = UIColor(hexFromString: "FAFAFA", alpha: CGFloat(integerLiteral: 0))
let whiteColor = UIColor(hexFromString: "FAFAFA", alpha: CGFloat(integerLiteral: 1))
let lightGrayColor = UIColor(hexFromString: "B9B9B9")
let nearlyBlackColor = UIColor(hexFromString: "171717")
let redColor = UIColor(hexFromString: "FF1200")
let greenColor = UIColor(hexFromString: "00FFB0")

//Social media platforms
let PLATFORMS = ["Instagram" : 0, "Facebook" : 1, "Twitter" : 2, "Youtube" : 3, "Snapchat" : 4, "Pinterest" : 5, "a" : 6, "b" : 7, "c" : 8, "d" : 9]
//Genres of interest
let GENRES = ["Art" : 0, "Music" : 1, "Lifestyle" : 2, "Gaming" : 3, "Food & Drinks" : 4, "Sports" : 5, "Movies" : 6]
