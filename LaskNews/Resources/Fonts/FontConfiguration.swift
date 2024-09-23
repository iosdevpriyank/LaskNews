//
//  FontConfiguration.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 19/09/24.
//

import SwiftUI

struct FontConfiguration {
    static let bold = "Inter-Bold"
    static let regular = "Inter-Regular"
    static let semiBold = "Inter-SemiBold"
    static let mRegular = "Merriweather-Regular"
    static let mSemiBold = "Merriweather-Bold"
}

extension Font {
    static func customFont(_ name: String, size: CGFloat) -> Font {
        Font.custom(name, size: .init(size))
    }
    
    static var headingH1: Font {
        customFont(FontConfiguration.bold, size: .init(48))
    }
    
    static var headingH2: Font {
        customFont(FontConfiguration.bold, size: .init(40))
    }
    
    static var headingH3: Font {
        customFont(FontConfiguration.semiBold, size: .init(32))
    }
    
    static var headingH4: Font {
        customFont(FontConfiguration.semiBold, size: .init(24))
    }
    
    static var headingH5: Font {
        customFont(FontConfiguration.semiBold, size: .init(18))
    }
    
    static var body1SemiBold: Font {
        customFont(FontConfiguration.mSemiBold, size: .init(16))
    }
    
    static var body1Regular: Font {
        customFont(FontConfiguration.mRegular, size: .init(16))
    }
    
    static var body2SemiBold: Font {
        customFont(FontConfiguration.semiBold, size: .init(14))
    }
    
    static var body2Regular: Font {
        customFont(FontConfiguration.regular, size: .init(14))
    }
    
    static var button1: Font {
        customFont(FontConfiguration.semiBold, size: .init(16))
    }
    
    static var button2: Font {
        customFont(FontConfiguration.semiBold, size: .init(14))
    }
    
    static var footNoteSemiBold: Font {
        customFont(FontConfiguration.semiBold, size: .init(12))
    }
    
    static var footNoteRegular: Font {
        customFont(FontConfiguration.regular, size: .init(12))
    }
}
