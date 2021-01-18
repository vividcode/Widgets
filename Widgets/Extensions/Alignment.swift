

import SwiftUI

extension VerticalAlignment {
   private enum TopPinnedView: AlignmentID {
      static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
        return dimensions[VerticalAlignment.top]
      }
   }

    static let topPinnedView = VerticalAlignment(TopPinnedView.self)
}

extension Alignment {
    static let centeredView = Alignment(horizontal: HorizontalAlignment.center,
                          vertical: VerticalAlignment.topPinnedView)
}
