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
    
    @IBOutlet weak var backStripeView: UIView!
    @IBOutlet weak var backCvvLabel: UILabel!
    @IBOutlet weak var backDateLabel: UILabel!
    @IBOutlet weak var backCardNo: UILabel!
    @IBOutlet weak public var frontCardView: UIView!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak public var backCardView: UIView!
    @IBOutlet weak public var overView: UIView!
    @IBOutlet weak var backCvvBtn: UIButton!
    @IBOutlet weak var backCardNoBtn: UIButton!
    @IBOutlet weak var frontImgView: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backCardImg: UIImageView!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var expiryLeadConstant: NSLayoutConstraint!
    @IBOutlet weak var cvvLeadConstant: NSLayoutConstraint!
    @IBOutlet weak var cardNoYaxisConstant: NSLayoutConstraint!
    @IBOutlet weak var cardNoLeadConstant: NSLayoutConstraint!
    @IBOutlet weak var expiryBottomConstant: NSLayoutConstraint!
    @IBOutlet weak var cvvTrailConstant: NSLayoutConstraint!
    @IBOutlet weak var backCardNoTopConstant: NSLayoutConstraint!
    @IBOutlet weak var backCardNoYAxisConstant: NSLayoutConstraint!
    @IBOutlet weak var backDateLeadConstant: NSLayoutConstraint!
    @IBOutlet weak var backDateTrailConstant: NSLayoutConstraint!
    @IBOutlet weak var backDateTopConstant: NSLayoutConstraint!
    @IBOutlet weak var backCvvLeadConstant: NSLayoutConstraint!
    @IBOutlet weak var backCvvTrailConstant: NSLayoutConstraint!
    @IBOutlet weak var backCvvtopConstant: NSLayoutConstraint!
    @IBOutlet weak var backCvvBottomConstant: NSLayoutConstraint!
    @IBOutlet weak var backCardNoLead: NSLayoutConstraint!
    @IBOutlet weak var cvvStackView: UIStackView!
    @IBOutlet weak var bottomCVV: NSLayoutConstraint!
    @IBOutlet weak var validThStackView: UIStackView!
    @IBOutlet weak var bottomValidThruConstant: NSLayoutConstraint!
    @IBOutlet weak var validThruValue: UILabel!
    @IBOutlet weak var validThruLabel: UILabel!
    @IBOutlet weak var cvvTitleLabel: UILabel!
    @IBOutlet weak var titleCardName: UILabel!
    
    @IBOutlet weak var cvvEyeBtn: UIButton!
    @IBOutlet weak var cardNoEyeBtn: UIButton!
    var generalKey = ""
    let activityInstance = Indicator()
    var accountNo = ""
    var cvv = ""
    var isCvvMask = false
    var isCardMask = false
    var panLastFour = ""
    var token = ""
    var widget:[WidgetSettingEntity] = []
    
    @IBOutlet weak var jailBreakLabel: UILabel!
    var isCvvEye = false
    var isCardNoEye = false
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
        do {
            try initializeSDK()
        }catch {
            print(error)
            jailBreakLabel.text = CardSDKError.insecureEnvironment.localizedDescription
            jailBreakLabel.isHidden = false
            overView.isHidden = true
        }

    }
    func initializeSDK() throws {
        if hasJailbreak() != CardSDKError.insecureEnvironment {
            throw CardSDKError.insecureEnvironment
        }
        // Continue with initialization if the device is secure
        initalLoad()
        if widget.count == 0 {
            setDefaultStype()
        }else{
            setWidgetData(widget: widget)
        }
        
        deviceFingerPrint = getDevicFingingerprint()
        sessionKeyAPI(token: token,deviceFinger: deviceFingerPrint)
    }
    
    private func initalLoad(){
        jailBreakLabel.isHidden = true
        overView.isHidden = false

        frontCardView.layer.cornerRadius = 10
        backCardView.layer.cornerRadius = 10
        frontImgView.layer.cornerRadius = 10
        backCardImg.layer.cornerRadius = 10
        overView.layer.cornerRadius = 10
        cardImg.image = UIImage(named: "visa.png")
        backCardView.isHidden = true
        cardNumberLabel.font = UIFont.setCustomFont(name: .semiBold, size: .x14)
        titleCardName.font = UIFont.setCustomFont(name: .semiBold, size: .x12)
        cvvTitleLabel.font = UIFont.setCustomFont(name: .semiBold, size: .x12)
        validThruLabel.font = UIFont.setCustomFont(name: .semiBold, size: .x12)
        cvvEyeBtn.setTitle("", for: .normal)
        cardNoEyeBtn.setTitle("", for: .normal)
    }
    
    @IBAction func onCvvEyeAction(_ sender: Any) {
        if isCvvEye {
            if cvvLabel.text == ConstantData.xxx {
                cvvLabel.text = cvv
                cvvEyeBtn.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)

            }else{
                cvvLabel.text = ConstantData.xxx
                cvvEyeBtn.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)
            }
        }
    }
    
    @IBAction func onCardNoEyeAction(_ sender: Any) {
        if isCardNoEye {
            if cardNumberLabel.text == "\(ConstantData.cardXDigit) \(panLastFour)" {
                cardNumberLabel.text = accountNo
                cardNoEyeBtn.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)

            }else{
                cardNumberLabel.text = "\(ConstantData.cardXDigit) \(panLastFour)"
                cardNoEyeBtn.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)

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
        self.widget = widget
    }
    
    private  func setWidgetData(widget: [WidgetSettingEntity]){
        for item in widget {
            if item.widgetStyle == ConstantData.viewCard {
                
                setfontValue(font: item.fontFamily ?? FontConstant.euclidFlexMediumFont,fontSize: item.fontSize ?? 14.0)

                backCardView.backgroundColor = item.background
                showEyeButton(isEyeIcon: item.showEyeIcon ?? false)
               
                setTimer(maskCardNo: item.maskCardNumber ?? false, maskCvv: item.maskCvv ?? false)
       
                frontCardView.backgroundColor = item.background
                setFontColor(fontColor: item.fontColor!)
                
                if item.backgroundImage != UIImage(named: "imageadd") {
                    backImg.image = item.backgroundImage
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
            cvvEyeBtn.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)
            cardNoEyeBtn.setImage(UIImage(named: ImageConstant.eyeOffImage), for: .normal)
            cvvEyeBtn.isHidden = false
            cardNoEyeBtn.isHidden = false
        }else{
            cvvEyeBtn.isHidden = true
            cardNoEyeBtn.isHidden = true
        }
    }
    
    private func setTimer(maskCardNo : Bool,maskCvv: Bool){
        isCardMask = maskCardNo
        isCvvMask = maskCvv
    }
    
    private func setFontColor(fontColor: UIColor){
        cvvLabel.textColor = fontColor
        cardNumberLabel.textColor = fontColor
        nameOnCardLabel.textColor = fontColor
        backCvvLabel.textColor = fontColor
        backDateLabel.textColor = fontColor
        backCardNo.textColor = fontColor
        cvvTitleLabel.textColor = fontColor
        titleCardName.textColor = fontColor
        validThruLabel.textColor = fontColor
        validThruValue.textColor = fontColor
    }
    private func setDatePadding(bottomDate: String,topDate: String,trailDate: String,leadDate: String){
        if !bottomDate.isEmpty && bottomDate != "0"  {
            self.bottomValidThruConstant.constant =  (bottomDate.cgFloatValue() ?? 0.0)
        }
        if !leadDate.isEmpty && leadDate != "0" {
            self.cvvLeadConstant.constant = (self.validThStackView.frame.size.width ) -  (leadDate.cgFloatValue() ?? 0.0)
        }
        
        if !trailDate.isEmpty && trailDate != "0" {
            self.cvvLeadConstant.constant = (self.validThStackView.frame.size.width ) +  (leadDate.cgFloatValue() ?? 0.0)
        }
        
        if !topDate.isEmpty && topDate != "0" {
            self.bottomValidThruConstant.constant = (self.validThStackView.frame.size.height) - (topDate.cgFloatValue() ?? 0.0)
        }
        self.frontCardView.layoutIfNeeded()

    }
    
    private func setCvvPadding(leadCvv: String,bottomCvv: String,trailCvv: String,cvvTop: String) {
        if !leadCvv.isEmpty && leadCvv != "0" {
            self.cvvLeadConstant.constant = leadCvv.cgFloatValue() ?? 0.0
            backCvvLeadConstant.constant = leadCvv.cgFloatValue() ?? 0.0
        }
        if !trailCvv.isEmpty && trailCvv != "0" {
            self.cvvTrailConstant.constant = trailCvv.cgFloatValue() ?? 0.0
            backCvvTrailConstant.constant = trailCvv.cgFloatValue() ?? 0.0
        }
       
        if !bottomCvv.isEmpty && bottomCvv != "0" {
            self.bottomCVV.constant =  (bottomCvv.cgFloatValue() ?? 0.0)
        }
        if !cvvTop.isEmpty && cvvTop != "0" {
            self.bottomCVV.constant =  (self.cvvStackView.frame.size.height) - (cvvTop.cgFloatValue() ?? 0.0)
        }
        self.frontCardView.layoutIfNeeded()

    }
    fileprivate func setCardNumberPadding(topCardNo: String,bottomCardNo: String,cardNoLeft: String,cardNoRight: String){
        if !cardNoLeft.isEmpty && cardNoLeft != "0" {
            self.cardNoLeadConstant.constant = cardNoLeft.cgFloatValue() ?? 0.0
            self.backCardNoLead.constant = cardNoLeft.cgFloatValue() ?? 0.0

        }
        if !cardNoRight.isEmpty && cardNoRight != "0" {
            self.cardNoLeadConstant.constant = ((cardNoLeft.cgFloatValue() ?? 0.0) - (cardNoRight.cgFloatValue() ?? 0.0))
            self.backCardNoLead.constant = ((cardNoLeft.cgFloatValue() ?? 0.0) - (cardNoRight.cgFloatValue() ?? 0.0))
        }
     
        if !bottomCardNo.isEmpty && bottomCardNo != "0" {
            self.cardNoYaxisConstant.constant = (self.cardNoYaxisConstant.constant) + (bottomCardNo.cgFloatValue() ?? 0.0)
            backCardNoYAxisConstant.constant = (self.backCardNoYAxisConstant.constant) + (bottomCardNo.cgFloatValue() ?? 0.0)
        }
        if !topCardNo.isEmpty && topCardNo != "0" {
            self.cardNoYaxisConstant.constant = (self.cardNoYaxisConstant.constant) - (topCardNo.cgFloatValue() ?? 0.0)
            backCardNoYAxisConstant.constant = (self.backCardNoYAxisConstant.constant) + (topCardNo.cgFloatValue() ?? 0.0)
        }
        self.frontCardView.layoutIfNeeded()
    }
    
    fileprivate func setDefaultStype(){
        backCardView.backgroundColor = .darkblueColor
        frontCardView.backgroundColor = .darkblueColor
        cvvLabel.textColor = .white
        cardNumberLabel.textColor = .white
        nameOnCardLabel.textColor = .white
        backCvvLabel.textColor = .white
        backDateLabel.textColor = .white
        backCardNo.textColor = .white
        validThruLabel.textColor = .white
        validThruValue.textColor = .white
        setfontValue(font: FontConstant.euclidFlexMediumFont,fontSize: 12.0)
        backImg = nil
        frontImgView = nil
        isCardMask = true
        isCvvMask = true
        isCardNoEye = true
        isCvvEye = true
        cvvEyeBtn.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)
        cardNoEyeBtn.setImage(UIImage(named: ImageConstant.eyeImage), for: .normal)

    }
    fileprivate func setfontValue(font: String,fontSize: Float){
        let size = CGFloat(fontSize)
        self.cvvTitleLabel.font = UIFont(name:font, size: size)
        self.cvvLabel.font = UIFont(name:font, size: size)
        self.nameOnCardLabel.font = UIFont(name:font, size: size)
        self.cardNumberLabel.font = UIFont(name:font, size: size)
        cvvTitleLabel.font = UIFont(name:font, size: size)
        titleCardName.font = UIFont(name:font, size: size)
        self.backCvvLabel.font = UIFont(name:font, size: size)
        self.backDateLabel.font = UIFont(name:font, size: size)
        self.backCardNo.font = UIFont(name:font, size: size)
        self.validThruLabel.font = UIFont(name:font, size: size)
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
    
    @IBAction func onBackCardNoAction(_ sender: Any) {
        if isCardMask {
            if backCardNo.text == "\(ConstantData.cardXDigit) \(panLastFour)" {
                backCardNo.text = accountNo
            }else{
                backCardNo.text = "\(ConstantData.cardXDigit) \(panLastFour)"
            }
        }
    }
    
    
    @IBAction func onCvvAction(_ sender: Any) {
        if isCvvMask {
            if backCvvLabel.text == ConstantData.xxx {
                backCvvLabel.text = cvv
            }else{
                backCvvLabel.text = ConstantData.xxx
            }
        }
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
            
            if cvvLabel.text == ConstantData.xxx {
                cvvLabel.text = cvv
            }else{
                cvvLabel.text = ConstantData.xxx
            }
        }
    }
    public func showCard(showFrontBack: Bool){
        
        if showFrontBack {
            frontCardView.isHidden = false
            backCardView.isHidden = true
        }else{
            backCardView.isHidden = false
            frontCardView.isHidden = true
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
                self.nameOnCardLabel.text = getCardDetail.items?.embossedName ?? ""
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
            self.accountNo = accountNumber
            let cvvText = try AESUtils().decrypt(encryptedText: cvv, key: self.generalKey)

                self.cardNumberLabel.text = "\(ConstantData.cardXDigit) \(panLastFour)"
            self.cvvLabel.text = ConstantData.xxx

            self.cvv = cvvText
            let expiryText = try AESUtils().decrypt(encryptedText: expiry, key: self.generalKey)
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
            self.validThruValue.text = expiryText
            self.backDateLabel.text = expiryText
            activityInstance.hideIndicator()
            
        } catch {
            print(error)
        }
    }
}




