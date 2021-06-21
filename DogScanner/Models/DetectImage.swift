//
//  DetectImage.swift
//  DogScanner
//
//  Created by Arman Abkar on 6/20/21.
//

import Foundation
import CoreML
import Vision
import UIKit
import SwiftUI

class DetectImage {
    
    let defaults = UserDefaults.standard
    private var saveTopPrediction = ""
    private var saveSecondPrediction = ""
    private var saveTopConfidence = ""
    private var saveSecondConfidence = ""
    
    func detect(image: CIImage) {
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: All_AKC_Breeds_Reworked_1500(configuration: config).model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) {request, error in
            let classifications = request.results as! [VNClassificationObservation]
            let predictionIdentifiers = classifications.prefix(3)
            let predictedBreeds = predictionIdentifiers.map { classification in
                return classification.identifier
            }
            
            let predictionConfidences = predictionIdentifiers.map { classification in
                return String(format: "  %.0f %@", classification.confidence * 100, "%")
            }
            let firstPrediction = predictedBreeds[0]
            let secondPrediction = predictedBreeds[1]
            
            self.saveTopPrediction = firstPrediction
            self.defaults.set(self.saveTopPrediction, forKey: "topPrediction")
            
            self.saveSecondPrediction = secondPrediction
            self.defaults.set(self.saveSecondPrediction, forKey: "secondPrediction")
            
            self.saveTopConfidence = predictionConfidences[0]
            self.defaults.set(self.saveTopConfidence, forKey: "topConfidence")
            
            self.saveSecondConfidence = predictionConfidences[1]
            self.defaults.set(self.saveSecondConfidence, forKey: "secondConfidence")
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    struct ImageCapture: View {
        
        @Binding var imagePickerIsShown: Bool
        @Binding var img: Image?
        
        var body: some View {
            ImagePicker(isShown: $imagePickerIsShown, image: $img)
        }
    }
    
}
