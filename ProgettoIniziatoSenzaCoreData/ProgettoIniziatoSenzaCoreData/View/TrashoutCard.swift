//
//  LessonCard.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import SwiftUI

struct TrashoutCard: View {
    
    var item: Item
    
    var body: some View {
        HStack{
            Circle().fill(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble))).frame(width: 20, height: 20)
            Spacer()
            Text("\(item.title!)")
                .foregroundColor(Color.black)
                .bold();
            Spacer()
            Spacer()
    
            Text(item.hour!)
            
        }
        }
}

//struct LessonCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TrashoutCard()
//    }
//}
