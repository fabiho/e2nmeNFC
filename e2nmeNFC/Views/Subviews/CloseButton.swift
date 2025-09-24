import SwiftUI

struct CloseButton: View {
    let iconName: String
    let action: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Image(systemName: iconName)
                    .font(.system(size: 25))
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    CloseButton(iconName: "xmark.circle") { }
        .padding()
        .background(Color.blue.opacity(0.2))
}
