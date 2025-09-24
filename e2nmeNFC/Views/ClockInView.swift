import SwiftUI

struct ClockInView: View {
    @ObservedObject var viewModel: ClockInViewModel
    @Binding var isPresented: Bool
    let autoCloseDuration: TimeInterval

    @State private var endDate: Date = .now

    init(viewModel: ClockInViewModel, isPresented: Binding<Bool>, autoCloseDuration: TimeInterval = 15) {
        self.viewModel = viewModel
        self._isPresented = isPresented
        self.autoCloseDuration = autoCloseDuration
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.blue.opacity(0.2)
                .ignoresSafeArea()

            VStack(spacing: 25) {
                CloseButton(iconName: "xmark.circle") {
                    isPresented = false
                }
                .padding(.top, 20)

                CountdownProgressView(
                    title: viewModel.isClockInEnabled
                        ? "Möchtest du Deine Arbeitszeit beenden?"
                        : "Möchtest du Deine Arbeitszeit beginnen?",
                    endDate: endDate,
                    duration: autoCloseDuration
                )

                PrimaryActionButton(
                    isStop: viewModel.isClockInEnabled,
                    startAction: {
                        viewModel.startClock()
                        isPresented = false
                    },
                    stopAction: {
                        viewModel.stopClock()
                        isPresented = false
                    }
                )
            }
        }
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
    ClockInView(
        viewModel: ClockInViewModel(),
        isPresented: .constant(true)
    )
    .presentationDetents([.height(230)])
}

#Preview("Ende") {
    let vm: ClockInViewModel = {
        let vm = ClockInViewModel()
        vm.isClockInEnabled = true
        vm.elapsedSeconds = 4523
        return vm
    }()
    return ClockInView(
        viewModel: vm,
        isPresented: .constant(true)
    )
    .presentationDetents([.height(230)])
}
