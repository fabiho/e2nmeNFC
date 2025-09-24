import SwiftUI

struct CountdownProgressView: View {
    let title: String
    let endDate: Date
    let duration: TimeInterval

    var body: some View {
        TimelineView(.animation) { context in
            let remaining = max(0, endDate.timeIntervalSince(context.date))
            let progress = max(0, min(1, 1 - remaining / duration))

            VStack(spacing: 10) {
                Text(title)
                    .font(.headline)

                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                    .tint(.blue)
                    .padding(.horizontal)

                Text("In \(Int(ceil(remaining)))s erneut scannen")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    CountdownProgressView(
        title: "Möchtest du Deine Arbeitszeit beginnen?",
        endDate: .now.addingTimeInterval(15),
        duration: 15
    )
    .padding()
}
