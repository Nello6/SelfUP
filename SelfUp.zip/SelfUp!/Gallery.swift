//
//  Gallery.swift
//  Prova
//
//  Created by Aniello Ambrosio on 20/11/21.
//

import SwiftUI

struct Gallery: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = VoiceViewModel()
    @StateObject var DraVec = DrawingVec()
    var body: some View {
        
        NavigationView{
            
            ZStack{
                Color("Grigio6")
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(alignment: .leading){
                    
                    Text("Recordings")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.top, 25)
                        .padding(.leading, 20)
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack{
                            ForEach(vm.recordingsList, id: \.createdAt) { recording in
                                
                                
                                ZStack{
                                    
                                    
                                    Rectangle()
                                        .fill(Color("Color"))
                                        .cornerRadius(20)
                                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/6)
                                        .shadow(radius: 6, x: 0, y: 5)
                                    //                                    .padding(.leading, -13)
                                        .padding(.leading, 6)
                                    
                                    
                                    VStack {
                                        
                                        Text("\(Image(systemName: "waveform"))  \(recording.fileURL.lastPathComponent)")
                                            .fontWeight(.regular)
                                            .font(.system(size:20))
                                            .padding(.bottom, 30)
                                            .padding(.leading, -16)
                                        
                                        HStack {
                                            //BOTTONE CESTINO
                                            Button(action: {
                                                vm.deleteRecording(url:recording.fileURL)
                                            }) { Image(systemName:"trash.fill")
                                                    .foregroundColor(.red)
                                                    .font(.system(size:20))
                                                    .padding(.trailing, 160)
                                            }
                                            
                                            //BOTTONE PLAY
                                            
                                            Button(action: {
                                                if recording.isPlaying == true {
                                                    vm.stopPlaying(url: recording.fileURL)
                                                }else{
                                                    vm.startPlaying(url: recording.fileURL)
                                                }
                                            }){
                                                Image(systemName: recording.isPlaying ? "pause.fill" : "play.fill")
                                                    .foregroundColor(.black)
                                                    .font(.system(size:35))
                                           
                                            }
                                            
                                        }
                                        
                                    }
                                }
                                
                            }
                           
                        }
                        
                        .padding()
                        .navigationTitle("Gallery")
                        Spacer()
               
                    }
                    
                }
        
                VStack(alignment: .leading){
                    
                    Text("Drawings")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.top, 25)
                        .padding(.leading, 20)
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack{
                            ForEach(DraVec.Drawing, id: \.self) { dra in
                                VStack{
                                    Image(uiImage: dra)
                                }

                            }
                           
                        }
                        
                        .padding()
                        .navigationTitle("Gallery")
                        Spacer()
               
                    }
                    
                }
                .padding(.top, 260)

          Spacer()
     
                
            }
        }
        
    }
    struct Gallery_Previews: PreviewProvider {
        static var previews: some View {
            Gallery()
        }
    }
}
