//
//  Homepage.swift
//  Prova
//
//  Created by Simona Mastropietro on 14/11/21.
//

import SwiftUI
struct Homepage: View {
    
    var body: some View {
        NavigationView{
        	ScrollView(.vertical, showsIndicators: true){
                ZStack{
                    // Sfondo totale
                    Color("Grigio6")
                        .edgesIgnoringSafeArea(.all)
            	VStack{
                	NavigationLink(destination: Registrazioni()){
                    	CategoryContext(icona: "waveform", nome: "Self Building", Color1: "uno", Color2: "due")
                	}
                	NavigationLink(destination: ContentView()){
                    	CategoryContext(icona: "hand.draw", nome: "Creative Thinking", Color1: "tre", Color2: "due")
                	}
                	NavigationLink(destination: wordCreativity()){
                    	CategoryContext(icona: "brain", nome: "Problem Solving", Color1: "quattro", Color2: "due")
                	}
            	}
            }.navigationTitle("Overview")
        }
        .navigationBarItems(trailing:
            NavigationLink(destination: NotificationListView()){
           
            Text("Reminders  \(Image(systemName: "bell.fill"))")
                .fontWeight(.light)
            
        }
        )
    }
}
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
