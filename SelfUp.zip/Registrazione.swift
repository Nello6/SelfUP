//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = VoiceViewModel()
    
    @State private var showingList = false
    @State private var showingAlert = false
    
    @State private var effect1 = false
    @State private var effect2 = false

    
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("uno"), Color("due")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .frame(width: 450, height: 220)
                .offset(y:-350)
            
            VStack{
                HStack{
                    Text("Self Building")
                        .font(.system(size: 34, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .font(.system(size: 20 , weight : .bold))
                        .multilineTextAlignment(.leading)
                        .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    Button(action: {
                        if vm.isRecording == true {
                            vm.stopRecording()
                        }
                        vm.fetchAllRecording()
                        showingList.toggle()
                    }) {
                        Image(systemName: "waveform")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                    }.sheet(isPresented: $showingList, content: {
                        recordingListView()
                    })
                        .offset(y:50)
                        
                }
                Spacer()
                
                if vm.isRecording {
                    
                    VStack(alignment : .leading , spacing : -5){
                        HStack (spacing : 3) {
                            Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                                .font(.system(size:10))
                                .foregroundColor(.red)
                            Text("Rec")
                        }
                        Text(vm.timer)
                            .font(.system(size:60))
                            .foregroundColor(.black)
                    }
                    
                } else {
                    VStack{
                        Text("Talk about your day")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -190.0)
                            .offset(y: /*@START_MENU_TOKEN@*/-80.0/*@END_MENU_TOKEN@*/)
                        Text("Talking outloud about your day can boost  your self confidence.Describe your day in just 5 minutes")
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .offset(x: /*@START_MENU_TOKEN@*/-50.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-70.0/*@END_MENU_TOKEN@*/)
                    }.frame(width: 300, height: 100, alignment: .center)
                    
                    
                }
                
                Spacer()
                Spacer()
                
                ZStack {
                    
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
                        .scaleEffect(effect2 ? 1 : 0.8)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(1))
                        .onAppear(){
                            self.effect2.toggle()
                        }
                    
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        .scaleEffect(effect2 ? 1 : 1.5)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(2))
                        .onAppear(){
                            self.effect1.toggle()
                        }
                    
                    
                    Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 45))
                        .onTapGesture {
                            if vm.isRecording == true {
                                vm.stopRecording()
                            } else {
                                vm.startRecording()
                                
                            }
                        }
                    
                } .offset(y:-100)
                
                
                
                Spacer()
                
            }
            .padding(.leading,25)
            .padding(.trailing,25)
            .padding(.top , 70)
            
            Circle()
                .frame(width: 350, height: 350)
                .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
                .scaleEffect(effect2 ? 1 : 0.8)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5))
                .offset(x: 160, y: 400)
            
            Circle()
                .frame(width: 350, height: 250)
                .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
                .scaleEffect(effect2 ? 1 : 0.8)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(1))
                .offset(x: 110, y: 400)
            
            
        }
   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
