//
//  CircleImage.swift
//
//
//  Created by Bryan Souza on 28/08/19.
//

import Foundation
import UIKit
import MaterialComponents

class TextFieldMaterialDesign: MDCTextField {
    
    private var tvMaterialController: MDCTextInputControllerFilled!
    
    private var _mask: String!
    
    @IBInspectable var colorActive: String = "#11C76F" {
        didSet {
            let colorHex = hexStringToUIColor(hex: colorActive)
            tvMaterialController.activeColor = colorHex
            tvMaterialController.floatingPlaceholderActiveColor = colorHex
        }
    }
    
    @IBInspectable var colorDefault: String = "#c9c9c9" {
        didSet {
            let colorHex = hexStringToUIColor(hex: colorDefault)
            tvMaterialController.disabledColor = colorHex
            tvMaterialController.floatingPlaceholderNormalColor = colorHex
        }
    }
    
    @IBInspectable var backgroundColorTextField: String = "#1D1E20" {
        didSet {
            let backgroundColor = hexStringToUIColor(hex: backgroundColorTextField)
            tvMaterialController.borderFillColor = backgroundColor
        }
    }
    
    @IBInspectable public var maskString: String {
        get{
            return _mask
        }
        set{
            _mask = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyColor()
    }
    
    //MARK: Aplicação da Cor no textfield
    public func applyColor(){
        tvMaterialController = MDCTextInputControllerFilled(textInput: self)
        tvMaterialController.inlinePlaceholderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        tvMaterialController.inlinePlaceholderFont = UIFont.init(name: "SFUIText-Bold", size: 16)
        tvMaterialController.textInputFont = UIFont.init(name: "SFUIText-Bold", size: 16)
        tvMaterialController.trailingViewTrailingPaddingConstant()
        self.textColor = .white
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //MARK: Aplicação da Mascara
    /*
     Caractere    Formato
     N            Somente números [0-9]
     C            Caracteres [A-Z] (Somente caixa alta)
     c            Caracteres [a-z] (Somente caixa baixa)
     X            Caracteres [a-Z]
     U            Caracteres + números [A-Z] + [0-9] (Somente caixa alta)
     u            Caracteres + números [a-z] + [0-9] (Somente caixa baixa)
     %            Caracteres + números [a-Z] + [0-9]
     *            Qualquer caractere (Incluindo os especiais)
     */
    
    public func applyFilter(textField: UITextField){
        if let _mask = _mask{
            var index = _mask.startIndex
            var textWithMask:String = ""
            var i:Int = 0
            var text:String = textField.text!
            
            if (text.isEmpty){
                return
            }
            
            text = removeMaskCharacters(text: text, withMask: maskString)
            
            while(index != maskString.endIndex){
                
                if(i >= text.count){
                    self.text = textWithMask
                    break
                }
                
                if("\(maskString[index])" == "N"){ //Only number
                    if (!isNumber(textToValidate: text[i])){
                        break
                    }
                    textWithMask = textWithMask + text[i]
                    i += 1
                }else if("\(maskString[index])" == "C"){ //Only Characters A-Z, Upper case only
                    if(hasSpecialCharacter(searchTerm: text[i])){
                        break
                    }
                    
                    if (isNumber(textToValidate: text[i])){
                        break
                    }
                    //textWithMask = textWithMask + text[i].uppercased()
                    i += 1
                }else if("\(maskString[index])" == "c"){ //Only Characters a-z, lower case only
                    if(hasSpecialCharacter(searchTerm: text[i])){
                        break
                    }
                    
                    if (isNumber(textToValidate: text[i])){
                        break
                    }
                    //textWithMask = textWithMask + text[i].lowercased()
                    i += 1
                }else if("\(maskString[index])" == "X"){ //Only Characters a-Z
                    if(hasSpecialCharacter(searchTerm: text[i])){
                        break
                    }
                    
                    if (isNumber(textToValidate: text[i])){
                        break
                    }
                    textWithMask = textWithMask + text[i]
                    i += 1
                }else if("\(maskString[index])" == "%"){ //Characters a-Z + Numbers
                    if(hasSpecialCharacter(searchTerm: text[i])){
                        break
                    }
                    textWithMask = textWithMask + text[i]
                    i += 1
                }else if("\(maskString[index])" == "U"){ //Only Characters A-Z + Numbers, Upper case only
                    if(hasSpecialCharacter(searchTerm: text[i])){
                        break
                    }
                    
                    //textWithMask = textWithMask + text[i].uppercased()
                    i += 1
                }else if("\(maskString[index])" == "u"){ //Only Characters a-z + Numbers, lower case only
                    if(hasSpecialCharacter(searchTerm: text[i])){
                        break
                    }
                    
                    //textWithMask = textWithMask + text[i].lowercased()
                    i += 1
                }else if("\(maskString[index])" == "*"){ //Any Character
                    textWithMask = textWithMask + text[i]
                    i += 1
                }else{
                    textWithMask = textWithMask + "\(maskString[index])"
                }
                
                index = _mask.index(after: index)
            }
            
            self.text = textWithMask
        }
        
    }
    
    public func isNumber(textToValidate:String) -> Bool{
        
        let num = Int(textToValidate)
        
        if num != nil {
            return true
        }
        
        return false
    }
    
    public func hasSpecialCharacter(searchTerm:String) -> Bool{
        let regex = try!  NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        
        if regex.firstMatch(in: searchTerm, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, searchTerm.count)) != nil {
            return true
        }
        
        return false
    }
    
    public func removeMaskCharacters( text: String, withMask mask:String) -> String{
        
        var mask = mask
        var text = text
        mask = mask.replacingOccurrences(of: "X", with: "")
        mask = mask.replacingOccurrences(of: "N", with: "")
        mask = mask.replacingOccurrences(of: "C", with: "")
        mask = mask.replacingOccurrences(of: "c", with: "")
        mask = mask.replacingOccurrences(of: "U", with: "")
        mask = mask.replacingOccurrences(of: "u", with: "")
        mask = mask.replacingOccurrences(of: "*", with: "")
        
        var index = mask.startIndex
        
        while(index != mask.endIndex){
            text = text.replacingOccurrences(of: "\(mask[index])", with: "")
            index = mask.index(after: index)
        }
        
        return text
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(), context: nil)
        
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        //print("textFieldDidChange")
        applyFilter(textField: textField)
    }
    
}

extension TextFieldMaterialDesign {
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    }
}
