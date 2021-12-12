//
//  ContentView.swift
//  CoreMLwithSwiftUI
//
//

import SwiftUI
import CoreML

struct ObjectRecognitionView: View {
    @State private var showSheet: Bool = false
    let model = MobileNetV2()
    @State private var classificationLabel: String = ""
    @State var imageget: UIImage?
    @State private var image: UIImage?
    @State private var currentIndex: Int = 0
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var isShowingDetailView = false

    
    @State private var arrayPlastica = ["ping-pong ball","plastic bag","shower cap","water bottle"]
    @State private var ArrayMetalli = ["chain","cleaver","corkscrew","espresso maker","frying pan","hair spray","letter opener","milk can","mitten","nail","padlock","pot","washer","hot pot"]
    @State private var arraycartaeCartoni=["envelope","matchstick","packet","crossword puzzle"]
    @State private var arrayVetro = ["beer bottle","beer glass","saltshaker","wine bottle"]
    @State private var arraysecco = ["balloon","Band Aid","cassette player","CD player","diaper","golf ball","lighter","lipstick","mask","quill","eraser","snorkel","soup bowl","sunglasses","syringe","tennis ball","umbrella","vase","plate","trifle"]
    @State private var ArrayIndumentietessuti = ["bikini", "apron","backpack", "bath towel","cardigan","purse","sandal","running shoe", "sock","trench coat","velvet"]
    @State private var ArrayIsolaecologica = ["analog clock","binoculars","bookcase","candle","cellular telephone","coffee mug","computer keyboard","crash helmet","desktop computer","digital clock","digital watch","dining table","disk brake","doormat","electric fan","electric guitar","grille","hard disc","iPod","jersey","joystick","kimono","laptop","loudspeaker","microphone","microwave","modem","monitor","mouse","necklace", "notebook","pay-phone","printer","projector","racket","radio","radio telescope","reflex","camera","refrigerator","sewing machine","shovel","soccer ball","stove","suit","switch","registratore","television","thresher","toaster","torch","tricycle","tub","turnstile","typewriter","keyboard","vacuum","wardrobe","street sign","pillow","sunscreen"]
    
    @State private var tip=""
    @State private var trash=""
    
    var body: some View {
        VStack {
            Image(uiImage: imageget!)
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(20).onChange(of: imageget) { newValue in
                    classifyImage()
                }
       
            
            VStack{
                Text(classificationLabel).fontWeight(.bold)
                    .font(.body)
                Text(trash)
            }.padding(.top, 30)
           
            Spacer()
            Text(tip).multilineTextAlignment(.center)
                .frame(maxWidth: 300, alignment: .center)

            Spacer()
            // The button we will use to classify the image using our model
            Button(action: {self.showSheet.toggle()}) {
                Text("Retake").fontWeight(.bold).padding().padding(.horizontal, 50)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)}
            .actionSheet(isPresented: $showSheet) {
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
            // The Text View that we will use to display the results of the classification
           Spacer()
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$imageget, isShown: self.$showImagePicker, isShowingDetailView: self.$isShowingDetailView,  sourceType: self.sourceType)}
        .onAppear(perform: classifyImage)
    }
    
    private func classifyImage() {
        guard let image = imageget,
              let resizedImage = image.resizeImageTo(size:CGSize(width: 224, height: 224)),
              let buffer = resizedImage.convertToBuffer() else {
              return
        }
        
        let output = try? model.prediction(image: buffer)
        
        if let output = output {
//            let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
//            let result = results.map { (key, value) in
//                return "\(key) = \(String(format: "%.2f", value * 100))%"
//            }.joined(separator: "\n")
            if(output.classLabel=="nipple"){
                self.classificationLabel = "It's a plastic bottle"
                self.trash = "It goes in the plastic bin"
                self.tip = "Check if the label is made of paper or plastic: remove it and trash it in the right bin."
            }else if (arrayPlastica.contains(output.classLabel)){
                self.classificationLabel = output.classLabel
                self.trash = "It goes in the plastic bin"
                self.tip = ""
            }else if (arrayVetro.contains(output.classLabel)){
                self.classificationLabel = "It's a " + output.classLabel
                self.trash = "It goes in the glass bin"
                self.tip = "Check if the label is made of paper or plastic: remove it and trash it in the right bin."
            }else if (ArrayMetalli.contains(output.classLabel)){
                self.classificationLabel = "It's a " + output.classLabel
                self.trash = "It goes in the plastic bin"
                self.tip = ""
            }else if (arraycartaeCartoni.contains(output.classLabel)){
                self.classificationLabel = "It's a " + output.classLabel
                self.trash = "It goes in the paper bin"
                self.tip = "Check if the label is made of paper or plastic: remove it and trash it in the right bin."
            }else if (ArrayIndumentietessuti.contains(output.classLabel)){
                self.classificationLabel = "It's a " + output.classLabel
                self.trash = "It goes in the clothes bin"
                self.tip = "You can also take it near some church"
            }else if (ArrayIsolaecologica.contains(output.classLabel)){
                self.classificationLabel = "It's a " + output.classLabel
                self.trash = "It goes at the recycling area"
                self.tip = ""
            }else if (arraysecco.contains(output.classLabel)){
                self.classificationLabel = "It's a " + output.classLabel
                self.trash = "It goes in the not recyclable waste bin"
                self.tip = "That's all folks"
            }else{
                self.classificationLabel = "Ops! It seems we don't know what this is"
                self.trash = "Try to take another photo"
                self.tip = "Sorry for the inconvenience"
            }

        }
    }
    
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectRecognitionView()
    }
}
