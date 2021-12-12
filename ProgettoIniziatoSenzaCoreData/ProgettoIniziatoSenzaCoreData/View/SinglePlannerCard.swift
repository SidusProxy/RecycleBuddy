//
//  SinglePlannerCard.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 19/11/21.
//

import SwiftUI

struct SinglePlannerCard: View {
    var items: FetchedResults<Item>
    var week: Int

    var body: some View {
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
                    
                    Text("Week \(week)")
                        .fontWeight(.heavy)
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .frame(alignment: .topLeading)
                    
                }
                
                
                HStack{
                    VStack (alignment: .leading){
                        Group{
                            Text("MON")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Monday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Monday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                            Text("TUE")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Tuesday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Tuesday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                            Text("WED")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Wednesday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Wednesday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                            Text("THU")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Thursday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Thursday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                            Text("FRI")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Friday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Friday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                            Text("SAT")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Saturday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Saturday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                            Text("SUN")
                                .fontWeight(.bold)
                                .padding(.horizontal, 6.0)
                                .padding(.vertical, 4.0)
                                .background("Sunday"==Date().dayOfWeek() ? .teal : .white)
                                .foregroundColor("Sunday"==Date().dayOfWeek() ? .white : .teal)
                                .cornerRadius(5)
                        }.padding(1.5)
                    }
                    
                    VStack (alignment: .leading){
                        Group{
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Monday" && item.week == "\(week)"){
                                            Text(item.title!).fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                .cornerRadius(5)
                                        }}}}.frame(width: 110, height: 30)
                            
                            
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Tuesday" && item.week == "\(week)"){
                                            Text(item.title!).fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                .cornerRadius(5)
                                        }}}}.frame(width: 110, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                            HStack{
                                                ForEach(items){item in
                                                    if(item.day=="Wednesday" && item.week == "\(week)"){
                                                        Text(item.title!).fontWeight(.bold)
                                                            .foregroundColor(.white)
                                                            .padding(.horizontal, 6.0)
                                                            .padding(.vertical, 4.0)
                                                            .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                            .cornerRadius(5)
                                                    }}}}.frame(width: 110, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                                        HStack{
                                                            ForEach(items){item in
                                                                if(item.day=="Thursday" && item.week == "\(week)"){
                                                                    Text(item.title!).fontWeight(.bold)
                                                                        .foregroundColor(.white)
                                                                        .padding(.horizontal, 6.0)
                                                                        .padding(.vertical, 4.0)
                                                                        .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                                        .cornerRadius(5)
                                                                }}}}.frame(width: 110, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Friday" && item.week == "\(week)"){
                                            Text(item.title!).fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                .cornerRadius(5)
                                        }}}}.frame(width: 110, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Saturday" && item.week == "\(week)"){
                                            Text(item.title!).fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                .cornerRadius(5)
                                        }}}}.frame(width: 110, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Sunday" && item.week == "\(week)"){
                                            Text(item.title!).fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(Color(red: Double(item.reddouble), green: Double(item.greendouble), blue: Double(item.bluedouble)))
                                                .cornerRadius(5)
                                        }}}}.frame(width: 110, height: 30)
                        }.padding(0.8)
                        
                    }
                    
                    VStack (alignment: .leading){
                        Group{
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Monday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Tuesday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Wednesday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Thursday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Friday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Saturday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(items){item in
                                        if(item.day=="Sunday" && item.week == "\(week)"){
                                            Text(item.hour!).fontWeight(.medium)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 6.0)
                                                .padding(.vertical, 4.0)
                                                .background(.white)
                                                .cornerRadius(5)
                                        }}}}.frame(width: 60, height: 30)
                            
                        }.padding(0.8)
                            .padding(.leading, 65.0)
                        
                        
                    }
                }.padding(.top, 7.0)
                
            }
        
        }.padding(.top, -98.0)
    }}

//                SingleRowPlanner(items: items, day: "Monday")
//                SingleRowPlanner(items: items, day: "Tuesday")
//                SingleRowPlanner(items: items, day: "Wednesday")
//                SingleRowPlanner(items: items, day: "Thrusday")
//                SingleRowPlanner(items: items, day: "Friday")
//                SingleRowPlanner(items: items, day: "Saturday")
//                SingleRowPlanner(items: items, day: "Sunday")



//struct SinglePlannerCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SinglePlannerCard()
//    }
//}
