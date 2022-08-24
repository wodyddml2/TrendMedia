import UIKit

extension UIViewController {
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        print(fileURL)
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        let image = UIImage(contentsOfFile: fileURL.path)
        
        return image
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
}
