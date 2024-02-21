//
//  String.swift
//  Football
//
//  Created by Sk Azad on 21/07/23.
//

import Foundation
import UIKit

extension String {
    // MARK:- Verify email address is correct format or not.
    var isitValidEmail: Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    var isStudentEmail: Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        var result = emailTest.evaluate(with: self)
        let arr = self.components(separatedBy: ".")
        if arr.last != "edu"{
            result = false
        }
        return result
    }
         //linkedin

    var isValidLinkDinLink : Bool{
        let arr = self.components(separatedBy: ".")
        if arr.contains("linkedin"){
            return isValidURL
        }else{
            return false
        }
    }
    
    var isValidURL: Bool {
           let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
           if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
               // it is a link, if the match covers the whole string
               return match.range.length == self.utf16.count
           } else {
               return false
           }
       }
    // MARK:- Trimming the whitespace from a string and check empty of string
    public var isBlank: Bool
    {
        get
        {
            let trimmed = trimmingCharacters(in: NSCharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    func trimWhiteSpaces() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func requiredHeight(forWidth width: CGFloat, andFont font: UIFont) -> CGFloat
    {
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    func requiredWidth(forHeight height: CGFloat, andFont font: UIFont) -> CGFloat
    {
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.greatestFiniteMagnitude, height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.width
    }
    
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func toDateString(outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
}

