import UIKit

extension UIViewController {
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentDirectory
    }
    
    func imageDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let imageDirectoryURL = documentDirectory.appendingPathComponent("Image")
        
        return imageDirectoryURL
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let path = imageDirectoryPath() else {return}
        
        if !FileManager.default.fileExists(atPath: path.path) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
            } catch {
                print("errrrr")
            }
        } else {
            let fileURL = path.appendingPathComponent(fileName)
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
        
        
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let path = imageDirectoryPath() else {return nil}
        let fileURL = path.appendingPathComponent(fileName)
        
        let image = UIImage(contentsOfFile: fileURL.path)
        
        return image
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let path = imageDirectoryPath() else {return}
        let fileURL = path.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func fetchDocumentZipFile(completionHandler: @escaping ([String],[Any?]) -> ()) {
        do {
            guard let path = documentDirectoryPath() else {return}
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            let zip = docs.filter {
                $0.pathExtension == "zip"
            }
            
            let result = zip.map {
                $0.lastPathComponent
                
            }
            let fileSize = zip.map {
                try? FileManager.default.attributesOfItem(atPath: $0.path)[.size]
            }

            completionHandler(result,fileSize)
        } catch {
            print("error")
        }
    }
}
