//
//  ContentView.swift
//  Prova
//
//  Created by Simona Mastropietro on 12/11/21.
//

import SwiftUI

struct ColorManager {
    // create static variables for custom colors
    static let Color1 = Color("Color")
    static let Title  = Color("Title")
    static let Title1  = Color("Title1")
    //... add the rest of your colors here
}
extension Color {
    static let Color1 = Color("Color")
    static let Title  = Color("Title")
    static let Title1  = Color("Title1")
    // ... add the rest of your colors here
}

struct Firstpage: View {
    @State private var name = ""
    @State private var gradientColor: [Color]=[.Title,.Title1]
    var body: some View{
        NavigationView {
        VStack {
            ZStack{
                    Image(uiImage: UIImage(named: "Union.png")!)
                    .frame(width: 400, height: 1000)

        Text("Welcome to")
                .multilineTextAlignment(.center)
                .padding(.top)
                .offset(y: -300)
                .font(Font.custom("SFProDisplay-Bold", size: 28))
                .foregroundColor(ColorManager.Title)
                RadialGradient(gradient: Gradient(colors: [Color("Title"), Color("tre1")]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
                    .mask(
                Text("SelfUp!")
//                .foregroundColor(ColorManager.Title)
                .multilineTextAlignment(.center)
                .offset(y: -150)
                .font(.system(size: 64, weight: .bold, design: .default))
                )
                Text("Your soft skills journey begins here")
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(ColorManager.Title)
                .multilineTextAlignment(.center)
                .padding(.top)
                .background(ColorManager.Color1)
                .frame( height:40,alignment: .center)
                .cornerRadius(18)
                .offset(y:90)
                .font(Font.custom("SFProDisplay-Bold", size: 20))
        TextField("Enter your name", text: $name)
                    .background(Color.white)
                    .font(Font.custom("SFProDisplay-Bold", size: 30))
                    .frame(width: 400, height: 40)
                    .cornerRadius(60)
                    .offset(y:140)
                .multilineTextAlignment(.center)
                
                
                    NavigationLink(destination: TabbedView()){
                        Text("Go")
                         
                    }.offset(y:350)
                    .offset(x:150)
                
        }
    }.frame(width: 450, height: 1000)
    .background(ColorManager.Color1)
}
    }
}
struct Firstpage_Previews: PreviewProvider {
    static var previews: some View {
        Firstpage()
    }
}
