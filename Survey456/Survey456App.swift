//
//  Survey456App.swift
//  Survey456
//
//  Created by Michael Field on 9/27/23.
//

import SwiftUI

@main
struct Survey456App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { (url) in
                    print(url)
                    
                    guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                          let _ = components.queryItems else {
                        print("Invalid URL or URL components")
                        return
                    }
                    
                    return
                }
            
        }
    }
}
