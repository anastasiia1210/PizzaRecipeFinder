import Foundation
import CoreML
import Vision
import SwiftUI

class Recognizer: ObservableObject{
    
    @Published var data: Data? = nil
    @Published var confidence: Float = 0
    @Published var identifier: String = ""
    
    func classifier(){
        do{
            let config = MLModelConfiguration()
            let pizzaModel = try PizzaClassifier(configuration: config)
            let model = try VNCoreMLModel(for: pizzaModel.model)
            let request = VNCoreMLRequest(model: model, completionHandler: cHandler)
            

            if #available(iOS 17.0, *) {
                let allDevices = MLComputeDevice.allComputeDevices
                
                for device in allDevices {
                    if device.description.contains("MLCPUComputeDevice") {
                        request.setComputeDevice(.some(device), for: .main)
                        break
                    }
                }
            } else {
                request.usesCPUOnly = true
            }
         
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else {return}
            guard let cgImage = image.cgImage else {return}

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
        } else {
            print("Nothing")
        }
    }
}
