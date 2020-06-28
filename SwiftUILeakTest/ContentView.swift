//
//  ContentView.swift
//  SwiftUILeakTest
//
//  Created by Josh on 6/25/20.
//  Copyright © 2020 LiveSurface. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var useTimer: Bool = true
    @State var visible: Bool = true
    @State var values: [Float] = (0...100).map { Float($0) }
    
    let timer = Timer.publish(every: 0.2, on: .current, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            
            Toggle(isOn: $useTimer) {
                Text("Use Timer")
            }
                .fixedSize()
            
            if visible || useTimer == false {
                ScrollView {
                    VStack {
                        ForEach(values.indices) { index in
                            HStack {
                                
                                Text("\(self.values[index])")

//                                Slider(value: self.$values[index], in: 0...100)
//                                    .frame(width: 128)
                                Spacer()
                            }
                        }
                    }
                }
            } else {
                Text("Empty")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onReceive(timer) {_ in
            DispatchQueue.main.async {
                self.visible.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
