//
//  NFCAuthService.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import Foundation

struct NFCAuthService {
    private let whitelist: Set<String> = [
        "3F5E9C2C8B1C4D1A9C502A1F1B0D1A77",
        "B8A1E6E02D544F9A8D4E8E16C4C9F3C2"
    ]
    
    private let staticSecret: String = "D123"
    
    // "TAG_ID:<UUID>;SECRET:<STRING>"
    func parsePayload(_ text: String) -> (tagId: String, secret: String)? {
        let pairs = text.split(separator: ";")
        var dict: [String: String] = [:]
        
        for pair in pairs {
            guard let colonIndex = pair.firstIndex(of: ":") else {
                print("NFCAuthService: Missing ':' in segment \(pair)")
                continue
            }
            let key = String(pair[..<colonIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
            let value = String(pair[pair.index(after: colonIndex)...]).trimmingCharacters(in: .whitespacesAndNewlines)
            dict[key] = value
        }
        
        guard let tagId = dict["TAG_ID"], !tagId.isEmpty else {
            print("NFCAuthService: TAG_ID missing or empty")
            return nil
        }
        guard let secret = dict["SECRET"], !secret.isEmpty else {
            print("NFCAuthService: SECRET missing or empty")
            return nil
        }
        
        return (tagId, secret)
    }
    
    func authorize(textPayload: String) -> Bool {
        guard let (tagId, secret) = parsePayload(textPayload) else {
            return false
        }
        let allowed = whitelist.contains(tagId) && (secret == staticSecret)
        if !allowed {
            print("NFCAuthService: Authorization failed for tagId=\(tagId)")
        }
        return allowed
    }
}

