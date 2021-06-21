//
//  ContentView.swift
//  DogScanner
//
//  Created by Arman Abkar on 6/20/21.
//

import SwiftUI

struct ContentView: View {
    
    var defaults = UserDefaults.standard
    @State private var topPrediction = ""
    @State private var secondPrediction = ""
    @State private var topConfidence = ""
    @State private var secondConfidence = ""
    @State private var showImagePicker: Bool = false
    @State private var img: Image? = nil
    @State private var placeholderIsShown = true
    
    var body: some View {
        VStack {
            VStack {
                Text("Dog Scanner")
                    .font(.custom("Charter Italic", size: 34))
                    .foregroundColor(.white)
                    .bold()
            }.padding(.bottom)
            VStack {
                ZStack {
                    img?.resizable()
                        .scaledToFit()
                        .padding()
                    
                    if placeholderIsShown {
                        Image("dogPlaceholder")
                            .scaleEffect(0.8)
                            .cornerRadius(20)
                            .shadow(color: .white, radius: 3)
                    } else {
                        Image("dogPlaceholder")
                            .frame(width: 500, height: 200).hidden()
                    }
                }
            }
            Spacer()
                .frame(height: 25)
            VStack {
                Text("Top Prediction & Confidence:").font(.custom("Charter Italic", size: 21))
                    .foregroundColor(.white)
                    .bold()
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemOrange), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .overlay(Text(" " + self.topPrediction + self.topConfidence)
                                .padding(5)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .font(.title))
                    .padding(.bottom)
                
                Text("Second Prediction & Confidence:")
                    .font(.custom("Charter Italic", size: 21))
                    .foregroundColor(.white)
                    .bold()
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemOrange), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .overlay(Text(" " + self.secondPrediction + self.secondConfidence)
                                .padding(5)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .font(.title))
                    .padding(.bottom)
            }.foregroundColor(.white)
            .padding()
            VStack {
                HStack(spacing: 30) {
                    Button(action: {
                        self.topPrediction = ""
                        self.secondPrediction = ""
                        self.topConfidence = ""
                        self.secondConfidence = ""
                        self.showImagePicker = true
                        self.placeholderIsShown = false
                    }){
                        Image(systemName: "photo.on.rectangle")
                        Text("Library")
                            .bold()
                            .padding(.horizontal)
                    }.padding()
                    .foregroundColor(Color.black)
                    .background(Color(UIColor.systemGreen))
                    .cornerRadius(14)
                    
                    Button(action: {
                        self.topPrediction = UserDefaults.standard.string(forKey: "topPrediction") ?? "No Prediction Available"
                        self.secondPrediction = UserDefaults.standard.string(forKey: "secondPrediction") ?? "No Prediction Available"
                        self.topConfidence = UserDefaults.standard.string(forKey: "topConfidence") ?? "No Confidence Available"
                        self.secondConfidence = UserDefaults.standard.string(forKey: "secondConfidence") ?? "No Confidence Available"
                    }){
                        Image(systemName: "questionmark.square.fill")
                        Text("Predict")
                            .bold()
                            .padding(.horizontal)
                    }.padding()
                    .foregroundColor(Color.black)
                    .background(Color(UIColor.systemOrange))
                    .cornerRadius(14)
                }
            }
            .sheet(isPresented: self.$showImagePicker) {
                ImagePicker(isShown: self.$showImagePicker, image: self.$img)
            }
        }.background(Image("background").edgesIgnoringSafeArea([.all]))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

