//
//  PinView.swift
//  Stitchdemo
//
//  Created by vizhi on 08/08/23.
//

import UIKit
import IQKeyboardManagerSwift
public class PinView: UIView {
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var activateView: UIView!
    @IBOutlet weak var activateLabel: UILabel!
    @IBOutlet weak var newPinLabel: UILabel!
    @IBOutlet weak var olfPinLabel: UILabel!
    @IBOutlet weak var newPinTextField: UITextField!
    @IBOutlet weak var oldPinTextField: UITextField!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var pinRequiredLabel: UILabel!
    
    public var token = ""
    public var deviceFingerPrint = ""
    var generalKey = ""
    public var cardType = ""
    public var type = ""

    public override func awakeFromNib() {
        super.awakeFromNib()
        initalLoad()
        
    }
    
    private func initalLoad(){
        IQKeyboardManager.shared.enable = true
        newPinTextField.delegate = self
        oldPinTextField.delegate = self
        newPinTextField.keyboardType = .numberPad
        oldPinTextField.keyboardType = .numberPad
        pinButton.backgroundColor = .blueColor
        pinButton.setTitleColor(.white, for: .normal)
        pinButton.setCornerRadiusButton(size: 10)
        activateView.layer.cornerRadius = 10
        pinRequiredLabel.text = "PIN (required)*"
        pinButton.backgroundColor = UIColor.lightGrayColor
        newPinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        oldPinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        activateLabel.backgroundColor = .clear

    }
    public func setUserDefault(widget: NSMutableArray){
        if widget.count != 0 {
            
            for item in widget {
                let data = item as! [String: Any]
                let type = data["type"] as! String
                let backgroundColor = data["backgroundColor"] as! UIColor
                let fontColor = data["fontColor"] as! UIColor
                let font = data["font"] as! String
                let fontsize = data["fontSize"] as! Float
                setfontValue(font: font,fontSize: fontsize)

                if type != "View Card" && type != "Activate Card"  {
                    
                    olfPinLabel.textColor = fontColor
                    newPinLabel.textColor = fontColor
                    newPinTextField.textColor = fontColor
                    oldPinTextField.textColor = fontColor
                    newPinTextField.backgroundColor = backgroundColor
                    oldPinTextField.backgroundColor = backgroundColor
                    pinRequiredLabel.textColor = fontColor
                    activateLabel.textColor = fontColor
                    activateView.backgroundColor = backgroundColor
                    
                }else{
                    setfontValue(font: "EuclidFlex-Medium",fontSize: 14.0)

                    olfPinLabel.textColor = .black
                    newPinLabel.textColor = .black
                    newPinTextField.textColor = .black
                    oldPinTextField.textColor = .black
                    pinRequiredLabel.textColor = .black

                    newPinTextField.backgroundColor = .clear
                    oldPinTextField.backgroundColor = .clear
                    activateLabel.textColor = .red

                    activateView.backgroundColor = .redColor
                }

            }
           
        }else{
          
            setfontValue(font: "EuclidFlex-Medium",fontSize: 14.0)

            olfPinLabel.textColor = .black
            newPinLabel.textColor = .black
            newPinTextField.textColor = .black
            oldPinTextField.textColor = .black
            pinRequiredLabel.textColor = .black

            newPinTextField.backgroundColor = .clear
            oldPinTextField.backgroundColor = .clear
            activateLabel.textColor = .red

            activateView.backgroundColor = .redColor
        }
        
    }
    
    private func setfontValue(font: String,fontSize: Float){
        let size = CGFloat(fontSize)
        
        pinRequiredLabel.font = UIFont(name:font, size: size)
        olfPinLabel.font = UIFont(name:font, size: size)
        oldPinTextField.font = UIFont(name:font, size: size)
        newPinLabel.font = UIFont(name:font, size: size)
        newPinTextField.font = UIFont(name:font, size: size)
        activateLabel.font = UIFont(name:font, size: size)
    }
    public func setTypePin(pintype: String){
            overView.isHidden = true
            activateView.isHidden = true
        type = pintype
        newPinLabel.text = (type == "SetPin") ? "Confirm PIN*" : "New PIN*"
        olfPinLabel.text = (type == "SetPin") ? "4 Digit PIN*" : "4 Digit old PIN*"
        pinButton.setTitle((type == "SetPin") ? "Set Pin" : "Change Pin", for: .normal)
    }
    
