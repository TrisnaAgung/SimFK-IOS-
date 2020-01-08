//
//  ClassTextFieldSizeClass.swift
//  Absensi
//
//  Created by Unit TSI on 17/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import Foundation
import UIKit

class ClassTextFieldSizeClass: UITextField {
    
    @IBInspectable var DynamicFontSize: CGFloat = 0 {
        didSet {
            overrideFontSize(FontSize: DynamicFontSize)
        }
    }
    
    func overrideFontSize(FontSize: CGFloat){
        let fontName = self.font?.fontName
        let screenWidth = UIScreen.main.bounds.size.width
        let calculatedFontSize = screenWidth / 375 * FontSize
        self.font = UIFont(name: fontName!, size: calculatedFontSize)
    }
}
