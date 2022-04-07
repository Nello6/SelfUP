//
//  NotificationListView.swift
//  LocalNotificationsYouTube
//
//  Created by James Haville on 02/05/2021.
//

import SwiftUI

struct NotificationListView: View {
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
                Text("No Reminders Yet")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
//                InfoOverlayView(
//                    infoMessage: "No Notifications Yet",
//                    buttonTitle: "Create",
//                    systemImageName: "plus.circle",
//                    action: {
//                        isCreatePresented = true
//                    }
//                ) .padding(.bottom, -100)
            }
        case .denied:
            InfoOverlayView(
                infoMessage: "Please Enable Notification Permission In Settings",
                buttonTitle: "Settings",
                systemImageName: "gear",
                action: {
                    if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            )
        default:
            EmptyView()
        }
    }
    
    var body: some View {
        //        NavigationView{
        
        VStack{
        List {
            ForEach(notificationManager.notifications, id: \.identifier) { notification in
    
                HStack {
                    Text(notification.content.body)
                        .fontWeight(.semibold)
                    Text(timeDisplayText(from: notification))
                        .fontWeight(.bold)
                    Spacer()
                
                }
            }
            .onDelete(perform: delete)
        
        }.padding(.top,8)
        .listStyle(InsetGroupedListStyle())
        .overlay(infoOverlayView)
        }.background(Color("Grigio6"))
        
        
//        .navigationTitle("Notifications")
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
            .navigationBarTitle("Reminders")
            .navigationBarItems(trailing: Button {
                isCreatePresented = true
            } label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .offset(y:10)
    //                .foregroundColor(.red)
            })
            .sheet(isPresented: $isCreatePresented) {
                NavigationView {
                    CreateNotificationView(
                        notificationManager: notificationManager,
                        isPresented: $isCreatePresented
                    )
                }
                .accentColor(.primary)
     

            }  .padding(.bottom, 50)
        } //Se cierra NavigationView
     //Se cierra SomeView
}

extension NotificationListView {
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(
            identifiers: indexSet.map { notificationManager.notifications[$0].identifier }
        )
        notificationManager.reloadLocalNotifications()
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}

