//
//  NFCReader.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import Foundation
import CoreNFC
import Combine

final class NFCReader: NSObject, ObservableObject {
    @Published var isAuthorizedLastScan: Bool = false
    
    private let authService: NFCAuthService
    private var session: NFCNDEFReaderSession?
    private var completion: ((Bool) -> Void)?
    
    init(authService: NFCAuthService = NFCAuthService()) {
        self.authService = authService
        super.init()
    }
    
    func startScan(completion: ((Bool) -> Void)? = nil) {
        self.completion = completion
        
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFCReader: NFC ist auf Deinem Gerät nicht verfügbar")
            publish(false)
            completion?(false)
            self.completion = nil
            return
        }
        
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.alertMessage = "Halte Dein iPhone an den NFC-Tag."
        self.session = session
        session.begin()
    }
    
    private func publish(_ authorized: Bool) {
        DispatchQueue.main.async {
            self.isAuthorizedLastScan = authorized
        }
    }
    
    private func decodeTextPayload(_ payload: Data) -> String? {
        guard payload.count >= 1 else { return nil }
        let status = payload[payload.startIndex]
        let isUTF16 = (status & 0x80) != 0
        let langLen = Int(status & 0x3F)
        let textStartIndex = payload.index(payload.startIndex, offsetBy: 1 + langLen)
        guard textStartIndex <= payload.endIndex else { return nil }
        let textData = payload[textStartIndex..<payload.endIndex]
        if isUTF16 {
            return String(data: textData, encoding: .utf16BigEndian) ?? String(data: textData, encoding: .utf8)
        } else {
            return String(data: textData, encoding: .utf8)
        }
    }
}

extension NFCReader: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let nfcError = error as? NFCReaderError,
           nfcError.code == .readerSessionInvalidationErrorUserCanceled {
            print("NFCReader: Session vom Nutzer abgebrochen")
            return
        }
        
        print("NFCReader: Session invalidated: \(error.localizedDescription)")
        publish(false)
        DispatchQueue.main.async { [weak self] in
            self?.completion?(false)
            self?.completion = nil
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var authorized = false
        
        outer: for message in messages {
            for record in message.records {
                guard record.typeNameFormat == .nfcWellKnown,
                      record.type == Data([0x54]) else { continue }
                
                guard let text = decodeTextPayload(record.payload) else {
                    print("NFCReader: Failed to decode text payload")
                    continue
                }
                
                authorized = authService.authorize(textPayload: text)
                break outer
            }
        }
        
        if authorized {
            session.alertMessage = "NFC-Tag akzeptiert."
        } else {
            session.alertMessage = "Dieser NFC-Tag ist nicht autorisiert."
        }
        
        publish(authorized)
        DispatchQueue.main.async { [weak self] in
            self?.completion?(authorized)
            self?.completion = nil
        }
    }
}
