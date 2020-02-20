//
//  StarwarsError.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

enum APIError: String, Error {
  case requestFailed = "Request Failed"
  case jsonConversionFailure = "JSON Conversion Failure"
  case invalidData = "Invalid Data"
  case responseUnsuccessful = "Response Unsuccessful"
  case jsonParsingFailure = "JSON Parsing Failure"
  case connectionLost = "Lost Network Connection"
  case notConnectToInternet = "No Network Connection"
}
