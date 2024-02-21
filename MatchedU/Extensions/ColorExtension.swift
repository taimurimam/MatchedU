//
//  ColorExtension.swift
//  THE WiLL
//
//  Created by Taimur imam on 04/09/23.

import SwiftUI

extension Color {
  //  rgba(216, 216, 216, 1)
   // rgba(133, 133, 133, 1)
    public static var text_secondary_color: Color {
        return  Color(UIColor(red: 133/255, green: 133/255, blue: 133/255, alpha: 1.0))
    }

    public static var button_shado: Color {
        return  Color(UIColor(red: 100/255, green: 137/255, blue: 185/255, alpha: 0.4))
    }

    public static var primary_color: Color {
        return  Color(UIColor(red: 125/255, green: 160/255, blue: 207/255, alpha: 1.0))
    }
    public static var background_gradient_top: Color {
        return  Color(UIColor(red: 191/255, green: 210/255, blue: 239/255, alpha: 1.0))
    }
    
    public static var app_blue: Color {
        return  Color(UIColor(red: 125/255, green: 160/255, blue: 207/255, alpha: 1.0))
    }
    public static var toss_background: Color {
        return  Color(UIColor(red: 153/255, green: 25/255, blue: 0/255, alpha: 1.0))
    }

    public static var placeholder: Color {
        return  Color(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0))
    }
    
    public static var inactive_border: Color {
        return  Color(UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0))
    }
    
    public static var off_white: Color {
        return  Color(UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0))
    }
    
    
    public static var app_white: Color {
        return  Color(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0))
    }
    
    public static var app_black: Color {
        return  Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0))
    }
    

    
}
