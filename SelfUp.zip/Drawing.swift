//
//  Drawing.swift
//  SelfUp!
//
//  Created by Simona Mastropietro on 22/11/21.
//

import SwiftUI
import PencilKit
struct DrawingUI: View {
    var body: some View {
        Home()
    }
}

struct Drawing_Previews: PreviewProvider {
    static var previews: some View {
        DrawingUI()
    }
}

struct Home: View{
    @State var canvas = PKCanvasView()
    
    var body:some View{
        NavigationView{
            DrawingView(canvas:$canvas)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct DrawingView: UIViewRepresentable{
    @Binding var canvas: PKCanvasView
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        return canvas
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
