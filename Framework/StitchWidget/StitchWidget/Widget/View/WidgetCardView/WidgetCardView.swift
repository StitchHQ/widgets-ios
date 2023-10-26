//
//  WidgetCardView.swift
//  Stitchdemo
//
//  Created by vizhi on 03/08/23.
//

import UIKit


public class WidgetCardView: UIView {
    
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var backStripeView: UIView!
    @IBOutlet weak var backCvvLabel: UILabel!
    @IBOutlet weak var backDateLabel: UILabel!
    @IBOutlet weak var backCardNo: UILabel!
    @IBOutlet weak public var frontCardView: UIView!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak public var backCardView: UIView!
    @IBOutlet weak public var overView: UIView!

    @IBOutlet weak var nameCardTop: NSLayoutConstraint!
    @IBOutlet weak var frontCvvBtn: UIButton!
    @IBOutlet weak var frontCardNoBtn: UIButton!
    @IBOutlet weak var backCvvBtn: UIButton!
    @IBOutlet weak var backCardNoBtn: UIButton!
    @IBOutlet weak var frontImgView: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backCardImg: UIImageView!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var expiryLeadConstant: NSLayoutConstraint!
    @IBOutlet weak var cvvBottomConstant: NSLayoutConstraint!
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
    var generalKey = ""
    let activityInstance = Indicator()
    var styleType = ""
    var accountNo = ""
    var cvv = ""
    var isCvvMask = false
    var isCardMask = false
    var cardName = ""

