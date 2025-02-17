//
//  ActivateCardView.swift
//  Stitchdemo
//
//  Created by vizhi on 12/08/23.
//

import UIKit
//import IQKeyboardManagerSwift

public class ActivateCardView: UIView {

    @IBOutlet weak var cardView: UIStackView!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var activateCardBtn: UIButton!
    @IBOutlet weak var cardRequiredLabel: UILabel!
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var activeLabel: UILabel!
    
    public var token = ""
    public var deviceFingerPrint = ""
    var generalKey = ""
    public var cardType = ""
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        initalLoad()
    }
    public func setCardNo(cardNo: String) {
        cardTextField.text = cardNo
    }
    fileprivate func initalLoad(){
        cvvTextField.delegate = self
        activeLabel.textAlignment = .center
        overView.layer.cornerRadius = 10
        activateCardBtn.setCornerRadiusButton(size: 10)
        overView.isHidden = true
        cardTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cvvTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cardView.isHidden = true
        cardTextField.isUserInteractionEnabled = false
        cardRequiredLabel.text = "Card (required)*"
        activateCardBtn.backgroundColor = UIColor.lightGrayColor
        activateCardBtn.setTitleColor(.white, for: .normal)
        activateCardBtn.setTitle("Activate Card", for: .normal)
        cvvLabel.text = "Card CVV*"
        cardLabel.text = "Card Number*"
        activateCardBtn.addTarget(self, action: #selector(tapActivate(_:)), for: .touchUpInside)
    }
    
    public func setStyleSheet(styleSheet: String){
        if styleSheet == "Outlined" {
            cvvTextField.layer.borderWidth = 1
            cardTextField.layer.borderWidth = 1
            cvvTextField.layer.borderColor = UIColor.lightGray.cgColor
            cardTextField.layer.borderColor = UIColor.lightGray.cgColor
        }else if styleSheet == "Filled" {
            cvvTextField.backgroundColor = UIColor.lightGrayColor
            cardTextField.backgroundColor = UIColor.lightGrayColor
        }else{
            cvvTextField.addBottomBorder()
            cardTextField.addBottomBorder()
        }
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

                if type == "Activate Card" {
                    setfontValue(font: font,fontSize: fontsize)

                    activeLabel.textColor = fontColor
                    cardRequiredLabel.textColor = fontColor
                    cardLabel.textColor = fontColor
                    cvvLabel.textColor = fontColor
                    cvvTextField.textColor = fontColor
                    cardTextField.textColor = fontColor
                    overView.backgroundColor = backgroundColor
                    return
                }else{
                    setfontValue(font: "EuclidFlex-Medium",fontSize: 14.0)
                    cardRequiredLabel.textColor = .black
                    cardLabel.textColor = .black
                    cvvLabel.textColor = .black
                    cvvTextField.textColor = .black
                    cardTextField.textColor = .black
                    activeLabel.textColor = .blueColor
                    overView.backgroundColor = .violetColor
                }

            }
           
        }else{
            setfontValue(font: "EuclidFlex-Medium",fontSize: 14.0)
            cardRequiredLabel.textColor = .black
            cardLabel.textColor = .black
            cvvLabel.textColor = .black
            cvvTextField.textColor = .black
            cardTextField.textColor = .black
            activeLabel.textColor = .blueColor
            overView.backgroundColor = .violetColor
        }
        
    }
    
    fileprivate func setfontValue(font: String,fontSize: Float){
        let size = CGFloat(fontSize)
        
        cardRequiredLabel.font = UIFont(name:font, size: size)
        cardLabel.font = UIFont(name:font, size: size)
        cvvLabel.font = UIFont(name:font, size: size)
        cvvTextField.font = UIFont(name:font, size: size)
        cardTextField.font = UIFont(name:font, size: size)
        activeLabel.font = UIFont(name:font, size: size)
    }
    
    @objc func tapActivate(_ sender:UIButton) {
        if validate(){
            self.endEditing(true)
            self.activateCard()
        }
    }
}
extension ActivateCardView  {
    
    public func sessionKey() {
        if self.cardType == "activated" {
            self.activeLabel.text = "Card in Activated State"
            self.overView.isHidden = false
            self.cardView.isHidden = true
    }else if self.cardType == "invalid" {
            self.activateCard()

        }else{
            
            self.overView.isHidden = true
            self.cardView.isHidden = false
        }
    }
}
extension ActivateCardView  {
    
    fileprivate func sessionKeyAPI(body: [String: Any]){
        let url = servicesURL.baseUrl + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.key ?? ""
                if self.cardType == "activated" {
                    self.activeLabel.text = "Card in Activated State"
                    self.overView.isHidden = false
                    self.cardView.isHidden = true
            }else if self.cardType == "invalid" {
                    self.activateCard()

                }else{
                    
                    self.overView.isHidden = true
                    self.cardView.isHidden = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func validate() -> Bool {
        guard let cvvStr = cvvTextField.text, !cvvStr.isEmpty else {
            cvvTextField.becomeFirstResponder()
            simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.cvvEmpty,buttonTitle: ConstantData.ok)
            return false
        }
        return true
    }
    
    fileprivate func activateCard(){
        let data = [
            "state": "activated",
            "memo": "card shipped",
            "token": token,
            "deviceFingerPrint": deviceFingerPrint
        ] as [String : Any]
        activateCardApi(body: data)
    }
    fileprivate func activateCardApi(body: [String: Any]){
        let url = servicesURL.baseUrl + servicesURL.activateCard.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post,type:  "ActivateCard").executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                print(session)
            case .failure(let error):
               
                if error.errorCode == 400 {
                    self.overView.isHidden = false
                    self.cardView.isHidden = true
                    self.activeLabel.text = "Invalid Card type"
                }else if error.errorCode == 200 {
                    self.overView.isHidden = false
                    self.cardView.isHidden = true
                    self.activeLabel.text = "Card in Activated State"
                }else{
                    simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: ConstantData.activateCardSuccess,buttonTitle: ConstantData.ok)
                    onTapAlert = { [weak self] tag in
                        guard let self = self else {
                            return
                        }
                        if tag == 1 {
                            self.overView.isHidden = false
                            self.cardView.isHidden = true
                            self.activeLabel.text = "Card in Activated State"
                        }
                    }
                }
            }
        }
    }
}
extension ActivateCardView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 3
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if cardTextField.text != "" && cvvTextField.text != "" {
            activateCardBtn.backgroundColor = UIColor.blueColor
        }else{
            activateCardBtn.backgroundColor = UIColor.lightGrayColor
            
        }
    }
}
