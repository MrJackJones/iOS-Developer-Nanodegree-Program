//
//  Result.swift
//  FINAL-ND
//
//  Created by Ivan on 17.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import Foundation

enum Response<T, U> where U: Error  {
  case success(T)
  case failure(U)
}
