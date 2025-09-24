
import SwiftUI

struct TimeSectionView: View {
    let formattedTime: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Arbeitszeit")
                .font(.headline)
            
            Text(formattedTime)
                .font(.system(size: 36, weight: .bold, design: .monospaced))
                .foregroundStyle(isActive ? .primary : .tertiary)
        }
    }
}

#Preview {
    VStack {
        TimeSectionView(formattedTime: "00:12:34", isActive: true)
        TimeSectionView(formattedTime: "00:00:00", isActive: false)
    }
    .padding()
}
