//
//  AffichageStationSwiftUIView.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 8/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

//
//  AffichageStationSwiftUIView.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 8/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import SwiftUI
import UIKit
import UserNotifications




class HostingSwiftUIView: UIHostingController<AffichageStationSwiftUIView>{
    required init?(coder aDecoder : NSCoder ) {
        super.init(coder: aDecoder,  rootView :AffichageStationSwiftUIView() )
    }
}




struct AffichageStationSwiftUIView: View {
 
    

    @ObservedObject var viewModel = StationViewModel()
    @State var searchQuery = ""
  
    var body: some View {
        NavigationView {
          
            /*
            ZStack {
        
                
                Button(action: {
                    self.send()
                }){
                    Text("ihiohoohihiohh")
                } }*/
            
            ZStack{
                
                
                Image("Image v14")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                
                /*
                 HStack (spacing: 15){
                 Image(systemName: "magnifyingglass")
                 .font(.system(size: 23, weight: .bold))
                 .foregroundColor(.black)
                 
                 TextField("search", text: $searchQuery)
                 
                 }
                 */
                ScrollView {
                    
                    
                    
                    
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20),count: 2 ), spacing: 25){
                        
                        
                        ForEach(viewModel.stations) { station in
                            
                            StationSwiftUIView(station: station)
                            
                        }
                    }
                    .onAppear(perform:{
                        print("kjh")
                        viewModel.getAllStation()
                    })
                    .padding()
                    
                }
            }
        }}
    
    struct AffichageStationSwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            AffichageStationSwiftUIView()
        }
    }
    

    func send(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) {(_,_) in
            
            }
        let content = UNMutableNotificationContent()
        content.title = "message"
        content.body = "salut salut"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req , withCompletionHandler: nil)
    }
    
    
    
}

