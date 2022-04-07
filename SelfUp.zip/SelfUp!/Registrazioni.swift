//
//  Registrazioni.swift
//  Prova
//
//  Created by Simona Mastropietro on 15/11/21.
//

import SwiftUI

struct Registrazioni: View {
    @ObservedObject var vm = VoiceViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showingList = false
    @State private var showingAlert = false
    
    @State private var effect1 = false
    @State private var effect2 = false
    
    var body: some View {
        
        ZStack{
            // Sfondo totale
            Color("Grigio6")
                .edgesIgnoringSafeArea(.all)
            
        VStack(){
            if vm.isRecording {
                
                VStack(alignment: .leading){ //CIRCLE + RECORDING + TIMER
                    
                    HStack (spacing:4) {
                        Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                            .font(.system(size:10))
                            .foregroundColor(.red)
                        Text("Recording")
                    }.padding(.top,290)
                    Text(vm.timer)
                        .font(.system(size:60))
                        .foregroundColor(.black)
                }
    
                
            } else {
                    Text("Talk about your day")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.trailing,200)
                        .padding(.top)
                
                
//                    .padding(.trailing, 16)
              
    
            }
            Spacer()
          
        
            Button(action: {
                if vm.isRecording == true {
                    vm.stopRecording()
                    vm.fetchAllRecording()
                    showingList.toggle()
                } else {
                    vm.startRecording()
                }

            }) {
                Image(systemName: vm.isRecording ? "stop.circle" : "record.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 60))
                
            }.padding(.bottom,270)
            
            .sheet(isPresented: $showingList, content: {
                recordingListView(showingList: $showingList)
            })
        
            
        }
        }
  
        

        .navigationTitle("Self Building")
//        .edgesIgnoringSafeArea(.bottom)
        // Hide the system back button
        .navigationBarBackButtonHidden(true)
        // Add your custom back button here
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                Text("Overview")
            }
        })
    }
}

struct Registrazioni_Previews: PreviewProvider {
    static var previews: some View {
        Registrazioni()
    }
}
