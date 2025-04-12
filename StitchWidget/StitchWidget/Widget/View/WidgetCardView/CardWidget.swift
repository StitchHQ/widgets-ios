//
//  WidgetCardView.swift
//  Stitchdemo
//
//  Created by vizhi on 03/08/23.
//

import UIKit
import PassKit

var deviceFingerPrint = ""
public class CardWidget: UIView {
    
    @IBOutlet weak public var frontCardView: UIView!
    @IBOutlet weak public var overView: UIView!
    @IBOutlet weak var frontImgView: UIImageView!
    @IBOutlet weak var jailBreakLabel: UILabel!
    
    var isCvvEye = false
    var isCardNoEye = false
    var generalKey = ""
    let activityInstance = Indicator()
    var accountNo = ""
    var cvv = ""
    var isCvvMask = false
    var isCardMask = false
    var panLastFour = ""
    var token = ""
    
    let visaLabel = UIImageView()
    let cardNumberLabel = UILabel()
    let nameLabel = UILabel()
    let validThruTitle = UILabel()
    let validThruValue = UILabel()
    let cvvTitle = UILabel()
    let cvvValue = UILabel()
    let eyeIconCvv = UIButton()
    let eyeIcon = UIButton()
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
        do {
            try initializeSDK()
        }catch {
            print(error.errorCode)
            jailBreakLabel.text = CardSDKError.insecureEnvironment.localizedDescription
            jailBreakLabel.isHidden = false
            overView.isHidden = true
        }

    }
    public override func layoutSubviews() {
        setupCardUI()
    }
    private func initializeSDK() throws {
        if isJailbroken() == CardSDKError.insecureEnvironment {
            throw CardSDKError.insecureEnvironment
        }
        // Continue with initialization if the device is secure
        initalLoad()
      
        
        deviceFingerPrint = getDevicFingingerprint()
        sessionKeyAPI(token: token,deviceFinger: deviceFingerPrint)
    }
    
    private func setupCardUI() {
        
        // VISA Label
        visaLabel.image = UIImage(named: "visa")
        visaLabel.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(visaLabel)
        
        // Card Number
//        cardNumberLabel.text = "2345  7654  8899  2548"
        cardNumberLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        cardNumberLabel.textColor = .white
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(cardNumberLabel)
        
        // Eye Icon
        
        eyeIcon.addTarget(self, action: #selector(self.onCardNoEyeAction), for: .touchUpInside)
        
        eyeIcon.translatesAutoresizingMaskIntoConstraints = false
        eyeIcon.setImage(UIImage(named: "eye"), for: .normal)
        
        overView.addSubview(eyeIcon)
        
        // Name Label
        nameLabel.text = "Elon Musk"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(nameLabel)
        
        // Valid Thru
        validThruTitle.text = "VALID THRU"
        validThruTitle.font = UIFont.systemFont(ofSize: 12)
        validThruTitle.textColor = .white
        validThruTitle.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(validThruTitle)
        
//        validThruValue.text = "01/25"
        validThruValue.font = UIFont.boldSystemFont(ofSize: 16)
        validThruValue.textColor = .white
        validThruValue.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(validThruValue)
        
        // CVV
        
        cvvTitle.text = "CVV"
        cvvTitle.font = UIFont.systemFont(ofSize: 12)
        cvvTitle.textColor = .white
        cvvTitle.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(cvvTitle)
        
//        cvvValue.text = "986"
        cvvValue.font = UIFont.boldSystemFont(ofSize: 16)
        cvvValue.textColor = .white
        cvvValue.translatesAutoresizingMaskIntoConstraints = false
        overView.addSubview(cvvValue)
        
        eyeIconCvv.translatesAutoresizingMaskIntoConstraints = false
        eyeIconCvv.addTarget(self, action: #selector(onCvvEyeAction), for: .touchUpInside)
        
        eyeIconCvv.setImage(UIImage(named: "eye"), for: .normal)
        overView.addSubview(eyeIconCvv)
        
        // Constraints
        NSLayoutConstraint.activate([
            
            visaLabel.topAnchor.constraint(equalTo: overView.topAnchor, constant: 16),
            visaLabel.trailingAnchor.constraint(equalTo: overView.trailingAnchor, constant: -16),
            
            cardNumberLabel.topAnchor.constraint(equalTo: visaLabel.bottomAnchor, constant: 28),
            cardNumberLabel.leadingAnchor.constraint(equalTo: overView.leadingAnchor, constant: 16),
            
            eyeIcon.centerYAnchor.constraint(equalTo: cardNumberLabel.centerYAnchor),
            eyeIcon.leadingAnchor.constraint(equalTo: cardNumberLabel.trailingAnchor, constant: 10),
            
            nameLabel.leadingAnchor.constraint(equalTo: overView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: overView.bottomAnchor, constant: -16),
            
            
            validThruTitle.bottomAnchor.constraint(equalTo: validThruValue.topAnchor, constant: -2),
            validThruTitle.trailingAnchor.constraint(equalTo: cvvTitle.leadingAnchor, constant: -15),
            
            validThruValue.leadingAnchor.constraint(equalTo: validThruTitle.leadingAnchor),
            validThruValue.bottomAnchor.constraint(equalTo: overView.bottomAnchor, constant: -16),
            validThruValue.trailingAnchor.constraint(equalTo: cvvValue.leadingAnchor, constant: -15),
            cvvTitle.leadingAnchor.constraint(equalTo: validThruValue.trailingAnchor, constant: 30),
            cvvTitle.bottomAnchor.constraint(equalTo: cvvValue.topAnchor, constant: -2),
            cvvTitle.trailingAnchor.constraint(equalTo: eyeIconCvv.leadingAnchor, constant: -10),
            
            
            cvvValue.leadingAnchor.constraint(equalTo: cvvTitle.leadingAnchor),
            cvvValue.bottomAnchor.constraint(equalTo: overView.bottomAnchor, constant: -16),
            cvvValue.trailingAnchor.constraint(equalTo: eyeIconCvv.leadingAnchor, constant: -10),
            
            eyeIconCvv.centerYAnchor.constraint(equalTo: cvvValue.centerYAnchor),
            eyeIconCvv.leadingAnchor.constraint(equalTo: cvvValue.trailingAnchor, constant: 8),
            eyeIconCvv.widthAnchor.constraint(equalToConstant: 25),
            
            eyeIconCvv.trailingAnchor.constraint(equalTo: overView.trailingAnchor, constant: -25),
        ])
    }
    
    private func initalLoad(){
        jailBreakLabel.isHidden = true
        overView.isHidden = false

        frontCardView.layer.cornerRadius = 10
        frontImgView.layer.cornerRadius = 10
        overView.layer.cornerRadius = 10
        visaLabel.image = UIImage(named: "visa.png")
        cardNumberLabel.font = UIFont.setCustomFont(name: .semiBold, size: .x14)
        cvvTitle.font = UIFont.setCustomFont(name: .semiBold, size: .x12)
        validThruTitle.font = UIFont.setCustomFont(name: .semiBold, size: .x12)
        eyeIcon.setTitle("", for: .normal)
        eyeIconCvv.setTitle("", for: .normal)
    }
    
    @IBAction func onCvvEyeAction(_ sender: Any) {
        if isCvvEye {
            if cvvValue.text == ConstantData.xxx {
                cvvValue.text = cvv
                eyeIconCvv.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)

            }else{
                cvvValue.text = ConstantData.xxx
                eyeIconCvv.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)
            }
        }
    }
    
    @IBAction func onCardNoEyeAction(_ sender: Any) {
        if isCardNoEye {
            if cardNumberLabel.text == "\(ConstantData.cardXDigit) \(panLastFour)" {
                cardNumberLabel.text = accountNo
                eyeIconCvv.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)

            }else{
                cardNumberLabel.text = "\(ConstantData.cardXDigit) \(panLastFour)"
                eyeIconCvv.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)

            }
        }
    }
    
    public func setWidgetSetting(widget: [WidgetSettingEntity]){
        do {
            try initializeSDK()
        }catch {
            print(error)
            jailBreakLabel.text = CardSDKError.insecureEnvironment.localizedDescription
            jailBreakLabel.isHidden = false
        }
        if widget.count == 0 {
            setDefaultStype()
        }else{
            setWidgetData(widget: widget)
        }
    }
    
    private  func setWidgetData(widget: [WidgetSettingEntity]){
        for item in widget {
            if item.widgetStyle == ConstantData.viewCard {
                
                setfontValue(font: item.fontFamily ?? FontConstant.euclidFlexMediumFont,fontSize: item.fontSize ?? 14.0)

                showEyeButton(isEyeIcon: item.showEyeIcon ?? false)
               
                setTimer(maskCardNo: item.maskCardNumber ?? false, maskCvv: item.maskCvv ?? false)
       
                frontCardView.backgroundColor = item.background
                setFontColor(fontColor: item.fontColor!)
                
                if item.backgroundImage != UIImage(named: "imageadd") {
                    frontImgView.image = item.backgroundImage
                }
                
                setCvvPadding(leadCvv: item.cvvPaddingLeft!, bottomCvv: item.cvvPaddingBottom!, trailCvv: item.cvvPaddingRight!, cvvTop: item.cvvPaddingTop!)
                
                setDatePadding(bottomDate: item.expiryPaddingBottom!, topDate: item.expiryPaddingTop!, trailDate: item.expiryPaddingRight!, leadDate: item.expiryPaddingLeft!)
                
                setCardNumberPadding(topCardNo: item.cardNumberPaddingTop!, bottomCardNo: item.cardNumberPaddingBottom!, cardNoLeft: item.cardNumberPaddingLeft!, cardNoRight: item.cardNumberPaddingRight!)
                
                return
            }else {
                setDefaultStype()
                return
            }
        }
    }
    private func showEyeButton(isEyeIcon: Bool){
        self.isCvvEye = isEyeIcon
        self.isCardNoEye = isEyeIcon
        if isEyeIcon {
            eyeIconCvv.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)
            eyeIcon.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)
            eyeIconCvv.isHidden = false
            eyeIcon.isHidden = false
        }else{
            eyeIconCvv.isHidden = true
            eyeIcon.isHidden = true
        }
    }
    
    private func setTimer(maskCardNo : Bool,maskCvv: Bool){
        isCardMask = maskCardNo
        isCvvMask = maskCvv
    }
    
    private func setFontColor(fontColor: UIColor){
        cvvValue.textColor = fontColor
        cardNumberLabel.textColor = fontColor
        nameLabel.textColor = fontColor
        cvvTitle.textColor = fontColor
        validThruTitle.textColor = fontColor
        validThruValue.textColor = fontColor
    }
    private func setDatePadding(bottomDate: String,topDate: String,trailDate: String,leadDate: String){
        
        //Set padding for date
        self.validThruTitle.transform = CGAffineTransform(translationX: -(trailDate.cgFloatValue() ?? 0.0), y: (topDate.cgFloatValue() ?? 0.0))
        self.validThruValue.transform = CGAffineTransform(translationX: -(trailDate.cgFloatValue() ?? 0.0), y: (topDate.cgFloatValue() ?? 0.0))
        if(bottomDate != "0") {
            self.validThruTitle.transform = CGAffineTransform(translationX: self.validThruTitle.transform.tx, y: -(bottomDate.cgFloatValue() ?? 0.0) + (topDate.cgFloatValue() ?? 0.0))
            self.validThruValue.transform = CGAffineTransform(translationX: self.validThruValue.transform.tx, y: -(bottomDate.cgFloatValue() ?? 0.0) + (topDate.cgFloatValue() ?? 0.0))
        }
        if(leadDate != "0") {
            self.validThruTitle.transform = CGAffineTransform(translationX: -(trailDate.cgFloatValue() ?? 0.0) + (leadDate.cgFloatValue() ?? 0.0) , y: self.validThruTitle.transform.ty)
            self.validThruValue.transform = CGAffineTransform(translationX: -(trailDate.cgFloatValue() ?? 0.0) + (leadDate.cgFloatValue() ?? 0.0) , y: self.validThruValue.transform.ty)
        }

    }
    
    private func setCvvPadding(leadCvv: String,bottomCvv: String,trailCvv: String,cvvTop: String) {
        
        self.cvvTitle.transform = CGAffineTransform(translationX: -(trailCvv.cgFloatValue() ?? 0.0), y: (cvvTop.cgFloatValue() ?? 0.0))
        self.cvvValue.transform = CGAffineTransform(translationX: -(trailCvv.cgFloatValue() ?? 0.0), y: (cvvTop.cgFloatValue() ?? 0.0))
        self.eyeIconCvv.transform = CGAffineTransform(translationX: -(trailCvv.cgFloatValue() ?? 0.0), y: (cvvTop.cgFloatValue() ?? 0.0))
     
        if(bottomCvv != "0") {
            self.cvvTitle.transform = CGAffineTransform(translationX: self.cvvTitle.transform.tx, y: -(bottomCvv.cgFloatValue() ?? 0.0) + (cvvTop.cgFloatValue() ?? 0.0))
            self.cvvValue.transform = CGAffineTransform(translationX: self.cvvTitle.transform.tx, y: -(bottomCvv.cgFloatValue() ?? 0.0) + (cvvTop.cgFloatValue() ?? 0.0))
            self.eyeIconCvv.transform = CGAffineTransform(translationX: self.cvvTitle.transform.tx, y: -(bottomCvv.cgFloatValue() ?? 0.0) + (cvvTop.cgFloatValue() ?? 0.0))
        }
        if(leadCvv != "0") {
            
            self.cvvTitle.transform = CGAffineTransform(translationX: -(trailCvv.cgFloatValue() ?? 0.0) + (leadCvv.cgFloatValue() ?? 0.0) , y: self.cvvTitle.transform.ty)
            self.cvvValue.transform = CGAffineTransform(translationX: -(trailCvv.cgFloatValue() ?? 0.0) + (leadCvv.cgFloatValue() ?? 0.0) , y: self.cvvValue.transform.ty)
            self.eyeIconCvv.transform = CGAffineTransform(translationX: -(trailCvv.cgFloatValue() ?? 0.0) + (leadCvv.cgFloatValue() ?? 0.0) , y: self.eyeIconCvv.transform.ty)
        }


    }
    fileprivate func setCardNumberPadding(topCardNo: String,bottomCardNo: String,cardNoLeft: String,cardNoRight: String){
        self.cardNumberLabel.transform = CGAffineTransform(translationX: -(cardNoRight.cgFloatValue() ?? 0.0), y: (topCardNo.cgFloatValue() ?? 0.0))
        self.eyeIcon.transform = CGAffineTransform(translationX: -(cardNoRight.cgFloatValue() ?? 0.0), y: (topCardNo.cgFloatValue() ?? 0.0))

                    if(bottomCardNo != "0") {
                        self.cardNumberLabel.transform = CGAffineTransform(translationX: self.cardNumberLabel.transform.tx, y:  -(bottomCardNo.cgFloatValue() ?? 0.0) + (topCardNo.cgFloatValue() ?? 0.0))
                        self.eyeIcon.transform = CGAffineTransform(translationX: self.cardNumberLabel.transform.tx, y:  -(bottomCardNo.cgFloatValue() ?? 0.0) + (topCardNo.cgFloatValue() ?? 0.0))
                    }
        
                    if(cardNoLeft != "0") {
                        self.cardNumberLabel.transform = CGAffineTransform(translationX: -(cardNoRight.cgFloatValue() ?? 0.0) + (cardNoLeft.cgFloatValue() ?? 0.0) , y: self.cardNumberLabel.transform.ty)
                        self.eyeIcon.transform = CGAffineTransform(translationX:  -(cardNoRight.cgFloatValue() ?? 0.0) + (cardNoLeft.cgFloatValue() ?? 0.0), y: self.cardNumberLabel.transform.ty)
                    }
    }
    
    fileprivate func setDefaultStype(){
        frontCardView.backgroundColor = .darkblueColor
        cvvTitle.textColor = .white
        cardNumberLabel.textColor = .white
        nameLabel.textColor = .white
        validThruTitle.textColor = .white
        validThruValue.textColor = .white
        setfontValue(font: FontConstant.euclidFlexMediumFont,fontSize: 12.0)
        isCardMask = true
        isCvvMask = true
        isCardNoEye = true
        isCvvEye = true
        eyeIconCvv.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)
        eyeIcon.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)

    }
    fileprivate func setfontValue(font: String,fontSize: Float){
        let size = CGFloat(fontSize)
        self.cvvTitle.font = UIFont(name:font, size: size)
        self.cvvValue.font = UIFont(name:font, size: size)
        self.nameLabel.font = UIFont(name:font, size: size)
        self.cardNumberLabel.font = UIFont(name:font, size: size)
       
        self.validThruTitle.font = UIFont(name:font, size: size)
        self.validThruValue.font = UIFont(name:font, size: size)
    }
    public func sessionKey(token: String) {
        do {
            try initializeSDK()
        }catch {
            print(error)
            jailBreakLabel.text = CardSDKError.insecureEnvironment.localizedDescription
            jailBreakLabel.isHidden = false
        }
        
        self.token = token
       
    }
    
    @IBAction func onCardNoAction(_ sender: Any) {
  
        if isCardMask {
            if cardNumberLabel.text == "\(ConstantData.cardXDigit) \(panLastFour)" {
                cardNumberLabel.text = accountNo
            }else{
                cardNumberLabel.text = "\(ConstantData.cardXDigit) \(panLastFour)"
            }
        }
    }
    @IBAction func onFrontCvvAction(_ sender: Any) {
        if isCvvMask {
            
            if cvvValue.text == ConstantData.xxx {
                cvvValue.text = cvv
            }else{
                cvvValue.text = ConstantData.xxx
            }
        }
    }
    
}
extension CardWidget  {
    
