//
//  StationSwiftUIView.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 8/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import SwiftUI

struct commentaireSwiftUIView: View {
    var body: some View {
     
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
    }
}

struct StationSwiftUIView: View {
    
    var station: Station
    @State var selected = -1
    @State var message = false
    @State private var ttt = true
    var body: some View {
       
            VStack {
                HStack {
                    
                }
                if (station.category == "Métro"){
                    Spacer(minLength: 0)
                    Image("Metro1")
                        .resizable()
                        .frame(width: 80.0 , height: 80.0)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 100)
                        .padding(.bottom)
                        .padding(.horizontal, 10)
                    
                    
                    
                    Text("Région:\(station.Région)")
                        .font(.system(size : 12 , weight: .heavy , design : .rounded ))
                        .foregroundColor(.black)
                        .padding(.vertical, 0)
                        .padding(.horizontal, 10)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                    
                    Text("Nom Station:\(station.NomStation)")
                        .font(.system(size : 12 , weight: .heavy , design : .rounded))
                        .padding(.vertical, 0)
                        .padding(.horizontal, 3)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                    
                    Image(uiImage: UIImage(data: getQRCodeDate(text: "https://www.google.tn/maps/dir/\(station.NomStation)")!)!)
                        .resizable()
                        .frame(width: 45, height: 45)
                    
                    HStack {
                        	Text("Rating")
                            .font(.system(size : 14, weight: .heavy , design : .rounded))
                          
                        HStack{
                            RatingView(selected: $selected, message: $message)
                            
                            
                        }
                    }.alert(isPresented: $message) {
                        Alert(title: Text("Rating Submit"), message: Text("You Rated \(self.selected + 1 ) out of 5 Star "
                                                                         ),  dismissButton: .none)
                    }
                   
                }
                else if (station.category == "Train"){
                    
                    Spacer(minLength: 0)
                    Image("Train1")
                        .resizable()
                        .frame(width: 100.0 , height: 100.0)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 100)
                        .padding(.bottom)
                        .padding(.horizontal, 10)
                    
                    
                    
                    
                    Text("Région:\(station.Région)")
                        .font(.system(size : 12 , weight: .heavy , design : .rounded ))
                        .foregroundColor(.black)
                        .padding(.vertical, 0)
                        .padding(.horizontal, 10)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                    
                    Text("Nom Station:\(station.NomStation)")
                        .font(.system(size : 12 , weight: .heavy , design : .rounded))
                        .padding(.vertical, 0)
                        .padding(.horizontal, 3)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                
                    Image(uiImage: UIImage(data: getQRCodeDate(text: "https://www.google.tn/maps/dir/\(station.NomStation)")!)!)
                        .resizable()
                        .frame(width: 45, height: 45)
            
                    
                    HStack {
                            Text("Rating")
                            .font(.system(size : 14, weight: .heavy , design : .rounded))
                          
                        HStack{
                            RatingView(selected: $selected, message: $message)
                            
                        }
                    }.alert(isPresented: $message) {
                        Alert(title: Text("Rating Submit"), message: Text("You Rated \(self.selected + 1 ) out of 5 Star "
                                                                         ),  dismissButton: .none)
                    }
                    
                    
                }
                else {
                    
                    Spacer(minLength: 0)
                    Image("bbus")
                        .resizable()
                        .frame(width: 90.0 , height: 90.0)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 100)
                        .padding(.bottom)
                        .padding(.horizontal, 10)
                    
                    
                    
                    
                    Text("Région:\(station.Région)")
                        .font(.system(size : 12 , weight: .heavy , design : .rounded ))
                        .foregroundColor(.black)
                        .padding(.vertical, 0)
                        .padding(.horizontal, 10)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                    
                    Text("Nom Station:\(station.NomStation)")
                        .font(.system(size : 12 , weight: .heavy , design : .rounded))
                        .padding(.vertical, 0)
                        .padding(.horizontal, 3)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                
                    Image(uiImage: UIImage(data: getQRCodeDate(text: "https://www.google.com/maps/dir/36.8665367,10.1647233/bus+charguia+1/")!)!)
                        .resizable()
                        .frame(width: 45, height: 45)
            
                    
                    HStack {
                            Text("Rating")
                            .font(.system(size : 14, weight: .heavy , design : .rounded))
                          
                        HStack{
                            RatingView(selected: $selected, message: $message)
                            
                        }
                    }.alert(isPresented: $message) {
                        Alert(title: Text("Rating Submit"), message: Text("You Rated \(self.selected + 1 ) out of 5 Star "
                                                                         ),  dismissButton: .none)
                    }
                    
                    
              
                    
                    
                }
                
            }
            .background(
                Color("PrimaryColor")
                    .opacity(0.1)
                    .ignoresSafeArea()
                //.matchedGeometryEffect(id: "color\(plate.id)", in: animation)
            )
            .cornerRadius(7)
        
    }
    func getQRCodeDate(text: String) -> Data? {
         guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
         let data = text.data(using: .ascii, allowLossyConversion: false)
         filter.setValue(data, forKey: "inputMessage")
         guard let ciimage = filter.outputImage else { return nil }
         let transform = CGAffineTransform(scaleX: 30, y: 30)
         let scaledCIImage = ciimage.transformed(by: transform)
         let uiimage = UIImage(ciImage: scaledCIImage)
         return uiimage.pngData()!
     }

    
    struct RatingView : View {
        
        @Binding var selected : Int
        @Binding var message : Bool
        var body: some View{
        
            
            ForEach(0..<5){ rating in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(self.selected >= rating ? .yellow : .gray)
                    .onTapGesture {
                        self.selected = rating
                        self.message.toggle()
                    }
            }
            
            
            
            
            
        }
    }

}

