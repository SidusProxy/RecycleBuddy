//
//  ContentView.swift
//  testapp
//
//  Created by Luisa Pinto on 15/11/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var actualview: String = "Planner"
    @State var isShowed: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Alert.entity(),
                  sortDescriptors: [],
                  animation: .default) private var alertino: FetchedResults<Alert>;
    
    @FetchRequest(entity: Planner.entity(),
                  sortDescriptors: [],
                  animation: .default) private var plannerino: FetchedResults<Planner>;
    
    public func addItem() {
        withAnimation {
            if(plannerino.isEmpty){
                var newItem = Planner(context: viewContext)
                newItem.active_weekly = "1"
                newItem.weekly_lenght = "1"
            }
            if(alertino.isEmpty){
                var newNotification = Alert(context: viewContext)
                newNotification.timeanticipate = "10:00 AM"
                newNotification.on = false
                newNotification.onanticipate = false

            }
         

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack{
                Text("Welcome in\nRecycleBuddy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                    .padding(.bottom, 80.0)
                    .padding(.top, 30.0)
                
                HStack{
                    VStack{
                        Image(systemName: "calendar.badge.clock")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                            .padding(.bottom, 50.0)
                        
                        Image(systemName: "trash")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                            .padding(.bottom, 6.0)
                        
                        Image(systemName: "dot.viewfinder")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                        .padding(.top, 45.0)}
                   
                    
                    VStack(alignment: .leading, spacing: 10.0){
                        VStack(alignment: .leading, spacing: 10.0) {
                        Text("Weekly Routine")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            
                        Text("Track easily your recycling routine\nday-by-day with a visual planner.")
                            .fontWeight(.regular)
                            .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)}
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 10.0) {
                            Text("Customizable Trashouts")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                
                            Text("Personalise the trashout categories\naccording to your needs and habits.")
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)}
                        .padding(.bottom)
                        
                            
                            VStack(alignment: .leading, spacing: 10.0) {
                                Text("Scan Item")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    
                                Text("Sort objects in the right trash bins\nscanning them with your iPhone.")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)}
                            .padding(.bottom)
                            
                    }
                    .padding(.leading)
                    
                }.onAppear(perform: addItem)
                
                
                    
            }
            Button(action: {isShowed.toggle()}) {
                Text("Create your planner")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 90.0)
                    .padding(.vertical, 15.0)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10).sheet(isPresented: $isShowed) {
                            if(actualview=="Planner"){
                                CreatePlannerWorkingView(isShowed: $isShowed, actualview: $actualview)
                            }else{
                                NotificationView(isShowed: $isShowed, actualview: $actualview )
                            }
                           

                        }
            }
            .padding(.top, 100.0)
        }
        }
    }


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}


