//
//  ContentView.swift
//  CreateTrashout
//
//  Created by Francesco Viola on 17/11/21.
//

import UserNotifications
import SwiftUI
//add trashout view si acceda da schermata home e da New Planner
struct AddTrashoutView: View {

    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [],
                  animation: .default) private var items: FetchedResults<Item>;
    
    @Binding  var routineLength: String
    @State var days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    @State var weeks = ["1","2","3","4"]
    @Binding  var showAddTrashoutModal : Bool
    //variabili state perche add trashout è di partenza(edit trashout sara @Binding
    @State private var selectedDay = "Monday"
    @State private var selectedTime = "2"
    @State private var selectedColor = Color.red
    @State private var selectedWeek = "1"
    @State private var text=""
    @State private var selectedtime = defaultstarttime
   
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    
    func sendNotification(item:Item) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "RecycleBuddy"
        notificationContent.body = "Today you have to trash \(String(describing: item.title))"
        notificationContent.badge = NSNumber(value: 3)
        
        if let url = Bundle.main.url(forResource: "dune",
                                    withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: item.title!+item.week!,
                                                            url: url,
                                                            options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.date(from:( item.hour!))
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: item.title!+item.week!,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    // Local notifications
    func application(_ application: UIApplication, didReceive notification: UNNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    static var defaultstarttime:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                
                Form { //container for data entry
                    TextField("Category name",text: $text).foregroundColor(.accentColor)
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
                
                }
            }.navigationBarItems(trailing: Button("Done", action: {
                showAddTrashoutModal.toggle()
                addItem()
            })) .navigationBarTitle("Create Trashout")
            
            
        }
            
        
        //ALERT aggiungere button done che fa toggle su showModal
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
            let newItem = Item(context: viewContext)
            let dateFormatter = DateFormatter()
            var convertDate: String!
            dateFormatter.dateFormat = "hh:mm a"
            convertDate = dateFormatter.string(from: selectedtime)
            
            print(convertDate)
            newItem.title=text
            newItem.week=selectedWeek
            newItem.day=selectedDay
            newItem.hour=convertDate
            newItem.color=selectedColor.description
            newItem.reddouble=selectedColor.components.red
            newItem.bluedouble=selectedColor.components.blue
            newItem.greendouble=selectedColor.components.green

//            newItem.red=selectedColor.
            requestNotificationAuthorization()
            sendNotification(item: newItem)

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
