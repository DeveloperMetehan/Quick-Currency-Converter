//
//  CurrencyViewModel.swift
//  AltinBorsaDovizApp
//
//  Created by Metehan Karadeniz on 8.06.2023.
//
import Foundation
import Alamofire
import SwiftyJSON

class CurrencyViewModel {
    var currencies: [Currency] = []
    
    func fetchCurrencies(currencyValue:Int,to: String,base: String,completion: @escaping () -> Void) {
        let url = "https://api.collectapi.com/economy/exchange?int=\(currencyValue)&to=\(to)&base=\(base)"
        let headers: HTTPHeaders = [
            "content-type": "application/json",
            "authorization": "apikey 20oEymRvjN3mLWGjSmzqfd:1qY3v1jrslHl9vuDXev1k4"
        ]
        
        AF.request(url,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.parseCurrencies(json: json)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseCurrencies(json: JSON) {
        guard let dataArray = json["result"]["data"].array else {
            print("Invalid JSON structure")
            return
        }
        
        for currencyJSON in dataArray {
            guard let code = currencyJSON["code"].string,
                  let name = currencyJSON["name"].string,
                  let rateString = currencyJSON["rate"].string,
                  let rate = Double(rateString),
                  let calculatedstr = currencyJSON["calculatedstr"].string,
                  let calculated = Double(calculatedstr) else {
                print("Invalid currency data")
                continue
            }
            
            let currency = Currency(code: code, name: name, rate: rate, calculated: calculated)
            currencies.append(currency)
        }
    }
}
