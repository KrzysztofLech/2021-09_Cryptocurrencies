//
//  ErrorResult.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import Foundation

enum ErrorResult: String, Error {
    case url = "Wrong url format"
    case noInternet = "No Internet"
    case network = "Failed to fetch data"
    case statusCode = "Response Status Code is not OK"
    case other = "Fetched data problem"
    case parse = "Parse data problem"
}
