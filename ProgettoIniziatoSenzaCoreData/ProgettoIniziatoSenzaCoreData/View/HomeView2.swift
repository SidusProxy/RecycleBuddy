//
//  ContentView.swift
//  testhomeappini
//
//  Created by Luisa Pinto on 19/11/21.
//

import SwiftUI

struct HomeViewkb: View {
    var body: some View {
        
        NavigationView{
            

            
        VStack(alignment: .leading){
            
    
    
            
            
        

    
        
        VStack(alignment: .leading){
            
      
        
        ZStack(alignment: .topLeading){
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 350, height: 350, alignment: .center)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 10, x: 0, y: 5)
            VStack{
            ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.teal)
                .frame(width: 350, height: 55, alignment: .top)
                .cornerRadius(10)

                Text("Week 1")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(alignment: .topLeading)
            }
             



        }
    }
            
        }.padding(.top, 50.0)
            Spacer()
          
            
            
            
            
            
            
            
            
        }.navigationTitle("RecycleBuddy")
                .navigationBarTitleDisplayMode(.large)
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarItems(trailing:
                 Button(action:{}){
                    Image(systemName: "dot.viewfinder").foregroundColor(.teal)
                
                }
                
                )
            
        }
            
}
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
