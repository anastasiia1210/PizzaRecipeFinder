import Foundation
import CoreML
import Vision
import SwiftUI

class Recognizer: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var confidence: Float = 0
    @Published var identifier: String = ""
    @Published var ingredients: [String] = []
    
    func classifier(){
        do{
            let config = MLModelConfiguration()
            let pizzaModel = try PizzaClassifier(configuration: config)
            let model = try VNCoreMLModel(for: pizzaModel.model)
            let request = VNCoreMLRequest(model: model, completionHandler: cHandler)
            
#if targetEnvironment(simulator)
            request.usesCPUOnly = true
#endif
            
            guard let image = image else {return}
            guard let cgImage = image.cgImage else {return}
            
            let imageRequestHandker = VNImageRequestHandler(cgImage: cgImage)
            try imageRequestHandker.perform([request])
        }catch{
            print(error)
        }
    }
    
    func multiClassifier(){
        do{
            let config = MLModelConfiguration()
            let pizzaModel = try PizzaToppingsMultiLabelImageClassifier(configuration: config)
            let model = try VNCoreMLModel(for: pizzaModel.model)
            let request = VNCoreMLRequest(model: model, completionHandler: multiHandler)
            
            guard let image = image else {return}
            guard let cgImage = image.cgImage else {return}
            
#if targetEnvironment(simulator)
            request.usesCPUOnly = true
#endif
            
            let imageRequestHandker = VNImageRequestHandler(cgImage: cgImage)
            try imageRequestHandker.perform([request])
        }catch{
            print(error)
        }
    }
    
    func cHandler(request: VNRequest, error: Error?) {
        if let results = request.results as? [VNClassificationObservation], let firstResult = results.first {
            self.confidence = firstResult.confidence
            self.identifier = firstResult.identifier
            print("\(identifier) - \(confidence)")
        } else {
            print("Nothing")
        }
    }
    
    func multiHandler(request: VNRequest, error: Error?) {
        ingredients = []
        if (identifier == "other"){
            return
        }
        if let results = request.results as? [VNClassificationObservation]{
            results.forEach{
                if ($0.confidence > 0.1){
                    print("\($0.identifier) - \($0.confidence)")
                    ingredients.append($0.identifier)
                }
            }
            print(ingredients)
        } else {
            print("Nothing multiModel")
        }
    }
}

