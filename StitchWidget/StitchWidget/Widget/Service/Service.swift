//
//  Service.swift
//  Stitchdemo
//
//  Created by vizhi on 10/08/23.
//

import Foundation
import UIKit
import Alamofire

public let baseUrl = ""

enum servicesURL :String{
    
    //View Card
    case sessionKey = "secure/sessionkey"
    case secureCard = "secure/card"
    case setPin = "secure/setpin"
    case changePin = "secure/changepin"
    case activateCard = "stitch-rest-api/v1/widgets/secure/card/activation"
}
class ServiceNetworkCall : NSObject{

    var parameters = Parameters()
    var method: HTTPMethod!
    var url :String? = ""
    var encoding: ParameterEncoding! = JSONEncoding.default
    var type = ""
    let activityInstance = Indicator()

    init(data: [String:Any],url :String?, method: HTTPMethod = .post, isJSONRequest: Bool = true,type: String = ""){
        super.init()
       
        data.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        self.url = url
        self.method = method
        self.type = type

    }

    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if Reachability.isConnectedToNetwork(){
            let number = arc4random()
            self.activityInstance.showIndicator()
        
            let head: HTTPHeaders = ["X-Correlation-ID": "\(number)"]
            
            AF.request(url!,method: method,parameters: parameters,encoding: encoding, headers: head).responseData(completionHandler: {response in
                switch response.result{
                case .success(let res):
                    if let code = response.response?.statusCode{
                        switch code {
                        case 200...299:
                            do {
                                self.activityInstance.hideIndicator()
                                completion(.success(try JSONDecoder().decode(T.self, from: res)))
                            } catch let error {
                                self.activityInstance.hideIndicator()
                                print(String(data: res, encoding: .utf8) ?? "nothing received")
                                completion(.failure(error))
                            }
                        default:
                            let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                            print(error)
                            var errorString: String?
                            if let data = response.data {
                                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                                    errorString = json["message"]
                                }
                            }
                            if errorString == "Invalid credential." || errorString == "Token expired." {
                                self.activityInstance.hideIndicator()
                                self.showErrorMessage()
                            }else{
                                self.activityInstance.hideIndicator()
                                if let error = errorString {
                                    simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: error,buttonTitle: ConstantData.ok)
                                }
                                completion(.failure(error))
                            }
                            
                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode{
                        if code == 401 {
                            self.activityInstance.hideIndicator()
                            self.showErrorMessage()
                        }else if code == 200 {
                            self.activityInstance.hideIndicator()
                            if self.type == "ActivateCard" {
                                completion(.failure(error))
                                
                            }else if self.type == "SetPin" {
                                completion(.failure(error))
                                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: "Pin setted Successfully",buttonTitle: ConstantData.ok)
                                
                            }else if self.type == "ResetPin" {
                                completion(.failure(error))
                                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: "Pin Changed Successfully",buttonTitle: ConstantData.ok)
                                
                            }
                        }else{
                            self.activityInstance.hideIndicator()
                            completion(.failure(error))
                            
                        }
                    }
                }
            })
        }else{
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: "Please check your Internet connection",buttonTitle: ConstantData.ok)
        }
    }
    
    fileprivate func showErrorMessage(){
        UserDefaults.standard.set(nil, forKey: "Headers")
        UserDefaults.standard.set(nil, forKey: "token")
    }
}
extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
