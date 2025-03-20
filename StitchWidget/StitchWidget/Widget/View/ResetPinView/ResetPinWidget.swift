//
//  ResetPin.swift
//  StitchWidget
//
//  Created by vizhi on 04/03/25.
//

import UIKit

public class ResetPinWidget: UIView {
    
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
        pinRequiredLabel.text = ConstantData.pinRequired
        pinButton.backgroundColor = UIColor.lightGrayColor
        newPinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        oldPinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        activateLabel.backgroundColor = .clear
        setTypePin(pintype: "change_pin")

    }
    public func setWidgetSetting(widget: [WidgetSettingEntity]){
        if widget.count != 0 {
            
            for item in widget {

                setfontValue(font: item.fontFamily ?? FontConstant.interMedium,fontSize: item.fontSize ?? 14.0)
                setStyleSheet(styleSheet: item.textFieldVariant ?? ConstantData.outlined)

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
                    setfontValue(font: FontConstant.interMedium,fontSize: 16.0)
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
          
            setfontValue(font: FontConstant.interMedium,fontSize: 16.0)
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
        pinRequiredLabel.font = UIFont(name:"\(fontName ?? String.Empty)-SemiBold", size: size)
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
        confirmStackView.isHidden = false
        pinRequiredLabel.isHidden = true
        confirmPinLabel.text = ConstantData.confirmNewPin
        newPinLabel.text = ConstantData.newPin
        olfPinLabel.text = ConstantData.currentPin
        pinButton.setTitle(ConstantData.changePin, for: .normal)
        self.oldPinTextField.attributedPlaceholder = NSAttributedString(
            string: ConstantData.enterDigitPin,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.newPinTextField.attributedPlaceholder = NSAttributedString(
            string: ConstantData.enterDigitPin,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.confirmTextField.attributedPlaceholder = NSAttributedString(
            string: ConstantData.reenterDigitPin,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    public func setStyleSheet(styleSheet: String){
        if styleSheet == ConstantData.outlined {
            newPinTextField.layer.borderWidth = 1
            oldPinTextField.layer.borderWidth = 1
            newPinTextField.layer.borderColor = UIColor(hexString: ColorConstant.lightGrayColor).cgColor
            oldPinTextField.layer.borderColor = UIColor(hexString: ColorConstant.lightGrayColor).cgColor
            confirmTextField.layer.borderWidth = 1
            confirmTextField.layer.borderColor = UIColor(hexString: ColorConstant.lightGrayColor).cgColor
        }else if styleSheet == ConstantData.filled {
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
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.oldPinEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        
        guard pinStr.isValid4Password else {
            oldPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.oldPinlength,buttonTitle: ConstantData.ok)

            return false
        }
        
        guard let confirmPinStr = newPinTextField.text, !confirmPinStr.isEmpty else {
            newPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.newPinEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        
        guard confirmPinStr.isValid4Password else {
            newPinTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.newPinlength,buttonTitle: ConstantData.ok)

            return false
        }
        
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
            
            if pinStr == confirmPinStr {
                newPinTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.pinDifferent,buttonTitle: ConstantData.ok)
                return false
            }else if confirmPinStr != (confirmTextField.text ?? String.Empty) {
                newPinTextField.becomeFirstResponder()
                simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.newpinMismatch,buttonTitle: ConstantData.ok)
                return false
            }
            
    
        
        return true
    }
}
extension ResetPinWidget  {
    
    public func sessionKey(secureToken: String) {
        token = secureToken
        self.cardType = ConstantData.activated
        let data = [
            APIConstant.token: token,
            APIConstant.devicePrint: deviceFingerPrint
        ] as [String : Any]
        sessionKeyAPI(body: data)
        if self.cardType != ConstantData.activated {
            self.activateView.isHidden = false
            self.activateLabel.text = ConstantData.cardInActivate
            self.overView.isHidden = true
        }else{
            self.overView.isHidden = false
            self.activateView.isHidden = true

        }
    }
    
    fileprivate func setPin() {
        
        do {
            let confirmPinEncrypt = try AESUtils().encrypt(pin: newPinTextField.text ?? "", key: generalKey)
         
                let newPinEncrypt = try AESUtils().encrypt(pin: oldPinTextField.text ?? "", key: generalKey)
                let data = [
                    APIConstant.oldPin: newPinEncrypt,
                    APIConstant.newPin: confirmPinEncrypt,
                    APIConstant.token: token,
                    APIConstant.devicePrint: deviceFingerPrint
                ] as [String : Any]
                changePinAPI(body: data)
        
            
        }catch {
            print(error)
        }
    }
    

}
extension ResetPinWidget  {

private func changePinAPI(body: [String: Any]){
    let url = baseUrlService + servicesURL.changePin.rawValue
    ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
        (result: Result<setPinSuccess,Error>) in
        switch result{
        case .success(let session):
            print(session)
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.cardPinChangeSuccess, buttonTitle:  ConstantData.ok)
            onTapAlert = { [weak self] tag in
                guard let self = self else {
                    return
                }
                if tag == 1 {
                    oldPinTextField.text = String.Empty
                    newPinTextField.text = String.Empty
                    confirmTextField.text = String.Empty
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
        let url = baseUrlService + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.key ?? ""
                self.token = session.token ?? ""
                if self.cardType != ConstantData.activated {
                    self.activateView.isHidden = false
                    self.activateLabel.text = ConstantData.cardInActivate
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
extension ResetPinWidget: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let currentText = textField.text ?? String.Empty
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if oldPinTextField.text != String.Empty && newPinTextField.text != String.Empty {
            pinButton.backgroundColor = UIColor.blueColor
        }else{
            pinButton.backgroundColor = UIColor.lightGrayColor
            
        }
    }
}
