//
//  disegno.swift
//  SelfUp!
//
//  Created by Simona Mastropietro on 22/11/21.
//

import SwiftUI
import PencilKit
struct disegno: View {
    var body: some View {
        Home1()
    }
}

struct disegno_Previews: PreviewProvider {
    static var previews: some View {
        disegno()
    }
}

struct Home1: View{
    @State var showing = false
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    @State var type: PKInkingTool.InkType = .pencil
    @State var colorPicker=false
    @State var imageNames: [String] = ["Drawing1", "Drawing2","Drawing3", "Drawing4"]
    @State var imm: UIImage = UIImage(named: "Drawing1")!
    @ObservedObject var DrawVec = DrawingVec()
    @State var name = ""
    let imagerandom=Int.random(in: 0..<3)
    var body:some View{
        VStack{
            ZStack{
                Image(imageNames[imagerandom]).resizable().scaledToFill()
                DrawingUiView(canvas:$canvas, isDraw: $isDraw,type:$type,color:$color)
                
            }
            .navigationBarItems(trailing: Button(action: {
              imm = SaveImage(img: imageNames[imagerandom])
                DrawVec.Drawing.append(imm)
                showing.toggle()
                if(name.isEmpty){
                    name="Unamed Opera"
                }
            }, label: {
                
                Text("Save")
                
            }))
            HStack{
            Menu {
                Button(action: {
                    colorPicker.toggle()
                }) {
                    Label {
                    Text("Color")
                } icon: {
                    Image(systemName: "eyedropper.full")
                }

            }

                Button(action: {
                    isDraw=true
                    type = .pencil
                }) {
                    Label {
                    Text("Pencil")
                } icon: {
                    Image(systemName: "pencil")
                }

            }
                Button(action: {
                    isDraw=true
                    type = .pen
                }) {
                    Label {
                    Text("Pen")
                } icon: {
                    Image(systemName: "pencil")
                }

            }
                Button(action: {
                    isDraw.toggle()
                }) {
                    Label {
                    Text("Eraser")
                } icon: {
                    Image(systemName: "pencil.slash")
                }

            }
                
                Button(action: {
                    isDraw=true
                    type = .marker
                }) {
                    Label {
                    Text("Marker")
                } icon: {
                    Image(systemName: "highlighter")
                }

            }

                } label: {
                Image(systemName:"pencil.tip.crop.circle")
                }.sheet(isPresented: $colorPicker){
                ColorPicker("Pick Color", selection: $color)
                        .padding()
            }
                TextField("Name your opera", text: $name)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 340, alignment: .leading)
                    .textFieldStyle(.roundedBorder)
                    
            }.padding(.all)

        }.sheet(isPresented: $showing, onDismiss:{
            showing=false
            
        }, content: {DrawingSaveView(img: $imm, name: $name,showing: $showing)
            
        })
    }
    func SaveImage(img : String) -> UIImage{
        
        let topimage = canvas.drawing.image(from:canvas.drawing.bounds, scale: 1)
        let bottomImage = UIImage(named: img)
        
        return bottomImage!.mergeImage(with: topimage)
        
    }
}
 
extension UIImage {

    func mergeImage(with secondImage: UIImage, point: CGPoint? = nil) -> UIImage {

        let firstImage = self
        let newImageWidth = max(firstImage.size.width, secondImage.size.width)
        let newImageHeight = max(firstImage.size.height, secondImage.size.height)
        let newImageSize = CGSize(width: newImageWidth, height: newImageHeight)

        UIGraphicsBeginImageContextWithOptions(newImageSize, false, 1)

        let firstImagePoint = CGPoint(x: round((newImageSize.width - firstImage.size.width) / 4),
                                      y: round((newImageSize.height - firstImage.size.height) / 4))

        let secondImagePoint = point ?? CGPoint(x: round((newImageSize.width - secondImage.size.width) / 2),
                                                y: round((newImageSize.height - secondImage.size.height) / 2))

        firstImage.draw(at: firstImagePoint)
        secondImage.draw(at: secondImagePoint)

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image ?? self
    }
}

struct DrawingUiView: UIViewRepresentable{
    @Binding var canvas: PKCanvasView
    @Binding var isDraw : Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color: Color
    var ink : PKInkingTool{
        PKInkingTool(type,color: UIColor(color))
    }
    let eraser = PKEraserTool(.bitmap)
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.isOpaque = false
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink: eraser
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDraw ? ink : eraser
    }
}

/* Button(action: {
    isDraw.toggle()

}){
    Image(systemName: "pencil.slash")
        .font(.title)
}*/
