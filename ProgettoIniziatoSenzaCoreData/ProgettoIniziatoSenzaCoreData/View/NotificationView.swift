//
//  NotificationView.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 17/11/21.
//

import SwiftUI

struct NotificationView: View {
    
    @State private var donenotification: Bool = false
    @State private var doneanticipation: Bool = false

    @State var x:Int = 0
    @Binding var isShowed: Bool

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [],
                  animation: .default) private var items: FetchedResults<Item>;
    
    @FetchRequest(entity: Planner.entity(),
                  sortDescriptors: [],
                  animation: .default) private var plannerino: FetchedResults<Planner>;
    
    
    @FetchRequest(entity: Alert.entity(),
                  sortDescriptors: [],
                  animation: .default) private var alertino: FetchedResults<Alert>;
    
    @Binding  var actualview: String
        var views = ["Planner", "Notifications"]
    
    @State private var routineLength = "1"
        let routines = ["1", "2", "3", "4"]
    @State private var selectedtime = defaultstarttime
    @State var showmodal: Bool = false
    static var defaultstarttime:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("What is your actual view?", selection: $actualview) {
                                ForEach(views, id: \.self) {
                                    Text($0)
                                }
                }.pickerStyle(.segmented)
                    .padding(.all, 25.0)
                    .background(Color.white)
            Form {
                Section(header: Text("Notification controls")){
                    Toggle("On/Off", isOn: $donenotification)
                    
                }
                Section(header: Text("Anticipate notification")){
                    Toggle("On/Off", isOn: $doneanticipation)
                    DatePicker("Time", selection: $selectedtime, displayedComponents: .hourAndMinute)


                  
                    
                }.onAppear(perform: getplannerino)
            }
            }.background(Color(red: 242/255, green:242/255, blue:247/255))
            .navigationBarTitle("Create Planner")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                
            }) {
                
                Text("Done").onTapGesture {
                    isShowed.toggle()
                    modifyAlert()
                }
                
            })    }
    }
    
    public func getplannerino(){
        if(x==0){
            
            let tmp = alertino.first
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "hh:mm a"
            let date = dateFormatter.date(from:(tmp?.timeanticipate)!)!
           selectedtime = date
            doneanticipation = (tmp?.onanticipate)!
            donenotification = (tmp?.on)!

            
        }
     x+=1
    }
    public func modifyAlert() {
        withAnimation {
            let newItem = Alert(context: viewContext)
            let dateFormatter = DateFormatter()
            var convertDate: String!
            dateFormatter.dateFormat = "hh:mm a"
            convertDate = dateFormatter.string(from: selectedtime)
            
            newItem.on=donenotification
            newItem.onanticipate=doneanticipation
            newItem.timeanticipate = convertDate
     

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct NotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationView()
//    }
//}
