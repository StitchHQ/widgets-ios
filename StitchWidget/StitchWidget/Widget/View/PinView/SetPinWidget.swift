//
//  PinView.swift
//  Stitchdemo
//
//  Created by vizhi on 08/08/23.
//

import UIKit

public class SetPinWidget: UIView {
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var activateView: UIView!
    @IBOutlet weak var activateLabel: UILabel!
    @IBOutlet weak var newPinLabel: UILabel!
    @IBOutlet weak var olfPinLabel: UILabel!
    @IBOutlet weak var newPinTextField: UITextField!
    @IBOutlet weak var oldPinTextField: UITextField!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var pinRequiredLabel: UILabel!
    @IBOutlet weak var confirmStackView: UIStackView!
    @IBOutlet weak var confirmPinLabel: UILabel!
    @IBOutlet weak var confirmTextField: UITextField!
    
    public var token = ""
    var generalKey = ""
    public var cardType = ""
    public var type = ""

    public override func awakeFromNib() {
        super.awakeFromNib()
        do {
            try initializeSDK()
        }catch {
            print(error)
        }
    }
    
    func initializeSDK() throws {
        if hasJailbreak() == CardSDKError.insecureEnvironment {
            throw CardSDKError.insecureEnvironment
        }
        // Continue with initialization if the device is secure
        initalLoad()
    }
    
    private func initalLoad(){
        newPinTextField.delegate = self
        oldPinTextField.delegate = self
        newPinTextField.keyboardType = .numberPad
        oldPinTextField.keyboardType = .numberPad
        pinButton.setTitleColor(.white, for: .normal)
        pinButton.setCornerRadiusButton(size: 10)
        activateView.layer.cornerRadius = 10
        pinRequiredLabel.text = "PIN (required)*"
        pinButton.backgroundColor = UIColor.lightGrayColor
        newPinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        oldPinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        activateLabel.backgroundColor = .clear
        setTypePin(pintype: "set_pin")


    }
    public func setWidgetSetting(widget: [WidgetSettingEntity]){
        if widget.count != 0 {
            
            for item in widget {

                setfontValue(font: item.fontFamily ?? "EuclidFlex-Medium",fontSize: item.fontSize ?? 14.0)
                setStyleSheet(styleSheet: item.textFieldVariant ?? "Outlined")

                if type == item.widgetStyle {
                    
                    olfPinLabel.textColor = item.fontColor
                    newPinLabel.textColor = item.fontColor
                    pinRequiredLabel.textColor = item.fontColor
                    activateLabel.textColor = item.fontColor
                    activateView.backgroundColor = item.background
                    confirmPinLabel.textColor = item.fontColor
                    pinButton.setTitleColor(item.buttonFontColor, for: .normal)
                    pinButton.backgroundColor = item.buttonBackground
                    

                    return
                }else{
                    setfontValue(font: "Inter-Medium",fontSize: 16.0)
                    olfPinLabel.textColor = .darkblueColor
                    newPinLabel.textColor = .darkblueColor
                    newPinTextField.textColor = .black
                    oldPinTextField.textColor = .black
                    pinRequiredLabel.textColor = .darkblueColor
                    confirmPinLabel.textColor = .black
                    confirmTextField.textColor = .black
                    newPinTextField.backgroundColor = .clear
                    oldPinTextField.backgroundColor = .clear
                    activateLabel.textColor = .red
                    pinButton.backgroundColor = UIColor.lightGrayColor
                    pinButton.setTitleColor(.white, for: .normal)
                    activateView.backgroundColor = .redColor
                }

            }
           
        }else{
          
            setfontValue(font: "Inter-Medium",fontSize: 16.0)
            pinButton.setTitleColor(.white, for: .normal)
            olfPinLabel.textColor = .darkblueColor
            newPinLabel.textColor = .darkblueColor
            newPinTextField.textColor = .black
            oldPinTextField.textColor = .black
            pinRequiredLabel.textColor = .black
            confirmPinLabel.textColor = .darkblueColor
            confirmTextField.textColor = .black
            newPinTextField.backgroundColor = .clear
            oldPinTextField.backgroundColor = .clear
            activateLabel.textColor = .red
            pinButton.backgroundColor = UIColor.lightGrayColor
            activateView.backgroundColor = .redColor
        }
        
    }
    
