//
//  NFCService.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import Foundation
import CoreNFC

class NFCService: NSObject, NFCNDEFReaderSessionDelegate {
    private var completion: ((Bool) -> Void)?
    private var session: NFCNDEFReaderSession?
    
    func scanTag(completion: @escaping (Bool) -> Void) {
        self.completion = completion
        
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC nicht verfügbar")
            completion(false)
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Halte dein iPhone an den NFC-Tag."
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC Session Fehler: \(error.localizedDescription)")
        completion?(false)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("NFC Tag erkannt ✅")
        completion?(true)
    }
}
