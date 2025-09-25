
import SwiftUI
import Foundation

@main
struct e2nmeNFCApp: App {
    @State private var showClockInModal = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(showClockInModal: $showClockInModal)
                .onOpenURL { url in
                    // Erwartetes Format:
                    // meineapp://e2nmenfc?TAG_ID=<UUID>&SECRET=<STRING>
                    if DeepLinkAuth.authorize(url: url) {
                        showClockInModal = true
                    } else {
                        print("DeepLinkAuth: Ungültige oder nicht autorisierte URL: \(url.absoluteString)")
                    }
                }
        }
    }
}

private struct DeepLinkAuth {
    static func authorize(url: URL) -> Bool {
        guard url.scheme == "meineapp",
              url.host == "e2nmenfc",
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let items = components.queryItems
        else {
            return false
        }
        
        func value(_ name: String) -> String? {
            items.first(where: { $0.name == name })?.value?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        guard let tagId = value("TAG_ID"), !tagId.isEmpty,
              let secret = value("SECRET"), !secret.isEmpty
        else {
            return false
        }
        
        let auth = NFCAuthService()
        let payload = "TAG_ID:\(tagId);SECRET:\(secret)"
        return auth.authorize(textPayload: payload)
    }
}
