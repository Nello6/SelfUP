//
//  CategoryContext.swift
//  Prova
//
//  Created by Aniello Ambrosio on 18/11/21.
//

import SwiftUI

struct CategoryContext: View {
    
    let icona: String
    let nome: String
    let Color1: String
    let Color2: String
    
    var body: some View {
        
            ZStack(alignment: .topLeading){
    			Rectangle()
                	.fill(LinearGradient(gradient: Gradient(colors: [Color(Color1), Color(Color2)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .frame(width: .infinity, height: UIScreen.main.bounds.height / 4.6)
        			.cornerRadius(20)
                    .shadow(radius: 6, x: 0, y: 5)
        			.padding(.horizontal)
        			.padding(.top)
                VStack(alignment: .leading){
            		Image(systemName: icona)
                		.resizable()
                		.aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                		.foregroundColor(.white)
                		.padding(.top,36)
                		.padding(.leading,36)
                    Spacer()
                    HStack{
                        Text(nome)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 20)
                            .padding(.leading, 20)
                            Spacer()
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                    }.padding(.horizontal)
                }
            }
        
    }
}

//struct CategoryContext_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryContext()
//    }
//}
