//
//  TabbedView.swift
//  Prova
//
//  Created by Simona Mastropietro on 15/11/21.
//

import SwiftUI

struct TabbedView: View {
    @State private var showingList = false
    init() {
      let coloredAppearance = UINavigationBarAppearance()
      coloredAppearance.configureWithOpaqueBackground()
      coloredAppearance.backgroundColor = .systemGray5
      
      UINavigationBar.appearance().standardAppearance = coloredAppearance
      UINavigationBar.appearance().compactAppearance = coloredAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      
      //UINavigationBar.appearance().tintColor = .white
    }
    @AppStorage("ShowOnBoarding") var ShowOnBoarding : Bool = true;
    @AppStorage("Username") var Username : String = "";
    var body: some View {
        
        TabView {
            
            Homepage()
                .tabItem { Text("Overview")
                    Image(systemName: "eye.fill")
                }
            
            //recordingListView(showingList: $showingList)
        Gallery().tabItem { Text("Gallery")
                    Image(systemName: "rectangle.stack")
                }
            
        }.fullScreenCover(isPresented: $ShowOnBoarding, content: {
            Firstpage(ShowOnBoarding: $ShowOnBoarding)
        })
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
