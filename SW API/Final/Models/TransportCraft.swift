//
//  TransportCraft.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import Foundation

protocol TransportCraft {
  var name: String { get }
  var manufacturer: String { get }
  var costInCredits: String { get }
  var length: String { get }
  var ´class´: String { get }
  var crew: String { get }
  var url: URL { get }
}

extension TransportCraft {
  var idByURL: String {
    return url.lastPathComponent
  }
}
