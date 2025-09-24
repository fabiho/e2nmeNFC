
import SwiftUI

struct ClockInView: View {
    @ObservedObject var viewModel: ClockInViewModel
    @Binding var isPresented: Bool
    
    private let autoCloseDuration: TimeInterval = 15
    @State private var endDate: Date = .now
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.blue.opacity(0.2)
            
            VStack(spacing: 25) {
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 25))
                    }
                    .padding(.trailing)
                }
                .padding(.top, 20)
                
                TimelineView(.animation) { context in
                    let remaining = max(0, endDate.timeIntervalSince(context.date))
                    let progress = max(0, min(1, 1 - remaining / autoCloseDuration))
                    
                    VStack(spacing: 10) {
                        Text(viewModel.isClockInEnabled
                             ? "Möchtest du Deine Arbeitszeit beenden?"
                             : "Möchtest du Deine Arbeitszeit beginnen?")
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
                
                if viewModel.isClockInEnabled {
                    Button {
                        viewModel.stopClock()
                        isPresented = false
                    } label: {
                        Image(systemName: "stop.circle")
                        Text("Beenden")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.red)
                } else {
                    Button {
                        viewModel.startClock()
                        isPresented = false
                    } label: {
                        Image(systemName: "stopwatch")
                        Text("Beginnen")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.blue)
                    .padding(.horizontal)
                }
            }
        }
        .ignoresSafeArea()
        .task(id: isPresented) {
            guard isPresented else { return }
            await MainActor.run {
                endDate = .now.addingTimeInterval(autoCloseDuration)
            }
            try? await Task.sleep(for: .seconds(autoCloseDuration))
            await MainActor.run {
                if isPresented {
                    isPresented = false
                }
            }
        }
    }
}

#Preview("Beginnen") {
    struct PreviewHost: View {
        @State var presented = true
        var body: some View {
            ClockInView(viewModel: ClockInViewModel(), isPresented: $presented)
        }
    }
    return PreviewHost()
}

#Preview("Ende") {
    struct PreviewHost: View {
        @State var presented = true
        let vm: ClockInViewModel = {
            let vm = ClockInViewModel()
            vm.isClockInEnabled = true
            vm.elapsedSeconds = 4523
            return vm
        }()
        var body: some View {
            ClockInView(viewModel: vm, isPresented: $presented)
        }
    }
    return PreviewHost()
}
