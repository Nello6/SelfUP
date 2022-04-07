//
//  ContentView.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 20.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State private var currentDrawing: Drawing = Drawing()
//    @State private var drawings: [Drawing] = [Drawing]()
//    @State private var color: Color = Color.black
//    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
            VStack(alignment: .center) {
//            DrawingPad(currentDrawing: $currentDrawing,
//                       drawings: $drawings,
//                       color: $color,
//                       lineWidth: $lineWidth)
//            DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth)
                VStack{
                    Home1()
                }//.frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/2).lineLimit(1)
            }.navigationTitle("Creative Thinking")
    }
}
