//
//  ContentView.swift
//  Survey456
//
//  Created by Michael Field on 9/27/23.
//

import SwiftUI

enum Counter : String, CaseIterable, Identifiable {
    case Catagorical, Exact, Device
    var id : Self { self }
}

struct ContentView: View {
    //    @ObservedObject var delegate : AppDelegate
    @Environment(\.openURL) private var openURL
    
    @State private var selected: Counter = .Device
    @State private var count: UInt = 0
    
    var body: some View {
        VStack {
            Text("Are you counting ticks by?")
                .padding()
            
            Picker("Count Type", selection: $selected) {
                Text("Catagorical").tag(Counter.Catagorical)
                Text("Exact").tag(Counter.Exact)
                Text("Hardware").tag(Counter.Device)
            }.pickerStyle(.segmented)
            
            switch (selected) {
            case Counter.Catagorical:
                Text("Placeholder stuff")
                    .font(.system(size: 36))
                    .padding()
            case Counter.Exact:
                Text("\(count)")
                    .font(.system(size: 36))
                    .padding()
            case Counter.Device:
                Text("\(count)")
                    .font(.system(size: 36))
                    .padding()
                Button("Open Counter App") {
                    getCount()
                }.padding()
            }
        }
        // URL handler for ?count callback
        .onOpenURL { (url) in
            print(url)
            
            guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                  let params = components.queryItems else {
                print("Invalid URL or URL components")
                return
            }
            
            print(components)
            
            if let countString = params.first(where: { $0.name == "count" })?.value,
               let count = UInt(countString) {
                // Now you have the count value, update your state or perform other actions as needed.
                print("Received count: \(count)")
                // TODO: Update your UI with the received count value.
                self.count = count
            }
            
            return
        }
        
    }
    
    func getCount() {
        // Construct your x-callback-url, replacing "myapp" with your actual registered URL scheme, and the path and parameters as needed.
        let countResp = "arcgis-survey123://"
        let urlString = "vantex-health://tc1/?count-cb=\(countResp)"
        
        if let url = URL(string: urlString) {
            openURL(url)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
