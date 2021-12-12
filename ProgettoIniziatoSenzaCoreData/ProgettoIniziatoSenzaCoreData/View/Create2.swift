//
//  Create2.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 17/11/21.
//

import SwiftUI


struct CreatePlannerWorkingView: View {
    @Binding var isShowed: Bool
    @State  var showAddTrashoutModal : Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [],
                  animation: .default) private var items: FetchedResults<Item>;
    
    @FetchRequest(entity: Planner.entity(),
                  sortDescriptors: [],
                  animation: .default) private var plannerino: FetchedResults<Planner>;
    
    @Binding  var actualview: String
        var views = ["Planner", "Notifications"]
    
    @State private var routineLength = "1"
        let routines = ["1", "2", "3", "4"]
    @State private var selectedweek = "1"
        @State var weeks = ["1"]
    @State var showmodal: Bool = false
    @State var accountcreated: Bool = false
    @State var x: Int = 0
    
    var body: some View {
        
        NavigationView {
            VStack{
                Picker("What is your actual view?", selection: $actualview) {
                                ForEach(views, id: \.self) {
                                    Text($0)
                                }
                }.pickerStyle(.segmented)
                    .padding(.all, 25.0).background(Color.white)

            Form {
                Section(header: Text("Routine info")){
                    
                    Picker("Routine length", selection: $routineLength) {
                        ForEach(routines, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: routineLength) { newValue in
                        selectedweek = "1"
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

                    Picker("Current week", selection: $selectedweek) {
                        ForEach(weeks, id: \.self) {
                            Text($0)
                        }
                        
                    }
                    
                }
            }
                    
//                    Color.gray
                
                HStack{
                    Text("        TRASHOUT CATEGORIES")
                        .foregroundColor(.gray)
                        .font(.system(size:12.5, weight: .regular))
                        .background(Color(red:242/255,green:242/255,blue:247/255))
                    
                    
                    Spacer()
                    Spacer()
                

                    Image(systemName: "plus.circle")
                        .foregroundColor(Color("AccentColor"))
                        .font(.system(size: 20, weight: .regular)).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40)).onTapGesture {
                            showAddTrashoutModal.toggle()
                        }.sheet(isPresented: $showAddTrashoutModal) {
                            AddTrashoutView(routineLength: $routineLength,showAddTrashoutModal: $showAddTrashoutModal )
                        }
//                        .padding(.bottom, 50.0)
                .background(Color(red:242/255,green:242/255,blue:247/255))
                }

                    List {
                        ForEach(items) { item in
                        
                                ZStack{
                                   TrashoutCard(item: item)
                              
                                }
                            
                            
                        }
                        .onDelete(perform: delete)
                        .foregroundColor(Color.gray)
                        .cornerRadius(10)
                    }.onAppear(perform: getplannerino)
                    
             

            }.background(Color(red: 242/255, green:242/255, blue:247/255))
            .navigationBarTitle("Create Planner")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                
            }) {
                
                Text("Done").onTapGesture {
                    savePlanner()
                    accountcreated.toggle()
                    UserDefaults.standard.set(true, forKey: "LaunchBefore")
                    isShowed.toggle()

                }
                
            })
           
    }.fullScreenCover(isPresented: $accountcreated){
        HomeView()
    }
    }
    func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
          
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    public func getplannerino(){
        if(x==0){
            let tmp = plannerino.first
             routineLength = (tmp?.weekly_lenght)!
             selectedweek = (tmp?.active_weekly)!
        }
        x+=1
    }
    public func savePlanner() {
        withAnimation {
            plannerino.first!.active_weekly = selectedweek
            plannerino.first!.weekly_lenght = routineLength

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
//struct Create2View_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