    public func setStyleSheet(styleSheet: String){
        if styleSheet == "Outlined" {
            newPinTextField.layer.borderWidth = 1
            oldPinTextField.layer.borderWidth = 1
            newPinTextField.layer.borderColor = UIColor.lightGray.cgColor
            oldPinTextField.layer.borderColor = UIColor.lightGray.cgColor
        }else if styleSheet == "Filled" {
            newPinTextField.backgroundColor = UIColor.lightGrayColor
            oldPinTextField.backgroundColor = UIColor.lightGrayColor
        }else{
            newPinTextField.addBottomBorder()
            oldPinTextField.addBottomBorder()
        }
    }
    
    @IBAction func setPinButtonAction(_ sender: Any) {
        if validate() {
            self.endEditing(true)
            setPin()
        }
    }
    
    private func validate() -> Bool {
        guard let pinStr = oldPinTextField.text, !pinStr.isEmpty else {
            oldPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "SetPin") ? ConstantData.pinEmpty : ConstantData.oldPinEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        
        guard pinStr.isValid4Password else {
            oldPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "SetPin") ? ConstantData.pinlength : ConstantData.oldPinlength,buttonTitle: ConstantData.ok)

            return false
        }
        
        guard let confirmPinStr = newPinTextField.text, !confirmPinStr.isEmpty else {
            newPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "SetPin") ? ConstantData.confirmPinEmpty : ConstantData.newPinEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        
        guard confirmPinStr.isValid4Password else {
            newPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "SetPin") ? ConstantData.confirmPinlength : ConstantData.newPinlength,buttonTitle: ConstantData.ok)

            return false
        }
        
        if type == "SetPin" {
            if pinStr != confirmPinStr {
                newPinTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.pinMismatch,buttonTitle: ConstantData.ok)
                return false
            }
        }else{
            if pinStr == confirmPinStr {
                newPinTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.pinDifferent,buttonTitle: ConstantData.ok)
                return false
            }
        }
        
        return true
    }
}
extension PinView  {
    
    public func sessionKey() {
        let data = [
            "token": token,
            "deviceFingerPrint": deviceFingerPrint
        ] as [String : Any]
        sessionKeyAPI(body: data)
    }
    
    private func setPin() {
        
        do {
            let confirmPinEncrypt = try AESUtils().encrypt(pin: newPinTextField.text ?? "", key: generalKey)
            if type == "SetPin" {
                let data = [
                    "pin": confirmPinEncrypt,
                    "token": token,
                    "deviceFingerPrint": deviceFingerPrint
                ] as [String : Any]
                setPinAPI(body: data)
            }else{
                let newPinEncrypt = try AESUtils().encrypt(pin: oldPinTextField.text ?? "", key: generalKey)
                let data = [
                    "existingPin": newPinEncrypt,
                    "pin": confirmPinEncrypt,
                    "token": token,
                    "deviceFingerPrint": deviceFingerPrint
                ] as [String : Any]
                changePinAPI(body: data)
            }
            
        }catch {
            print(error)
        }
    }

}
extension PinView  {
    
    private func setPinAPI(body: [String: Any]){
        let url = servicesURL.baseUrl.rawValue + servicesURL.setPin.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post,istoken: -1,type: "SetPin").executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                print(session)
            case .failure(let error):
                print(error)
                self.overView.isHidden = true
                self.activateView.isHidden = true
                self.removeFromSuperview()
            }
        }
    }


private func changePinAPI(body: [String: Any]){
    let url = servicesURL.baseUrl.rawValue + servicesURL.changePin.rawValue
    ServiceNetworkCall(data: body, url: url, method: .post,istoken: -1,type: "ResetPin").executeQuery(){
        (result: Result<SessionKeyEntity,Error>) in
        switch result{
        case .success(let session):
            print(session)
        case .failure(let error):
            print(error)
            self.overView.isHidden = true
            self.activateView.isHidden = true
            self.removeFromSuperview()

        }
    }
}

    
    private func sessionKeyAPI(body: [String: Any]){
        let url = servicesURL.baseUrl.rawValue + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post,istoken: 2).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.generatedKey!
                if self.cardType != "activated" {
                    self.activateView.isHidden = false
                    self.activateLabel.text = "Card not in Activated State"
                    self.overView.isHidden = true
                }else{
                    self.overView.isHidden = false
                    self.activateView.isHidden = true

                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension PinView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        //your code
        if oldPinTextField.text != "" && newPinTextField.text != "" {
            pinButton.backgroundColor = UIColor.blueColor
        }else{
            pinButton.backgroundColor = UIColor.lightGrayColor
            
        }
    }
}
