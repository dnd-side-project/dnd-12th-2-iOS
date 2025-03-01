//
//  Font+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 1/28/25.
//

import SwiftUI
import UIKit

extension Font {
    static func pretendard(size: CGFloat, weight: Font.Weight) -> Font {
        let familyName = "Pretendard"
        
        var weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }
        
        return .custom("\(familyName)-\(weightString)", size: size)
    }
}

extension UIFont {
    static func pretendard(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"
        
        var weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }
        
        return UIFont(name: "\(familyName)-\(weightString)", size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
}

struct AlignmentLeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AlignmentTrailing: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct AlignmentCenter: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct HeadingStyle1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 28, weight: .bold), lineHeight: 31)
    }
}

struct HeadingStyle2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 24, weight: .bold), lineHeight: 29)
    }
}

struct HeadingStyle3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 20, weight: .bold), lineHeight: 24)
    }
}

struct HeadingStyle4: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 18, weight: .bold), lineHeight: 22)
    }
}

struct XLargeBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 18, weight: .bold), lineHeight: 25)
    }
}

struct XLargeSemiBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 18, weight: .semibold), lineHeight: 25)
    }
}

struct XLargeMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 18, weight: .medium), lineHeight: 25)
    }
}

struct XLargeRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 18, weight: .regular), lineHeight: 25)
    }
}

struct LargeBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 16, weight: .bold), lineHeight: 24)
    }
}

struct LargeSemiBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
    }
}

struct LargeMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 16, weight: .medium), lineHeight: 24)
    }
}

struct LargeRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 16, weight: .regular), lineHeight: 24)
    }
}

struct MediumBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 14, weight: .bold), lineHeight: 21)
    }
}

struct MediumSemiBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 14, weight: .semibold), lineHeight: 21)
    }
}

struct MediumMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
    }
}

struct MediumRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 14, weight: .regular), lineHeight: 21)
    }
}

struct SmallBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 12, weight: .bold), lineHeight: 14)
    }
}

struct SmallSemiBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 12, weight: .semibold), lineHeight: 14)
    }
}

struct SmallMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 12, weight: .medium), lineHeight: 14)
    }
}

struct SmallRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 12, weight: .regular), lineHeight: 14)
    }
}

struct XSmallBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 10, weight: .bold), lineHeight: 12)
    }
}

struct XSmallSemiBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 10, weight: .semibold), lineHeight: 12)
    }
}

struct XSmallMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 10, weight: .medium), lineHeight: 12)
    }
}

struct XSmallRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendard(size: 10, weight: .regular), lineHeight: 12)
    }
}

extension View {
    
    func alignmentLeading() -> some View {
        modifier(AlignmentLeading())
    }
    
    func alignmentTrailing() -> some View {
        modifier(AlignmentTrailing())
    }
    
    func alignmentCenter() -> some View {
        modifier(AlignmentCenter())
    }
    
    // MARK: - Heading
    
    // Heading1
    func headingStyle1() -> some View {
        modifier(HeadingStyle1())
    }
    
    // Heading2
    func headingStyle2() -> some View {
        modifier(HeadingStyle2())
    }
    
    // Heading3
    func headingStyle3() -> some View {
        modifier(HeadingStyle3())
    }
    
    // Heading4
    func headingStyle4() -> some View {
        modifier(HeadingStyle4())
    }
    
    // MARK: - Body
    
    //XLarge
    func bodyXLargeBold() -> some View {
        modifier(XLargeBold())
    }
    
    func bodyXLargeSemibold() -> some View {
        modifier(XLargeSemiBold())
    }
    
    func bodyXLargeMedium() -> some View {
        modifier(XLargeMedium())
    }
    
    func bodyXLargeRegular() -> some View {
        modifier(XLargeRegular())
    }
    
    // Large
    
    func bodyLargeBold() -> some View {
        modifier(LargeBold())
    }
    
    func bodyLargeSemibold() -> some View {
        modifier(LargeSemiBold())
    }
    
    func bodyLargeMedium() -> some View {
        modifier(LargeMedium())
    }
    
    func bodyLargeRegular() -> some View {
        modifier(LargeRegular())
    }
    
    // Medium
    
    func bodyMediumBold() -> some View {
        modifier(MediumBold())
    }
    
    func bodyMediumSemibold() -> some View {
        modifier(MediumSemiBold())
    }
    
    func bodyMediumMedium() -> some View {
        modifier(MediumMedium())
    }
    
    func bodyMediumRegular() -> some View {
        modifier(MediumRegular())
    }
    
    // Small
    
    func bodySmallBold() -> some View {
        modifier(SmallBold())
    }
    
    func bodySmallSemibold() -> some View {
        modifier(SmallSemiBold())
    }
    
    func bodySmallMedium() -> some View {
        modifier(SmallMedium())
    }
    
    func bodySmallRegular() -> some View {
        modifier(SmallRegular())
    }
    
    // XSmall
    
    func bodyXSmallBold() -> some View {
        modifier(XSmallBold())
    }
    
    func bodyXSmallSemibold() -> some View {
        modifier(XSmallSemiBold())
    }
    
    func bodyXSmallMedium() -> some View {
        modifier(XSmallMedium())
    }
    
    func bodyXSmallRegular() -> some View {
        modifier(XSmallRegular())
    }
}
