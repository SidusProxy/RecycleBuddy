//
//  ContentView.swift
//  CreateTrashout
//
//  Created by Gianluca Annina on 20/11/21.
//

import SwiftUI
//
//  ContentView.swift
//  17novembre
//
//  Created by Francesco Viola on 17/11/21.
//


import SwiftUI
//add trashout view si acceda da schermata home e da New Planner
struct EditTrashoutView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @State var x:Int = 0
    var newItem:Item
    @Binding var isEditTrashout: Bool
    @Binding  var routineLength: String
    @State var days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sundays"]
    @State var weeks = ["1","2","3","4"]
    //variabili state perche add trashout è di partenza(edit trashout sara @Binding
    @State private var selectedDay = "Monday"
    @State private var selectedTime = "2"
    @State private var selectedColor = Color.red
    @State private var selectedWeek = "1"
    @State private var text=""
    @State private var selectedtime = defaultstarttime

    static var defaultstarttime:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
            VStack {
                
                Form { //container for data entry
                    TextField(text,text: $text).foregroundColor(.accentColor)
                    // Day picker -enum days
                    Picker("Day",selection : $selectedDay) {
                        ForEach(days, id: \.self) {
                            Text($0)
                        }
                    }.foregroundColor(.accentColor)

                    ColorPicker("Colour",selection: $selectedColor)
                        .foregroundColor(.accentColor).pickerStyle(.automatic)
                    //aggiungere week first or second
                    Picker("Which week",selection: $selectedWeek) {
                        ForEach(weeks,id: \.self) {
                            Text($0).foregroundColor(.accentColor)
                        }.foregroundColor(.accentColor)
                    }.foregroundColor(.accentColor)
                    DatePicker("Timer", selection: $selectedtime, displayedComponents: .hourAndMinute).onAppear(perform: handleweek).foregroundColor(.accentColor)
                
                }.onAppear(perform: gettrasherino)
            }.navigationBarItems(trailing: Button("Done", action: {
                addItem()
                isEditTrashout.toggle()
            })) .navigationBarTitle("Edit Trashout")
            
            
            
        
            
        
        //ALERT aggiungere button done che fa toggle su showModal
    }
    
    
    public func gettrasherino(){
        if(x==0){
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "hh:mm a"
            let date = dateFormatter.date(from:newItem.hour!)!
            text = newItem.title!
            selectedWeek = newItem.week!
            selectedDay = newItem.day!
            selectedtime = date
            selectedColor = Color(red: Double(newItem.reddouble), green: Double(newItem.greendouble), blue: Double(newItem.bluedouble))

        }
     x+=1
    }
    
    
    public func handleweek(){
        if (routineLength=="1"){
            weeks = ["1"]
        }else if(routineLength=="2"){
            weeks = ["1","2"]
        }else if (routineLength=="3"){
            weeks = ["1","2","3"]
        }else{
            weeks = ["1","2","3","4"]
        }
    }
    
    public func addItem() {
        withAnimation {
            let dateFormatter = DateFormatter()
            var convertDate: String!
            dateFormatter.dateFormat = "hh:mm a"
            convertDate = dateFormatter.string(from: selectedtime)
            
            
            newItem.title=text
            newItem.week=selectedWeek
            newItem.day=selectedDay
            newItem.hour=convertDate
            newItem.color=selectedColor.description
            newItem.reddouble=selectedColor.components.red
            newItem.bluedouble=selectedColor.components.blue
            newItem.greendouble=selectedColor.components.green

//            newItem.red=selectedColor.

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct AddTrashoutView_Preview: PreviewProvider {
//    static var previews: some View {
//        AddTrashoutView()
//    }
//
//}
