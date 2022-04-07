//
//  Firstpage.swift
//  Prova
//
//  Created by Simona Mastropietro on 15/11/21.
//

import SwiftUI

struct Firstpage: View {
    
    @Binding public var ShowOnBoarding : Bool
//    -------------------------------------------------------------------------------------
    //            -------------NOTIFICATIONS---------
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(
            identifiers: indexSet.map { notificationManager.notifications[$0].identifier }
        )
        notificationManager.reloadLocalNotifications()
    }
    
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
    var infoOverlayView: some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if notificationManager.notifications.isEmpty {
            }
        case .denied:
            if notificationManager.notifications.isEmpty {
            }
        default:
            EmptyView()
        }
    }
    
    
//    -------------------------------------------------------------------------------------
    var body: some View{
        ZStack{
            Image(uiImage: UIImage(named: "Union.png")!).resizable().scaledToFill()
            
                VStack{
            Text("Welcome to")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Title"))
                .padding()
                    RadialGradient(gradient: Gradient(colors: [Color("Title"), Color("tre1")]), center: .center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500)
                        .mask(
                            Text("SelfUp")
                                .font(.system(size: 64, weight: .bold, design: .default))
                                .padding(.trailing)
                        ).frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/8)
            Text("Your soft skills journey begins here")
                .font(.body)
                .fontWeight(.light)
                .foregroundColor(Color("Title"))
            .multilineTextAlignment(.center)
            
            .frame( height:40,alignment: .center)
            .cornerRadius(18)
            
            Button(action: {
                ShowOnBoarding.toggle()
                }, label: {
                    Text("Let's Start!")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Title"))
                }
            ).padding(.top, UIScreen.main.bounds.height/8)
                        
                        
                        
                        
                        
                
            
            
                
                
            
        }
}.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color("Color"))
        
//-------------------------------------------------------------------------------
        //            -------------NOTIFICATIONS---------
                            .frame(width: 450, height: 1000)
                                .background(Color("Color"))
                                .overlay(infoOverlayView)
         
                                .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                                .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
                                    switch authorizationStatus {
                                    case .notDetermined:
                                        notificationManager.requestAuthorization()
                                    case .authorized:
                                        notificationManager.reloadLocalNotifications()
                                    default:
                                        break
                                    }
                                }
                                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                                    notificationManager.reloadAuthorizationStatus()
                                }

                                .sheet(isPresented: $isCreatePresented) {
                                    NavigationView {
                                        CreateNotificationView(
                                            notificationManager: notificationManager,
                                            isPresented: $isCreatePresented
                                        )
                                    }
                                    .accentColor(.primary)
                                }
            //       -------------NOTIFICATIONS---------
//        ------------------------------------------------------------------------------
        
    
        }
    }


struct Firstpage_Previews: PreviewProvider {
    static var previews: some View {
        Firstpage(ShowOnBoarding: .constant(true))
    }
}
