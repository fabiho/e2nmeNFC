//
//  ContentView.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClockInViewModel()
    @Binding var showClockInModal: Bool
    
    @State private var showNFCErrorAlert = false
    @State private var nfcErrorMessage = "Dieser NFC‑Tag ist nicht autorisiert."
    
    var body: some View {
        VStack(spacing: 30) {
            Image("e2nme")
            
            VStack(spacing: 5) {
                Text("Arbeitszeit")
                    .font(.headline)
                
                Text(viewModel.formattedTime())
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
                    .foregroundStyle(viewModel.isClockInEnabled ? .primary : .tertiary)
            }
            
            Button("Arbeitszeit erfassen") {
                viewModel.startScan { authorized in
                    if authorized {
                        showClockInModal = true
                    } else {
                        nfcErrorMessage = "Deine Arbeitszeit konnte nicht erfasst werden. Versuche es mit einem anderen NFC‑Tag erneut."
                        showNFCErrorAlert = true
                    }
                }
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
        .alert("NFC-Tag ist nicht autorisiert", isPresented: $showNFCErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(nfcErrorMessage)
        }
    }
}

#Preview("Start") {
    ContentView(showClockInModal: .constant(false))
}

#Preview("Direkt mit Sheet") {
    ContentView(showClockInModal: .constant(true))
}

