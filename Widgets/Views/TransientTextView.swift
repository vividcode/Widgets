

import SwiftUI

typealias DisappearanceClosure = ()->Void

struct TransientTextView: View {
    var message: String
    var disappearClosure: DisappearanceClosure?

    var body: some View {
        Text(self.message)
            .background(Color.messageBackgroundColor)
            .foregroundColor(Color.messageForegroundColor)
            .font(.subheadline)
            .padding(8)
            .border(Color.messageBackgroundColor, width: 8)
            .cornerRadius(8.0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.disappearClosure?()
                }
            }
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
    }
}