    public override func awakeFromNib() {
        
        super.awakeFromNib()
   
        frontCardView.layer.cornerRadius = 10
        backCardView.layer.cornerRadius = 10
        frontImgView.layer.cornerRadius = 10
        backCardImg.layer.cornerRadius = 10
        overView.layer.cornerRadius = 10

        backCardView.isHidden = true
        downImg.isHidden = true
        cardNumberLabel.font = UIFont.setCustomFont(name: .semiBold, size: .x14)

    }
    
    
    public func setUserDefault(widget: NSMutableArray){
       
        if widget.count == 0 {
            setDefaultStype()
        }else{
            
            for item in widget {
                let data = item as! [String: Any]
                let type = data["type"] as! String
                let backgroundColor = data["backgroundColor"] as! UIColor
                let backgroundImg = data["backgroundImg"] as! UIImage
                let fontColor = data["fontColor"] as! UIColor
                let iscvvMask = data["iscvvMask"] as! Bool
                let iscardNoMask = data["isCardNoMask"] as! Bool
                let font = data["font"] as! String
                let fontsize = data["fontSize"] as! Float
                
                let cardNoTop = data["cardNoTop"] as! String
                let cardNoBottom = data["cardNoBottom"] as! String
                let cvvLeft = data["cvvLeft"] as! String
                let cvvRight = data["cvvRight"] as! String
                let cvvTop = data["cvvTop"] as! String
                let cvvBottom = data["cvvBottom"] as! String
                let dateLeft = data["dateLeft"] as! String
                let dateRight = data["dateRight"] as! String
                let dateTop = data["dateTop"] as! String
                let dateBottom = data["dateBottom"] as! String
                let cardNoLeft = data["cardNoLeft"] as! String
                let cardNoRight = data["cardNoRight"] as! String
                if type == "View Card" {
                    
                    
                    setfontValue(font: font,fontSize: fontsize)

                    backCardView.backgroundColor = backgroundColor
                    isCardMask = iscardNoMask
                    isCvvMask = iscvvMask
                    let date = Date()

                    if let time = UserDefaults.standard.value(forKey: "MaskTime") as? Date{
                        print(time)
                        let diffComponents = Calendar.current.dateComponents([.second], from: time, to: date)
                        
                        print(diffComponents)
                        if diffComponents.second! <= 30 {
                            isCardMask = false
                            isCvvMask = false
                        }else{
                            isCardMask = iscardNoMask
                            isCvvMask = iscvvMask
                        }
                    }
                    
           
                    frontCardView.backgroundColor = backgroundColor
                    cvvLabel.textColor = fontColor
                    expiryLabel.textColor = fontColor
                    cardNumberLabel.textColor = fontColor
                    nameOnCardLabel.textColor = fontColor
                    backCvvLabel.textColor = fontColor
                    backDateLabel.textColor = fontColor
                    backCardNo.textColor = fontColor
                    if backgroundImg != UIImage(named: "imageadd") {
                        backImg.image = backgroundImg
                        frontImgView.image = backgroundImg
                    }
                    
                    self.setPaddingTextField(bottomDate: dateBottom,topDate: dateTop,leadCvv:cvvLeft,leadDate: dateLeft,BottomCvv: cvvBottom,trailDate: dateRight,TrailCvv: cvvRight,topCardNo: cardNoTop,BottomCardNo: cardNoBottom,cvvTop: cvvTop,cardNoLeft: cardNoLeft,cardNoRight: cardNoRight)
                    return
                }else {
                    setDefaultStype()
                }
            }
        }
        
    }
    private func setPaddingTextField(bottomDate: String,topDate: String,leadCvv: String,leadDate: String,BottomCvv: String,trailDate: String,TrailCvv: String,topCardNo: String,BottomCardNo: String,cvvTop: String,cardNoLeft: String,cardNoRight: String){
        if !cardNoLeft.isEmpty && cardNoLeft != "0" {
            self.cardNoLeadConstant.constant = cardNoLeft.CGFloatValue() ?? 0.0
            self.backCardNoLead.constant = cardNoLeft.CGFloatValue() ?? 0.0

        }
        if !cardNoRight.isEmpty && cardNoRight != "0" {
            self.cardNoLeadConstant.constant = ((cardNoLeft.CGFloatValue() ?? 0.0) - (cardNoRight.CGFloatValue() ?? 0.0))
            self.backCardNoLead.constant = ((cardNoLeft.CGFloatValue() ?? 0.0) - (cardNoRight.CGFloatValue() ?? 0.0))

        }
        if !bottomDate.isEmpty && bottomDate != "0"  {
            
            self.expiryBottomConstant.constant = bottomDate.CGFloatValue() ?? 0.0
            self.backCvvtopConstant.constant = bottomDate.CGFloatValue() ?? 0.0
        }
        if !leadDate.isEmpty && leadDate != "0" {
            self.expiryLeadConstant.constant = leadDate.CGFloatValue() ?? 0.0
            backDateLeadConstant.constant = leadDate.CGFloatValue() ?? 0.0
        }
        
        if !trailDate.isEmpty && trailDate != "0" {
            self.cvvLeadConstant.constant = trailDate.CGFloatValue() ?? 0.0
            backDateTrailConstant.constant = trailDate.CGFloatValue() ?? 0.0
        }
        
        if !topDate.isEmpty && topDate != "0" {
            self.expiryBottomConstant.constant = (self.expiryBottomConstant.constant) + (topDate.CGFloatValue() ?? 0.0)
            self.backDateTopConstant.constant = topDate.CGFloatValue() ?? 0.0
        }
        if !leadCvv.isEmpty && leadCvv != "0" {
            self.cvvLeadConstant.constant = leadCvv.CGFloatValue() ?? 0.0
            backCvvLeadConstant.constant = leadCvv.CGFloatValue() ?? 0.0
        }
        if !TrailCvv.isEmpty && TrailCvv != "0" {
            self.cvvTrailConstant.constant = TrailCvv.CGFloatValue() ?? 0.0
            backCvvTrailConstant.constant = TrailCvv.CGFloatValue() ?? 0.0
        }
       
        if !BottomCvv.isEmpty && bottomDate != "0" {
            self.cvvBottomConstant.constant = BottomCvv.CGFloatValue() ?? 0.0
            backCvvBottomConstant.constant = BottomCvv.CGFloatValue() ?? 0.0
        }
        if !cvvTop.isEmpty && cvvTop != "0" {
            self.cvvBottomConstant.constant =  (self.cvvBottomConstant.constant) + (cvvTop.CGFloatValue() ?? 0.0)
            backCvvtopConstant.constant = cvvTop.CGFloatValue() ?? 0.0
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
    
    private func setDefaultStype(){
        backCardView.backgroundColor = .blueColor
        frontCardView.backgroundColor = .blueColor
        cvvLabel.textColor = .white
        expiryLabel.textColor = .white
        cardNumberLabel.textColor = .white
        nameOnCardLabel.textColor = .white
        backCvvLabel.textColor = .white
        backDateLabel.textColor = .white
        backCardNo.textColor = .white
        setfontValue(font: "EuclidFlex-Medium",fontSize: 14.0)
        backImg = nil
        frontImgView = nil
        isCardMask = false
        isCvvMask = false

    }
    private func setfontValue(font: String,fontSize: Float){
        let size = CGFloat(fontSize)
        
        self.cvvLabel.font = UIFont(name:font, size: size)
        self.expiryLabel.font = UIFont(name:font, size: size)
        self.nameOnCardLabel.font = UIFont(name:font, size: size)
        self.cardNumberLabel.font = UIFont(name:font, size: size)
        
        self.backCvvLabel.font = UIFont(name:font, size: size)
        self.backDateLabel.font = UIFont(name:font, size: size)
        self.backCardNo.font = UIFont(name:font, size: size)
    }
    public func sessionKey(token: String,cardName: String,deviceFinger: String,type: String) {
        styleType = type
        self.cardName = cardName
        self.nameOnCardLabel.text = cardName
        sessionKeyAPI(token: token,deviceFinger: deviceFinger)
    }
    private func setData(){
        if styleType == "Default" {
            nameCardTop.constant = 20
            downImg.image = nil
            cardImg.isHidden = false
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
            expiryLabel.isHidden = false
            backCardImg.isHidden = true
        }else if styleType == "Horizontal" {
            backStripeView.backgroundColor = .black
            downImg.image = UIImage(named: "visa")
            cardImg.isHidden = true
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
            expiryLabel.isHidden = false
            nameCardTop.constant = 20
            backCardImg.isHidden = true
        }else if styleType == "Horizontal Flippable 1" {
            downImg.image = nil
            cardImg.isHidden = true
            cardNumberLabel.isHidden = true
            cvvLabel.isHidden = true
            expiryLabel.isHidden = true
            backCvvLabel.isHidden = false
            backDateLabel.isHidden = false
            backCardNo.isHidden = false
            backCardImg.isHidden = false
            nameCardTop.constant = 20
        }else if styleType == "Vertical Flippable" {
            backStripeView.backgroundColor = .lightGray
            downImg.image = nil
            cardImg.isHidden = false
            cardNumberLabel.isHidden = false
            cvvLabel.isHidden = false
            expiryLabel.isHidden = false
            backCvvLabel.isHidden = true
            backDateLabel.isHidden = true
            backCardNo.isHidden = true
            backCardImg.isHidden = true
            nameCardTop.constant = 20
        }else if styleType == "Horizontal Flippable 2" {
            nameOnCardLabel.isHidden = false
            backStripeView.backgroundColor = .lightGray
            downImg.image = UIImage(named: "mastercard")
            downImg.isHidden = false
            cardImg.isHidden = true
            cardNumberLabel.isHidden = true
            cvvLabel.isHidden = true
            expiryLabel.isHidden = true
            backCvvLabel.isHidden = false
            backDateLabel.isHidden = false
            backCardNo.isHidden = false
            backCardImg.isHidden = false
            nameCardTop.constant = frontCardView.frame.height/2
        }
    }
    @IBAction func onBackCardNoAction(_ sender: Any) {
        if isCardMask {
            if backCardNo.text == "XXXX - XXXX - XXXX - XXXX" {
                backCardNo.text = accountNo
                if let time = UserDefaults.standard.value(forKey: "MaskTime") as? Date{
                }else{
                    let date = Date()
                    
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                backCardNo.text = "XXXX - XXXX - XXXX - XXXX"
            }
        }
    }
    @IBAction func onCvvAction(_ sender: Any) {
        if isCvvMask {
            if backCvvLabel.text == "XXXX" {
                backCvvLabel.text = cvv
                if let time = UserDefaults.standard.value(forKey: "MaskTime") as? Date{
                }else{
                    let date = Date()
                    
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                backCvvLabel.text = "XXXX"
            }
        }
    }
    
    @IBAction func onFrontCardNoAction(_ sender: Any) {
        if isCardMask {
            if cardNumberLabel.text == "XXXX - XXXX - XXXX - XXXX" {
                cardNumberLabel.text = accountNo
                if let time = UserDefaults.standard.value(forKey: "MaskTime") as? Date{
                }else{
                    let date = Date()
                    
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                cardNumberLabel.text = "XXXX - XXXX - XXXX - XXXX"
            }
        }
    }
    @IBAction func onFrontCvvAction(_ sender: Any) {
        if isCvvMask {
            
            if cvvLabel.text == "XXXX" {
                cvvLabel.text = cvv
                if let time = UserDefaults.standard.value(forKey: "MaskTime") as? Date{
                }else{
                    let date = Date()
                    
                    UserDefaults.standard.set(date, forKey: "MaskTime")
                }
            }else{
                cvvLabel.text = "XXXX"
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
extension WidgetCardView  {
    
    private func sessionKeyAPI(token: String,deviceFinger: String){
        let body = [
            "token": token,
            "deviceFingerPrint": deviceFinger
        ] as [String : Any]
        let url = servicesURL.baseUrl.rawValue + servicesURL.sessionKey.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post,istoken: 2).executeQuery(){
            (result: Result<SessionKeyEntity,Error>) in
            switch result{
            case .success(let session):
                self.generalKey = session.generatedKey!
                let data = [
                    "token": token,
                    "deviceFingerPrint": deviceFinger
                ] as [String : Any]
                self.getCardDetails(body: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    func getCardDetails(body: [String : Any]) {
        let url = servicesURL.baseUrl.rawValue + servicesURL.secureCard.rawValue
        ServiceNetworkCall(data: body, url: url, method: .post,istoken: 2).executeQuery(){
            (result: Result<GetCardDetailEntity,Error>) in
            switch result{
            case .success(let getCardDetail):
                self.activityInstance.showIndicator()
                self.decrypt(accountNo: getCardDetail.accountNumber!,cvv: getCardDetail.cvv!,expiry: getCardDetail.expiry!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func decrypt(accountNo: String,cvv: String,expiry: String){
        do {
            let accountNumber = try AESUtils().decrypt(encryptedText: accountNo, key: self.generalKey)
            if isCardMask {
                self.cardNumberLabel.text = "XXXX - XXXX - XXXX - XXXX"
                self.backCardNo.text = "XXXX - XXXX - XXXX - XXXX"
            }else{
                self.cardNumberLabel.text = accountNumber
                self.backCardNo.text = accountNumber
            }
            self.accountNo = accountNumber
            let cvvText = try AESUtils().decrypt(encryptedText: cvv, key: self.generalKey)
            if isCvvMask {
                self.cvvLabel.text = "XXXX"
                self.backCvvLabel.text = "XXXX"
            }else{
                self.cvvLabel.text = cvvText
                self.backCvvLabel.text = cvvText

            }
            self.cvv = cvvText
            let expiryText = try AESUtils().decrypt(encryptedText: expiry, key: self.generalKey)
            self.expiryLabel.text = expiryText
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
