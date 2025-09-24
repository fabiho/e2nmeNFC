//
//  ClockInViewModel.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import SwiftUI
import Combine

protocol NFCScanning {
    func startScan(completion: ((Bool) -> Void)?)
}

extension NFCReader: NFCScanning {}

@MainActor
final class ClockInViewModel: ObservableObject {
    @Published var isClockInEnabled: Bool = false
    @Published var elapsedSeconds: Int = 0
    
    private var timer: AnyCancellable?
    private let nfcReader: NFCScanning
    
    init(nfcReader: NFCScanning = NFCReader()) {
        self.nfcReader = nfcReader
    }
    
    deinit {
        timer?.cancel()
    }
    
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
        let time = TimeInterval(elapsedSeconds)
        return Self.timeFormatter.string(from: time) ?? "00:00:00"
    }
    
    private static let timeFormatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.allowedUnits = [.hour, .minute, .second]
        f.unitsStyle = .positional
        f.zeroFormattingBehavior = [.pad]
        return f
    }()
    
    func startScan(onResult: @escaping (Bool) -> Void) {
        nfcReader.startScan { authorized in
            onResult(authorized)
        }
    }
}
