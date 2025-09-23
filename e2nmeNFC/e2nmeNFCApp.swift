//
//  e2nmeNFCApp.swift
//  e2nmeNFC
//
//  Created by Fabian Hofer on 22.09.25.
//

import SwiftUI

@main
struct e2nmeNFCApp: App {
    @State private var showClockInModal = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(showClockInModal: $showClockInModal)
                .onOpenURL { url in
                    // meineapp://e2nmenfc
                    if url.host == "e2nmenfc" {
                        showClockInModal = true
                    }
                }
        }
    }
}
