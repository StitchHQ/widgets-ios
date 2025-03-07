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
    var styleType = ""
    var accountNo = ""
    var cvv = ""
    var isCvvMask = false
    var isCardMask = false
    var panLastFour = ""
    
    var isCvvEye = false
    var isCardNoEye = false
    public override func awakeFromNib() {
        
        super.awakeFromNib()
   
        frontCardView.layer.cornerRadius = 10
        backCardView.layer.cornerRadius = 10
        frontImgView.layer.cornerRadius = 10
        backCardImg.layer.cornerRadius = 10
        overView.layer.cornerRadius = 10
        cardImg.image = UIImage(named: "Vector.png")
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
            if cvvLabel.text == "XXX" {
                cvvLabel.text = cvv
                cvvEyeBtn.setImage(UIImage(named: "eye.png"), for: .normal)

            }else{
                cvvLabel.text = "XXX"
                cvvEyeBtn.setImage(UIImage(named: "eye-off.png"), for: .normal)

            }
        }
    }
    
    
    @IBAction func onCardNoEyeAction(_ sender: Any) {
        if isCardNoEye {
            if cardNumberLabel.text == "XXXX XXXX XXXX \(panLastFour)" {
                cardNumberLabel.text = accountNo
                cardNoEyeBtn.setImage(UIImage(named: "eye.png"), for: .normal)

            }else{
                cardNumberLabel.text = "XXXX XXXX XXXX \(panLastFour)"
                cardNoEyeBtn.setImage(UIImage(named: "eye-off.png"), for: .normal)

            }
        }
    }
    
    public func setWidgetSetting(widget: [WidgetSettingEntity]){
       
        if widget.count == 0 {
            setDefaultStype()
        }else{
            
            for item in widget {
                if item.type == "View Card" {
                    
                    setfontValue(font: item.font ?? "EuclidFlex-Medium",fontSize: item.fontSize ?? 14.0)

                    backCardView.backgroundColor = backgroundColor
                    isCardMask = item.isCardNoMask ?? false
                    isCvvMask = item.iscvvMask ?? false
                    self.isCvvEye = item.isEyeMask ?? false
                    self.isCardNoEye = item.isEyeMask ?? false
                    if item.isEyeMask ?? false {
                        cvvEyeBtn.setImage(UIImage(named: "eye-off.png"), for: .normal)
                        cardNoEyeBtn.setImage(UIImage(named: "eye-off.png"), for: .normal)
                        cvvEyeBtn.isHidden = false
                        cardNoEyeBtn.isHidden = false
                    }else{
                        cvvEyeBtn.isHidden = true
                        cardNoEyeBtn.isHidden = true
                    }
                    let date = Date()

                    if let time = UserDefaults.standard.value(forKey: "MaskTime") as? Date{
                        print(time)
                        let diffComponents = Calendar.current.dateComponents([.second], from: time, to: date)
                        
                        print(diffComponents)
                        if diffComponents.second! <= 30 {
                            isCardMask = false
                            isCvvMask = false
                        }else{
                            isCardMask = item.isCardNoMask ?? false
                            isCvvMask = item.iscvvMask ?? false
                        }
                    }
                    
           
                    frontCardView.backgroundColor = backgroundColor
                    cvvLabel.textColor = item.fontColor
                    cardNumberLabel.textColor = item.fontColor
                    nameOnCardLabel.textColor = item.fontColor
                    backCvvLabel.textColor = item.fontColor
                    backDateLabel.textColor = item.fontColor
                    backCardNo.textColor = item.fontColor
                    cvvTitleLabel.textColor = item.fontColor
                    titleCardName.textColor = item.fontColor
                    validThruLabel.textColor = item.fontColor
                    validThruValue.textColor = item.fontColor
                    
                    if item.backgroundImg != UIImage(named: "imageadd") {
                        backImg.image = item.backgroundImg
                        frontImgView.image = item.backgroundImg
                    }
                    
                    self.setPaddingTextField(bottomDate: item.dateBottom!,topDate: item.dateTop!,leadCvv:item.cvvLeft!,leadDate: item.dateLeft!,BottomCvv: item.cvvBottom!,trailDate: item.dateRight!,TrailCvv: item.cvvRight!,topCardNo: item.cardNoTop!,BottomCardNo: item.cardNoBottom!,cvvTop: item.cvvTop!,cardNoLeft: item.cardNoLeft!,cardNoRight: item.cardNoRight!)
                }else {
                    setDefaultStype()
                }
            }
        }
        
    }
    fileprivate func setPaddingTextField(bottomDate: String,topDate: String,leadCvv: String,leadDate: String,BottomCvv: String,trailDate: String,TrailCvv: String,topCardNo: String,BottomCardNo: String,cvvTop: String,cardNoLeft: String,cardNoRight: String){
        if !cardNoLeft.isEmpty && cardNoLeft != "0" {
            self.cardNoLeadConstant.constant = cardNoLeft.CGFloatValue() ?? 0.0
            self.backCardNoLead.constant = cardNoLeft.CGFloatValue() ?? 0.0

        }
        if !cardNoRight.isEmpty && cardNoRight != "0" {
            self.cardNoLeadConstant.constant = ((cardNoLeft.CGFloatValue() ?? 0.0) - (cardNoRight.CGFloatValue() ?? 0.0))
            self.backCardNoLead.constant = ((cardNoLeft.CGFloatValue() ?? 0.0) - (cardNoRight.CGFloatValue() ?? 0.0))

        }
        if !bottomDate.isEmpty && bottomDate != "0"  {
            self.bottomValidThruConstant.constant =  (bottomDate.CGFloatValue() ?? 0.0)
        }
        if !leadDate.isEmpty && leadDate != "0" {
            self.cvvLeadConstant.constant = (self.validThStackView.frame.size.width ) -  (leadDate.CGFloatValue() ?? 0.0)
        }
        
        if !trailDate.isEmpty && trailDate != "0" {
            self.cvvLeadConstant.constant = (self.validThStackView.frame.size.width ) +  (leadDate.CGFloatValue() ?? 0.0)
        }
        
        if !topDate.isEmpty && topDate != "0" {
            self.bottomValidThruConstant.constant = (self.validThStackView.frame.size.height) - (topDate.CGFloatValue() ?? 0.0)
        }
        if !leadCvv.isEmpty && leadCvv != "0" {
            self.cvvLeadConstant.constant = leadCvv.CGFloatValue() ?? 0.0
            backCvvLeadConstant.constant = leadCvv.CGFloatValue() ?? 0.0
        }
        if !TrailCvv.isEmpty && TrailCvv != "0" {
            self.cvvTrailConstant.constant = TrailCvv.CGFloatValue() ?? 0.0
            backCvvTrailConstant.constant = TrailCvv.CGFloatValue() ?? 0.0
        }
       
        if !BottomCvv.isEmpty && BottomCvv != "0" {
            self.bottomCVV.constant =  (BottomCvv.CGFloatValue() ?? 0.0)
        }
        if !cvvTop.isEmpty && cvvTop != "0" {
            self.bottomCVV.constant =  (self.cvvStackView.frame.size.height) - (cvvTop.CGFloatValue() ?? 0.0)
        }
     
        if !BottomCardNo.isEmpty && BottomCardNo != "0" {
            self.cardNoYaxisConstant.constant = (self.cardNoYaxisConstant.constant) + (BottomCardNo.CGFloatValue() ?? 0.0)
            backCardNoYAxisConstant.constant = (self.backCardNoYAxisConstant.constant) + (BottomCardNo.CGFloatValue() ?? 0.0)
        }
        if !topCardNo.isEmpty && topCardNo != "0" {
            self.cardNoYaxisConstant.constant = (self.cardNoYaxisConstant.constant) - (topCardNo.CGFloatValue() ?? 0.0)
            backCardNoYAxisConstant.constant = (self.backCardNoYAxisConstant.constant) + (topCardNo.CGFloatValue() ?? 0.0)
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
        setfontValue(font: "EuclidFlex-Medium",fontSize: 12.0)
        backImg = nil
        frontImgView = nil
        isCardMask = true
        isCvvMask = true
        isCardNoEye = true
        isCvvEye = true
        cvvEyeBtn.setImage(UIImage(named: "eye.png"), for: .normal)
        cardNoEyeBtn.setImage(UIImage(named: "eye.png"), for: .normal)

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
        styleType = "Default"
        deviceFingerPrint = getDevicFingingerprint()
        sessionKeyAPI(token: token,deviceFinger: deviceFingerPrint)
    }
    
    
    fileprivate func setData(){
        if styleType == "Default" {
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
        }else if styleType == "Horizontal" {
            backStripeView.backgroundColor = .black
            cardImg.isHidden = true
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
            backCardImg.isHidden = true
        }else if styleType == "Horizontal Flippable 1" {
            cardImg.isHidden = true
            cardNumberLabel.isHidden = true
            cvvLabel.isHidden = true
            backCvvLabel.isHidden = false
            backDateLabel.isHidden = false
            backCardNo.isHidden = false
            backCardImg.isHidden = false
          //  nameCardTop.constant = 20
        }else if styleType == "Vertical Flippable" {
            backStripeView.backgroundColor = .lightGray
            cardImg.isHidden = false
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
            backCvvLabel.isHidden = true
            backDateLabel.isHidden = true
            backCardNo.isHidden = true
            backCardImg.isHidden = true
        }else if styleType == "Horizontal Flippable 2" {
            backStripeView.backgroundColor = .lightGray
            cardImg.isHidden = true
            cardNumberLabel.isHidden = true
            cvvLabel.isHidden = true
            backCvvLabel.isHidden = false
            backDateLabel.isHidden = false
            backCardNo.isHidden = false
            backCardImg.isHidden = false
        }
    }
    @IBAction func onBackCardNoAction(_ sender: Any) {
        if isCardMask {
            if backCardNo.text == "XXXX XXXX XXXX \(panLastFour)" {
                backCardNo.text = accountNo
                if UserDefaults.standard.value(forKey: "MaskTime") is Date{
                }else{
                    let date = Date()
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                backCardNo.text = "XXXX XXXX XXXX \(panLastFour)"
            }
        }
    }
    
    
    @IBAction func onCvvAction(_ sender: Any) {
        if isCvvMask {
            if backCvvLabel.text == "XXX" {
                backCvvLabel.text = cvv
                if UserDefaults.standard.value(forKey: "MaskTime") is Date{
                }else{
                    let date = Date()
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                backCvvLabel.text = "XXX"
            }
        }
    }
    
    @IBAction func onCardNoAction(_ sender: Any) {
  
        if isCardMask {
            if cardNumberLabel.text == "XXXX XXXX XXXX \(panLastFour)" {
                cardNumberLabel.text = accountNo
                if UserDefaults.standard.value(forKey: "MaskTime") is Date{
                }else{
                    let date = Date()
                    
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                cardNumberLabel.text = "XXXX XXXX XXXX \(panLastFour)"
            }
        }
    }
    @IBAction func onFrontCvvAction(_ sender: Any) {
        if isCvvMask {
            
            if cvvLabel.text == "XXX" {
                cvvLabel.text = cvv
                if UserDefaults.standard.value(forKey: "MaskTime") is Date{
                }else{
                    let date = Date()
                    
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                cvvLabel.text = "XXX"
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
    
    public func callAppleWallet(){
        // 1
             guard isPassKitAvailable() else {
                 showPassKitUnavailable(message: "InApp enrollment not available for this device")
                 return
             }
             // 2
             initEnrollProcess()
    }
    
}
extension CardWidget  {
    
    fileprivate func sessionKeyAPI(token: String,deviceFinger: String){
        let body = [
            "token": token,
            "deviceFingerprint": deviceFinger
        ] as [String : Any]
        let url = baseUrl + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.key ?? ""
                let data = [
                    "token": session.token ?? "",
                    "deviceFingerprint": deviceFinger
                ] as [String : Any]
                self.getCardDetails(body: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    fileprivate func getCardDetails(body: [String : Any]) {
        let url = baseUrl + servicesURL.secureCard.rawValue
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
//            if isCardMask {
//                self.cardNumberLabel.text = "XXXX XXXX XXXX \(panLastFour)"
//                self.backCardNo.text = "XXXX XXXX XXXX \(panLastFour)"
//            }else{
//                self.cardNumberLabel.text = accountNumber
//                self.backCardNo.text = accountNumber
//            }
            self.accountNo = accountNumber
            let cvvText = try AESUtils().decrypt(encryptedText: cvv, key: self.generalKey)
//            if isCvvMask {
//                self.cvvLabel.text = "XXX"
//                self.backCvvLabel.text = "XXX"
//            }else{
//                self.cvvLabel.text = cvvText
//                self.backCvvLabel.text = cvvText
//
//            }
//            if isCvvEye {
                self.cardNumberLabel.text = "XXXX XXXX XXXX \(panLastFour)"
                self.cvvLabel.text = "XXX"
//            }
            self.cvv = cvvText
            let expiryText = try AESUtils().decrypt(encryptedText: expiry, key: self.generalKey)
            self.validThruValue.text = expiryText
            self.backDateLabel.text = expiryText
            setData()
            activityInstance.hideIndicator()
            
        } catch {
            print(error)
        }
    }
}




extension CAGradientLayer {
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}
extension CardWidget {
/**
     Init enrollment process
     */
    fileprivate func initEnrollProcess() {
        // 3
        let card = cardInformation()
        // 4
        guard let configuration = PKAddPaymentPassRequestConfiguration(encryptionScheme: .ECC_V2) else {
            showPassKitUnavailable(message: "InApp enrollment configuraton fails")
            return
        }
        configuration.cardholderName = card.holder
        configuration.primaryAccountSuffix = card.panTokenSuffix
        
        guard let enrollViewController = PKAddPaymentPassViewController(requestConfiguration: configuration, delegate: self) else {
            showPassKitUnavailable(message: "InApp enrollment controller configuration fails")
            return
        }
        
        // 5
        UIApplication.topViewController()?.present(enrollViewController, animated: true, completion: nil)
    }
    
    /**
     Define if PassKit will be available for this device
     */
    fileprivate func isPassKitAvailable() -> Bool {
        return PKAddPaymentPassViewController.canAddPaymentPass()
    }
    
    /**
     Show an alert that indicates that PassKit isn't available for this device
     */
    fileprivate func showPassKitUnavailable(message: String) {
        let alert = UIAlertController(title: "InApp Error",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    /**
     Return the card information that Apple will display into enrollment screen
     */
    fileprivate func cardInformation() -> Card {
        return Card(panTokenSuffix: "1234", holder: "Carl Jonshon")
    }
}

private struct Card {
    /// Last four digits of the `pan token` numeration for the card (****-****-****-0000)
    let panTokenSuffix: String
    /// Holder for the card
    let holder: String
}


extension CardWidget: PKAddPaymentPassViewControllerDelegate {
    public func addPaymentPassViewController(
        _ controller: PKAddPaymentPassViewController,
        generateRequestWithCertificateChain certificates: [Data],
        nonce: Data, nonceSignature: Data,
        completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void) {
        
        // 1
        let request = IssuerRequest(certificates: certificates, nonce: nonce, nonceSignature: nonceSignature)
        
        // 2
        let interactor = GetPassKitDataIssuerHostInteractor()
        interactor.execute(request: request) { response in
            // 3
            let request = PKAddPaymentPassRequest()
            request.activationData = response.activationData
            request.ephemeralPublicKey = response.ephemeralPublicKey
            request.encryptedPassData = response.encryptedPassData
            handler(request)
        }
    }
    
    public func addPaymentPassViewController(
        _ controller: PKAddPaymentPassViewController,
        didFinishAdding pass: PKPaymentPass?,
        error: Error?) {
        
        // 4
        if let _ = pass {
            print("Everything it's ok!")
        } else {
            print("Oops, something fails!")
        }
    }
}

struct IssuerRequest {
    let certificates: [Data]
    let nonce: Data
    let nonceSignature: Data
    
    // todo: Another data that your IssuerHost needs
}

struct IssuerResponse {
    let activationData: Data
    let ephemeralPublicKey: Data
    let encryptedPassData: Data
}

private class GetPassKitDataIssuerHostInteractor {
    func execute(request: IssuerRequest, onFinish: (IssuerResponse) -> ()) {
        // todo: Here goes your implementation thar connect with your IssuerHost
        let response = IssuerResponse(activationData: Data(),
                                      ephemeralPublicKey: Data(),
                                      encryptedPassData: Data())
        onFinish(response)
    }
}
