//
//  ContentView.swift
//  SwiftUICamera
//

//

import SwiftUI

struct HomeView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State var isShowed: Bool = false
    @State  var actualview: String = "Planner"
    @State private var image: UIImage?
    @State private var isShowingDetailView = false
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default) private var items: FetchedResults<Item>
    
    @FetchRequest(
        entity: Planner.entity(),
        sortDescriptors: [],
        animation: .default) private var plannerino: FetchedResults<Planner>
    
    var body: some View {
        
        NavigationView {
            
            
            VStack(alignment: .leading) {
                Text("Today")
                    .font(.title)
                    .fontWeight(.bold).padding(.leading, 30).padding(.top, 30)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(items){item in
                            if(item.day==Date().dayOfWeek() && item.week == plannerino.first?.active_weekly){
                                DailyTrashoutCard(item: item)
                            }
                        }
                    }
                }
                
                
                NavigationLink(destination: ObjectRecognitionView(imageget: image), isActive: $isShowingDetailView) { EmptyView() }
                Spacer()
                HStack{
                    Text("My planner")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Button(action:{isShowed.toggle()}){
                        Image(systemName: "square.and.pencil").foregroundColor(.teal).padding(.leading, 175.0)
                        
                    }.sheet(isPresented: $isShowed) {
                        if(actualview=="Planner"){
                            CreatePlannerView(isShowed: $isShowed, actualview: $actualview)
                        }else{
                            EditNotificationView(isShowed: $isShowed, actualview: $actualview )
                        }
                        
                    }
                    
                }.padding(.leading, 30).padding(.top, 30)
                TabView {
                    if(plannerino.first?.weekly_lenght == "1"){
                        SinglePlannerCard(items: items, week: 1)

                    }else if (plannerino.first?.weekly_lenght == "2"){
                        SinglePlannerCard(items: items, week: 1)
                        SinglePlannerCard(items: items, week: 2)

                    }else if(plannerino.first?.weekly_lenght == "3"){
                        SinglePlannerCard(items: items, week: 1)
                        SinglePlannerCard(items: items, week: 2)
                        SinglePlannerCard(items: items, week: 3)
                    }else{
                        SinglePlannerCard(items: items, week: 1)
                        SinglePlannerCard(items: items, week: 2)
                        SinglePlannerCard(items: items, week: 3)
                        SinglePlannerCard(items: items, week: 4)
                    }

                       }
                       .tabViewStyle(.page)
                       .indexViewStyle(.page(backgroundDisplayMode: .always))
                Spacer()
            }
            .navigationBarTitle("RecycleBuddy").foregroundColor(.teal)
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = true
                
            }, label: {
                Image(systemName: "dot.viewfinder")
            })).actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                    .default(Text("Photo Library")) {
                        self.showImagePicker = true
                        self.sourceType = .photoLibrary
                        
                    },
                    .default(Text("Camera")) {
                        
                        self.showImagePicker = true
                        self.sourceType = .camera
                    },
                    .cancel()
                ])
            }
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, isShowingDetailView: self.$isShowingDetailView,  sourceType: self.sourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
