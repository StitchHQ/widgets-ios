//
//  Service.swift
//  Stitchdemo
//
//  Created by vizhi on 10/08/23.
//

import Foundation
import UIKit
import Alamofire


public func baseUrl() -> (String) {
    if hasJailbreak() == CardSDKError.insecureEnvironment {
        return CardSDKError.insecureEnvironment.localizedDescription.description
    }
    
    return ""
}

enum servicesURL :String{
    
    //View Card
    case sessionKey = "secure/sessionkey"
    case secureCard = "secure/card"
    case setPin = "secure/setpin"
    case changePin = "secure/changepin"
}
class ServiceNetworkCall : NSObject{

    var parameters = Parameters()
    var method: HTTPMethod!
    var url :String? = ""
    var encoding: ParameterEncoding! = JSONEncoding.default
    let activityInstance = Indicator()

    init(data: [String:Any],url :String?, method: HTTPMethod = .post, isJSONRequest: Bool = true){
        super.init()
       
        data.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        self.url = url
        self.method = method

    }

    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if Reachability.isConnectedToNetwork(){
            let number = arc4random()
            self.activityInstance.showIndicator()
        
            let head: HTTPHeaders = ["X-Correlation-ID": "\(number)"]
            
            AF.request(url!,method: method,parameters: parameters,encoding: encoding, headers: head).responseData(completionHandler: {response in
                switch response.result{
                case .success(let res):
                    self.activityInstance.hideIndicator()
                    if let code = response.response?.statusCode{
                        switch code {
                        case 200...299:
                            do {
                                completion(.success(try JSONDecoder().decode(T.self, from: res)))
                            } catch let error {
                                completion(.failure(error))
                            }
                        default:
                            self.activityInstance.hideIndicator()

                            let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                            if let data = response.data {
                                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                                    if let errorString = json["message"] {
                                        showAlertMessage(str: errorString)
                                    }
                                }
                            }
                     
                                completion(.failure(error))
                            
                            
                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode{
                        self.activityInstance.hideIndicator()
                        completion(.failure(error))
                    }
                }
            })
        }else{
            showAlertMessage(str: "Please check your Internet connection")

        }
    }
    
  
}
extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
