//
//  RecordingListView.swift
//  Prova
//
//  Created by Simona Mastropietro on 15/11/21.
//

import SwiftUI

struct recordingListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = VoiceViewModel()
    @Binding var showingList: Bool
    
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false){
                ForEach(vm.recordingsList, id: \.createdAt) { recording in
                    
                    VStack{
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color("Color"))
                                .cornerRadius(20)
                                .frame(width: UIScreen.main.bounds.width/1.06, height: UIScreen.main.bounds.height/6)
                                .shadow(radius: 6, x: 0, y: 5)
                                .padding(.horizontal)
                                .padding(.bottom, 6)
                            
                            
                            VStack{
                                
                                
                                // TITOLO
                                Text("\(Image(systemName: "waveform"))  \(recording.fileURL.lastPathComponent)")
                                    .fontWeight(.regular)
                                    .font(.system(size:20))
                                    .padding(.bottom, 20)
                                    .padding(.leading,-130)
                                
                                
                                HStack{
                                    //BOTTONE CESTINO
                                    
                                    Button(action: {
                                        vm.deleteRecording(url:recording.fileURL)
                                    }) { Image(systemName:"trash.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size:20))
                                            .padding(.trailing, 275)
                                        
                                    }
                                    
                                    Button(action: {
                                        if recording.isPlaying == true {
                                            vm.stopPlaying(url: recording.fileURL)
                                        }else{
                                            vm.startPlaying(url: recording.fileURL)
                                        }
                                    }) {
                                        
                                    
                                        
                                        Image(systemName: recording.isPlaying ? "pause.fill" : "play.fill")
                                            .foregroundColor(.black)
                                            .font(.system(size:35))
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                        }
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            .padding(.top, 20)
            .navigationBarTitle("Recordings")
            .navigationBarItems(trailing:
                                    Button(
                                        action: {
                                            showingList.toggle()
                                        },
                                        label: {Text("Done")}))
            
        }
       
    }
    
}


struct recordingListView_Previews: PreviewProvider {
    static var previews: some View {
        recordingListView(showingList: .constant(true))
    }
}
