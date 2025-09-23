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
    private let nfcService = NFCService()
    
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
                nfcService.scanTag { success in
                    if success {
                        showClockInModal = true
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
    }
}

#Preview("Start") {
    ContentView(showClockInModal: .constant(false))
}

#Preview("Direkt mit Sheet") {
    ContentView(showClockInModal: .constant(true))
}
