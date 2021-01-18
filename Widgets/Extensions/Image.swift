

import Foundation
import SwiftUI

extension Image
{
    static var placeHolder: AnyView
    {
        return AnyView(
            Image(systemName: "play.circle.fill")
            .resizable()
            .renderingMode(.template)
            .foregroundColor((Color.placeholderForegroundTint))
            .background(Color.placeholderBackgroundTint)
            .aspectRatio(contentMode: .fill)
        )
    }
}
