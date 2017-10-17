//
//  Constants.swift
//  Album List
//
//  Created by Alex Poddubnyy on 15.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import Foundation


/*:
     1. ParseError - Data parsing error
     2. NoFind - Uncorrect request string or artist does`t have any albums
     3. RequestError - Problem with internet connection, server, request error and more, returned by Alamofire
 */
enum ErrorType: String {
    case ParseError = "Parsing error"
    case NoFind = "No found albums"
    case RequestError = "Request error..."
}

/*:
     1. Sucess - Items foud, arrray contain one or more items
     2. Erorr - Request problem
 */
enum RequestStatus {
    case Sucess
    case Error(error: ErrorType)
}
