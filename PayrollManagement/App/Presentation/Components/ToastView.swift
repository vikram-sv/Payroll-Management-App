import SwiftUI

struct ToastView: View {

    let message: String

    var body: some View {
        Text(message)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.black.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal, 20)
    }
}