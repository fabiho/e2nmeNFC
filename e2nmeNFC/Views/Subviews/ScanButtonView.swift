
import SwiftUI

struct ScanButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button("Arbeitszeit erfassen") {
            action()
        }
    }
}

#Preview {
    ScanButtonView {
        print("Scan tapped")
    }
    .buttonStyle(.borderedProminent)
    .controlSize(.large)
    .tint(.blue)
    .padding()
}
