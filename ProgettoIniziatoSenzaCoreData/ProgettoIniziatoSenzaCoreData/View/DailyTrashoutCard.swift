//
//  DailyTrashoutCard.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 20/11/21.
//

import SwiftUI

struct DailyTrashoutCard: View {
    
    var item: Item

//    Date().dayOfWeek()!
    var body: some View {
        
VStack(alignment: .leading){
   
    
    ZStack(alignment: .leading){
    Rectangle()
        .foregroundColor(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
        .frame(width: 300, height: 80, alignment: .center)
        .cornerRadius(10)
//        .shadow(color: .gray, radius: 10, x: 0, y: 5)
        
        VStack(alignment: .leading){
        
            Text(item.title!)
            .fontWeight(.heavy)
            .font(.title2)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.leading)
            .padding(.leading)
            .frame(alignment: .topLeading)
            
            Text(item.hour!)
                .fontWeight(.medium)
                .font(.title2)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .padding(.leading)
                .frame(alignment: .topLeading)
        }
    }
}.padding(.leading, 30.0)
        
    }
}

//struct DailyTrashoutCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyTrashoutCard()
//    }
//}
