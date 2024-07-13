//
//  AppFonts.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import Foundation
import SwiftUI

extension Font {
    static let fontName: String = "MarkerFelt-Thin"
    
    static let regularFontName: String = fontName
    static let boldFontName: String = "\(fontName)Thick"
    
    static let heavyFontName: String = boldFontName
    static let lightFontName: String = regularFontName
    static let mediumFontName: String = boldFontName
    static let semiboldFontName: String = boldFontName
    static let thinFontName: String = regularFontName
    static let ultraLightFontName: String = regularFontName

    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    
    /// Create a font with the title text style.
    public static var title: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    /// Create a font with the headline text style.
    public static var headline: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }
    
    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        return Font.custom(lightFontName, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }
    
    /// Create a font with the body text style.
    public static var body: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    /// Create a font with the callout text style.
    public static var callout: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    
    /// Create a font with the footnote text style.
    public static var footnote: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }
    
    /// Create a font with the caption text style.
    public static var caption: Font {
        return Font.custom(regularFontName, size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }
    
    public static var massive: Font {
        return Font.custom("\(fontName)", size: 200)
    }
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = regularFontName
        switch weight {
        case .bold: font = boldFontName
        case .heavy: font = heavyFontName
        case .light: font = lightFontName
        case .medium: font = mediumFontName
        case .semibold: font = semiboldFontName
        case .thin: font = thinFontName
        case .ultraLight: font = ultraLightFontName
        case .black: font = boldFontName
        default:
            print("Missing font for size \(font)")
        }
        return Font.custom(font, size: size)
    }
}
