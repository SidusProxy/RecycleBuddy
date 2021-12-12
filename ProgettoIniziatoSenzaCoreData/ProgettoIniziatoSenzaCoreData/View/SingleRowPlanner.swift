//
//  SingleRowPlanner.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 19/11/21.
//

import SwiftUI

struct SingleRowPlanner: View {
    var items: FetchedResults<Item>
    var day: String
    var body: some View {
        
        HStack{
//            VStack(alignment: .leading){
//                Group{
//                    Text(day) .fontWeight(.bold)
//                        .padding(.horizontal, 6.0)
//                        .padding(.vertical, 4.0)
//                        .background(.white)
//                        .cornerRadius(5)
//                    
//                }.padding(1.5)
//                
//            }
            VStack{
                Group{
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(items){item in
                                if(item.day==day){
                                    Text(item.title!).fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 6.0)
                                        .padding(.vertical, 4.0)
                                        .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                        .cornerRadius(5)
                                }
                            }
                        }
                        
                    }
                }.padding(1.5).padding(.leading, 65)
                
            }
            
//            VStack{
//                Group{
//                    ScrollView(.horizontal,showsIndicators: false){
//                        HStack{
//                            ForEach(items){item in
//                                if(item.day==day){
//                                    Text(item.hour!).padding()
//                                }
//                            }}}
//                }.padding(1.5).padding(.leading, 65)
//            }
            
        }.padding(.top,7)
    }
}

//struct SingleRowPlanner_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleRowPlanner()
//    }
//}
