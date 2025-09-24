
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClockInViewModel()
    @Binding var showClockInModal: Bool
    
    @State private var showNFCErrorAlert = false
    
    private let unauthorizedAlertTitle = "NFC-Tag ist nicht autorisiert"
    private let unauthorizedAlertMessage = "Deine Arbeitszeit konnte nicht erfasst werden. Versuche es mit einem anderen NFC‑Tag erneut."
    
    var body: some View {
        VStack(spacing: 30) {
            Image("e2nme")
            
            TimeSectionView(
                formattedTime: viewModel.formattedTime(),
                isActive: viewModel.isClockInEnabled
            )
            
            ScanButtonView {
                startNFCScan()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            .padding(.horizontal)
        }
        .sheet(isPresented: $showClockInModal) {
            ClockInView(viewModel: viewModel, isPresented: $showClockInModal)
                .presentationDetents([.height(230)])
        }
        .alert(unauthorizedAlertTitle, isPresented: $showNFCErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(unauthorizedAlertMessage)
        }
    }
    
    private func startNFCScan() {
        viewModel.startScan { authorized in
            handleScanResult(authorized)
        }
    }
    
    private func handleScanResult(_ authorized: Bool) {
        if authorized {
            showClockInModal = true
        } else {
            showNFCErrorAlert = true
        }
    }
}

#Preview("Start") {
    ContentView(showClockInModal: .constant(false))
}

#Preview("Direkt mit Sheet") {
    ContentView(showClockInModal: .constant(true))
}
