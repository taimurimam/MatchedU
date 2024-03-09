//
//  Utilities.swift
//  MatchedU
//
//  Created by Taimur imam on 20/02/24.
//

import Foundation
import UIKit

class Utilities{
    func resizeImage(image: UIImage) -> UIImage {
        let size = image.size
        
        let widthRatio = 0.3
        let heightRatio =  0.3
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    

        
        // Function to calculate time difference
    func calculateTimeDifference( time: String) -> String{
        // Example usage:

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let date = dateFormatter.date(from: time) ?? Date()
        print(date)
        print(time)
        let now = Date()
        return timeAgoSinceDate(date, currentDate: now)
        
    }
    func timeAgoSinceDate(_ date: Date, currentDate: Date, numericDates: Bool = true) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents([.minute, .hour, .day, .weekOfYear, .month, .year], from: earliest, to: latest)

        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        } else if let year = components.year, year >= 1 {
            return numericDates ? "1 year ago" : "Last year"
        } else if let month = components.month, month >= 2 {
            return "\(month) months ago"
        } else if let month = components.month, month >= 1 {
            return numericDates ? "1 month ago" : "Last month"
        } else if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        } else if let week = components.weekOfYear, week >= 1 {
            return numericDates ? "1 week ago" : "Last week"
        } else if let day = components.day, day >= 2 {
            return "\(day) days ago"
        } else if let day = components.day, day >= 1 {
            return numericDates ? "1 day ago" : "Yesterday"
        } else if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        } else if let hour = components.hour, hour >= 1 {
            return numericDates ? "1 hour ago" : "An hour ago"
        } else if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        } else if let minute = components.minute, minute >= 1 {
            return numericDates ? "1 minute ago" : "A minute ago"
        } else {
            return "Just now"
        }
    }


    
        
}