    fileprivate func setfontValue(font: String,fontSize: Float){
        let size = CGFloat(fontSize)
        let fontName = font.firstWord()
        pinRequiredLabel.font = UIFont(name:"\(fontName ?? "")-SemiBold", size: size)
        olfPinLabel.font = UIFont(name:font, size: size)
        oldPinTextField.font = UIFont(name:font, size: size)
        newPinLabel.font = UIFont(name:font, size: size)
        newPinTextField.font = UIFont(name:font, size: size)
        activateLabel.font = UIFont(name:font, size: size)
        confirmPinLabel.font = UIFont(name:font, size: size)
        confirmTextField.font = UIFont(name:font, size: size)
        pinButton.titleLabel?.font = UIFont(name:font, size: size)
    }
    private func setTypePin(pintype: String){
            overView.isHidden = false
            activateView.isHidden = true
        
        type = pintype
        confirmStackView.isHidden = (type == "set_pin") ? true : false
        pinRequiredLabel.isHidden = (type == "set_pin") ? false : true
        confirmPinLabel.text = "Confirm New PIN"
        newPinLabel.text = (type == "set_pin") ? "Confirm PIN*" : "New PIN"
        olfPinLabel.text = (type == "set_pin") ? "4 Digit PIN*" : "Current PIN"
        pinButton.setTitle((type == "set_pin") ? "Set Pin" : "Change Pin", for: .normal)
        self.oldPinTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter 4-Digit PIN",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.newPinTextField.attributedPlaceholder = NSAttributedString(
            string: (type == "set_pin") ? "Re-enter 4-Digit PIN" : "Enter 4-Digit PIN",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.confirmTextField.attributedPlaceholder = NSAttributedString(
            string: "Re-enter 4-Digit PIN",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    public func setStyleSheet(styleSheet: String){
        if styleSheet == "Outlined" {
            newPinTextField.layer.borderWidth = 1
            oldPinTextField.layer.borderWidth = 1
            newPinTextField.layer.borderColor = UIColor(hexString: "#D0D5DD").cgColor
            oldPinTextField.layer.borderColor = UIColor(hexString: "#D0D5DD").cgColor
            confirmTextField.layer.borderWidth = 1
            confirmTextField.layer.borderColor = UIColor(hexString: "#D0D5DD").cgColor
        }else if styleSheet == "Filled" {
            newPinTextField.backgroundColor = UIColor.lightGrayColor
            oldPinTextField.backgroundColor = UIColor.lightGrayColor
            confirmTextField.backgroundColor = UIColor.lightGrayColor
        }else{
            newPinTextField.addBottomBorder()
            oldPinTextField.addBottomBorder()
            confirmTextField.addBottomBorder()
        }
    }
    
    @IBAction func setPinButtonAction(_ sender: Any) {
        if validate() {
            self.endEditing(true)
            setPin()
        }
    }
    
    fileprivate func validate() -> Bool {
        guard let pinStr = oldPinTextField.text, !pinStr.isEmpty else {
            oldPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "set_pin") ? ConstantData.pinEmpty : ConstantData.oldPinEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        
        guard pinStr.isValid4Password else {
            oldPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "set_pin") ? ConstantData.pinlength : ConstantData.oldPinlength,buttonTitle: ConstantData.ok)

            return false
        }
        
        guard let confirmPinStr = newPinTextField.text, !confirmPinStr.isEmpty else {
            newPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "set_pin") ? ConstantData.confirmPinEmpty : ConstantData.newPinEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        
        guard confirmPinStr.isValid4Password else {
            newPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: (type == "set_pin") ? ConstantData.confirmPinlength : ConstantData.newPinlength,buttonTitle: ConstantData.ok)

            return false
        }
        
        if type != "set_pin" {
            guard let confirmchangePinStr = confirmTextField.text, !confirmchangePinStr.isEmpty else {
                confirmTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message:  ConstantData.confirmNewPinEmpty,buttonTitle: ConstantData.ok)
                return false
            }
            
            guard confirmchangePinStr.isValid4Password else {
                newPinTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.confirmNewPinlength,buttonTitle: ConstantData.ok)

                return false
            }
        }
        
        if type == "set_pin" {
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
            }else if confirmPinStr != (confirmTextField.text ?? "") {
                newPinTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.newpinMismatch,buttonTitle: ConstantData.ok)
                return false
            }
            
        }
        
        return true
    }
}
extension SetPinWidget  {
    
    public func sessionKey(secureToken: String) {
        token = secureToken
        self.cardType = "activated"
        let data = [
            "token": token,
            "device_fingerprint": deviceFingerPrint
        ] as [String : Any]
        sessionKeyAPI(body: data)
        if self.cardType != "activated" {
            self.activateView.isHidden = false
            self.activateLabel.text = "Card not in Activated State"
            self.overView.isHidden = true
        }else{
            self.overView.isHidden = false
            self.activateView.isHidden = true

        }
    }
    
    fileprivate func setPin() {
        
        do {
            let confirmPinEncrypt = try AESUtils().encrypt(pin: newPinTextField.text ?? "", key: generalKey)
            if type == "set_pin" {
                let data = [
                    "pin": confirmPinEncrypt,
                    "token": token,
                    "device_fingerprint": deviceFingerPrint
                ] as [String : Any]
                setPinAPI(body: data)
            }
            
        }catch {
            print(error)
        }
    }
    

}
extension SetPinWidget  {
    
    fileprivate func setPinAPI(body: [String: Any]){
        let url = baseUrl() + servicesURL.setPin.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post,type: "SetPin").executeQuery(){
            (result: Result<setPinSuccess,Error>) in
            switch result{
            case .success(let session):
                print(session)
                
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: "Card Pin is Set Sucessfully", buttonTitle: "OK")
                onTapAlert = { [weak self] tag in
                    guard let self = self else {
                        return
                    }
                    if tag == 1 {
                        oldPinTextField.text = ""
                        newPinTextField.text = ""
                        UIApplication.topViewController()!.self.navigationController?.popViewController(animated: true)

                    }
                }
            case .failure(let error):
                print(error)
                self.overView.isHidden = true
                self.activateView.isHidden = true
                self.removeFromSuperview()
            }
        }
    }




    
    fileprivate func sessionKeyAPI(body: [String: Any]){
        let url = baseUrl() + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.key ?? ""
                self.token = session.token ?? ""
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
extension SetPinWidget: UITextFieldDelegate {
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
        if oldPinTextField.text != "" && newPinTextField.text != "" {
            pinButton.backgroundColor = UIColor.blueColor
        }else{
            pinButton.backgroundColor = UIColor.lightGrayColor
            
        }
    }
}

