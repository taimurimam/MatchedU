//
//  CountryModel.swift
//  Aikina
//
//  Created by Sk Azad on 07/06/23.
//

import UIKit
import SwiftyJSON

public struct CountryModel: Equatable, Hashable {

    public var code: CountryCodes
    public var name: String
    public var phoneCode: String
    var flag: UIImage?

    init(code: String, name: String, phoneCode: String) {
        self.name = name
        self.phoneCode = phoneCode
        self.code = CountryCodes(rawValue: code)!

        if let flag = UIImage(named: code) {
            self.flag = flag
        } else {
            self.flag = UIImage(named: "unknown")
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    static public func ==(lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.code == rhs.code
    }
    
    static func getAllCountries() -> [CountryModel] {
        var arr = [CountryModel]()
        
        if let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                let json = JSON(jsonResult)
                for item in json.arrayValue
                {
                    arr.append(CountryModel(code: item["code"].stringValue, name: item["name"].stringValue, phoneCode: item["dial_code"].stringValue))
                }
            } catch {
                   
              }
        }
        
        return arr
    }
    
    static func getCurrentCountry() -> CountryModel? {
        let countries = CountryModel.getAllCountries()

        if let regionCode = Locale.current.region?.identifier, let countryCode = CountryCodes(rawValue: regionCode) {
            return countries.first(where: { $0.code == countryCode })
        }
        
        return nil
    }
    
    static func getCountryBy(phoneCode: String) -> CountryModel {
        let filteredCountries = CountryModel.getAllCountries().filter { country in
            return country.phoneCode == phoneCode
        }
        
        return filteredCountries.first ?? CountryModel.getDefaultCountry()
    }
    
    static func getDefaultCountry() -> CountryModel
    {
        return CountryModel(code: "US", name: "United States", phoneCode: "+1")
    }
}

