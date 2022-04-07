//
//  DrawingSaveView.swift
//  SelfUp!
//
//  Created by Aniello Ambrosio on 23/11/21.
//

import SwiftUI

struct DrawingSaveView: View {
    @Binding var img : UIImage
    @Binding var name : String
    @Binding var showing : Bool
    var body: some View {
        NavigationView {
            
            ZStack{
                Rectangle().fill(Color(.systemGray6))
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit().padding(.all)
            }
            .navigationBarTitle(name)
            .navigationBarItems(trailing:
                                    Button(
                                        action: {
                                            showing.toggle()
                                        },
                                        label: {Text("Done")}))
            
        }
        }
    }


//struct DrawingSaveView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawingSaveView(img:  Image(uiImage: UIImage(named:"Drawing1")!),name: "ciao")
//    }
//}
