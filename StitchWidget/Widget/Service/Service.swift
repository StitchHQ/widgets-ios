//
//  Service.swift
//  Stitchdemo
//
//  Created by vizhi on 10/08/23.
//

import Foundation
import UIKit
import Alamofire

enum servicesURL :String{
    case baseUrl = "https://sandbox.stitch.fi/"
    case commonApi = "stitch-ui-api-zitadel/v1/stitchapp/api"
    
    //View Card
    case sessionKey = "stitch-rest-api/v1/widgets/secure/sessionkey"
    case secureCard = "stitch-rest-api/v1/widgets/secure/card"
    case setPin = "stitch-rest-api/v1/widgets/secure/setpin"
    case changePin = "stitch-rest-api/v1/widgets/secure/changepin"
    case activateCard = "stitch-rest-api/v1/widgets/secure/card/activation"
}
class ServiceNetworkCall : NSObject{

    var parameters = Parameters()
    var method: HTTPMethod!
    var url :String? = ""
    var encoding: ParameterEncoding! = JSONEncoding.default
    var isHead = true
    var istoken = -1
    var type = ""
    let activityInstance = Indicator()

    init(data: [String:Any],url :String?, method: HTTPMethod = .post, isJSONRequest: Bool = true,isHead: Bool = true,istoken: Int = -1,type: String = ""){
        super.init()
       
        data.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        self.url = url
        self.method = method
        self.isHead = isHead
        self.istoken = istoken
        self.type = type

    }

    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if Reachability.isConnectedToNetwork(){
            var head:HTTPHeaders = [:]
            let number = arc4random()
            self.activityInstance.showIndicator()
            
            if istoken == 1 {
                if let token = UserDefaults.standard.value(forKey: "token") as? String {
                    
                    head = ["Authorization": token,"X-Correlation-ID": "\(number)"]
                }
            }else if istoken == 2 {
                if let httpHead = UserDefaults.standard.value(forKey: "Headers") as? String {
                    head = ["Authorization": "Bearer " + httpHead,"X-Correlation-ID": "\(number)"]
                }
            }else if istoken == -1 {
                head = []
            }else{
                if isHead {
                    if let httpHead = UserDefaults.standard.value(forKey: "Headers") as? String {
                        head = ["Authorization": "Bearer " + httpHead]
                    }
                }else{
                    if let token = UserDefaults.standard.value(forKey: "tokenType") as? String {
                        head = ["Authorization": token]
                    }
                }
            }
            
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
    
    private func showErrorMessage(){
        UserDefaults.standard.set(nil, forKey: "Headers")
        UserDefaults.standard.set(nil, forKey: "tokenType")
        UserDefaults.standard.set(nil, forKey: "token")
//        let vc = Router.storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [vc]
//        navigationController.isNavigationBarHidden = true
//        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//        appDelegate.window?.rootViewController = navigationController
//        appDelegate.window?.makeKeyAndVisible()
    }
}
extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
