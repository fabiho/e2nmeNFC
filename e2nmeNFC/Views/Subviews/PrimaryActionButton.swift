import SwiftUI

struct PrimaryActionButton: View {
    let isStop: Bool
    let startAction: () -> Void
    let stopAction: () -> Void

    var body: some View {
        Group {
            if isStop {
                Button {
                    stopAction()
                } label: {
                    Image(systemName: "stop.circle")
                    Text("Beenden")
                }
                .tint(.red)
            } else {
                Button {
                    startAction()
                } label: {
                    Image(systemName: "stopwatch")
                    Text("Beginnen")
                }
                .tint(.blue)
                .padding(.horizontal)
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

#Preview("Start") {
    PrimaryActionButton(isStop: false, startAction: {}, stopAction: {})
        .padding()
}

#Preview("Stop") {
    PrimaryActionButton(isStop: true, startAction: {}, stopAction: {})
        .padding()
}
