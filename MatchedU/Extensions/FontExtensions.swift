//
//  FontExtensions.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.
//

import SwiftUI

extension Font{
    enum FontType : Int {
        case Bold = 0
        case Regular
        case semibold
        case medium
        case extraBold
        case lite
    }
    
    static func appFont(type: FontType ,  size : Int)->Font{
         var  fontname = "LeagueSpartan-Bold"
        if type == .semibold{
            fontname = "LeagueSpartan-SemiBold"
        }else
        if type == .lite{
            fontname = "LeagueSpartan-Light"
        }else
        if type == .Regular{
            fontname = "LeagueSpartan-Regular"
        }else
        if type == .medium{
            fontname = "LeagueSpartan-Medium"
        }
        
        return Font.custom(fontname, size: CGFloat(size)) .weight(.bold)
     }
    
    static func app_body_Font(type: FontType ,  size : Int)->Font{
        var  fontname = "Literata-Bold"
        if type == .semibold{
            fontname = "Literata-SemiBold"
        }else
        if type == .lite{
            fontname = "Literata-Light"
        }else
        if type == .Regular{
            fontname = "Literata-Regular"
        }else
        if type == .medium{
            fontname = "Literata-Medium"
        }else
        if type == .Bold{
            fontname = "Literata-Bold"
        }
        
        return Font.custom(fontname, size: CGFloat(size)) .weight(.bold)
     }

}

