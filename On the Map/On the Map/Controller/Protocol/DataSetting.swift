//
//  DataSetting.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

protocol DataSetting {
    
    //Call to the Udacity API.
    func setViewData()
    
    func setViewData(dataCodable: Results?)
    
    //refresh data
    func refresh()
}
