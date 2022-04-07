//
//  DrawingPad.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 20.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct DrawingPad: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    @State var imageNames: [String] = ["Drawing1", "Drawing2","Drawing3", "Drawing4"/*,"Drawing5","Drawing6"*/]
    let imagerandom=Int.random(in: 0..<3)
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawings {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            .stroke(self.color, lineWidth: self.lineWidth)
            .background(Image(imageNames[imagerandom]).resizable().scaledToFit())
                .gesture(
                    DragGesture(minimumDistance: 0.1)
                        .onChanged({ (value) in
                            let currentPoint = value.location
                            if currentPoint.y >= 0
                                && currentPoint.y < geometry.size.height {
                                self.currentDrawing.points.append(currentPoint)
                            }
                        })
                        .onEnded({ (value) in
                            self.drawings.append(self.currentDrawing)
                            self.currentDrawing = Drawing()
                        })
            )
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
    }
    
    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
    
}