    fileprivate func sessionKeyAPI(token: String,deviceFinger: String){
        let body = [
            APIConstant.token: token,
            APIConstant.deviceFingerprint: deviceFinger
        ] as [String : Any]
        let url = baseUrlService + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.key ?? String.Empty
                let data = [
                    APIConstant.token: session.token ?? String.Empty,
                    APIConstant.deviceFingerprint: deviceFinger
                ] as [String : Any]
                self.getCardDetails(body: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    fileprivate func getCardDetails(body: [String : Any]) {
        let url = baseUrlService + servicesURL.secureCard.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
            (result: Result<GetCardDetailEntity,Error>) in
            switch result{
            case .success(let getCardDetail):
                self.activityInstance.showIndicator()
                self.nameLabel.text = getCardDetail.items?.embossedName ?? ""
                self.decrypt(accountNo: getCardDetail.items?.cardNumber ?? "",cvv: getCardDetail.items?.cvv2 ?? "",expiry: getCardDetail.items?.expiry ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func decrypt(accountNo: String,cvv: String,expiry: String){
        do {
            let accountNumber = try AESUtils().decrypt(encryptedText: accountNo, key: self.generalKey)
            let last4 = accountNumber.suffix(4)
            panLastFour = String(last4)
            let formattedCreditCardNumber = accountNumber.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d+)", with: "$1 $2 $3 $4", options: .regularExpression, range: nil)

            self.accountNo = formattedCreditCardNumber
            let cvvText = try AESUtils().decrypt(encryptedText: cvv, key: self.generalKey)

                self.cardNumberLabel.text = "\(ConstantData.cardXDigit) \(panLastFour)"
            self.cvvValue.text = ConstantData.xxx

            self.cvv = cvvText
            let expiryText = try AESUtils().decrypt(encryptedText: expiry, key: self.generalKey)
            cardNumberLabel.isHidden = false
            cvvValue.isHidden = false
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "ddMM"

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"

            let dateStr: Date? = dateFormatterGet.date(from: expiryText)
            print(dateFormatter.string(from: dateStr!))
            self.validThruValue.text = dateFormatter.string(from: dateStr!)
            activityInstance.hideIndicator()
            
        } catch {
            print(error)
        }
    }
}




