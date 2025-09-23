//
//  ClockInViewModel.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import SwiftUI
import Combine

class ClockInViewModel: ObservableObject {
    @Published var isClockInEnabled: Bool = false
    @Published var elapsedSeconds: Int = 0
    
    private var timer: AnyCancellable?
    private let nfcReader = NFCReader()
    
    func startClock() {
        guard !isClockInEnabled else { return }
        isClockInEnabled = true
        elapsedSeconds = 0
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.elapsedSeconds += 1
            }
    }
    
    func stopClock() {
        isClockInEnabled = false
        timer?.cancel()
        timer = nil
        elapsedSeconds = 0
    }
    
    func formattedTime() -> String {
        let hours = elapsedSeconds / 3600
        let minutes = (elapsedSeconds % 3600) / 60
        let seconds = elapsedSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func startScan(onResult: @escaping (Bool) -> Void) {
        nfcReader.startScan { authorized in
            onResult(authorized)
        }
    }
}
