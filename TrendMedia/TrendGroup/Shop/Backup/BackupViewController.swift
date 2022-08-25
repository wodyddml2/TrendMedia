import UIKit

import Zip

class BackupViewController: UIViewController {
    @IBOutlet weak var backupTableView: UITableView!
    @IBOutlet weak var backupProgressView: UIProgressView!
    
    var backupFileList: [String]?
    var backupFileSize: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backupTableView.delegate = self
        backupTableView.dataSource = self
        backupProgressView.progress = 0.0
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let restoreButton = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(restoreButtonClicked))
       
        navigationItem.rightBarButtonItems = [backupButton, restoreButton]
        
        fetchDocumentZipFile { file, size in
            self.backupFileList = file
       
            self.backupFileSize = size.map { fileSize in
                
                String(format: "%.1f", ((fileSize! as? Double)! / 1000))
            }
        }
    }
    
    @objc func backupButtonClicked() {
        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "Document 경로가 잘못되었습니다.", alertMessage: nil)
            return
        }
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlert(alertTitle: "백업할 파일이 존재하지 않습니다.", alertMessage: nil)
            return
        }
        
        urlPaths.append(realmFile)
        
        do {
            try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_\(Date())")
            showActivityViewController()
        } catch {
            showAlert(alertTitle: "압축을 실패했습니다.", alertMessage: nil)
        }
    }
    
    func showActivityViewController() {
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "Document의 경로가 잘못되었습니다.", alertMessage: nil)
            return
        }
        let backupFileURL = path.appendingPathComponent("ShoppingList_\(Date()).zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func restoreButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }


}

extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "Document의 경로가 잘못되었습니다.", alertMessage: nil)
            return
        }
        guard let selectedFileURL = urls.first else {
            showAlert(alertTitle: "선택하신 파일을 찾을 수 없습니다.", alertMessage: nil)
            return
        }
        let sandBoxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        if FileManager.default.fileExists(atPath: sandBoxFileURL.path) {
            let fileURL = path.appendingPathComponent("ShoppingList_\(Date()).zip") //
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                    self.backupProgressView.setProgress(Float(progress), animated: true)
                    
                }, fileOutputHandler: { unzippedFile in
                    self.showAlert(alertTitle: "복구가 완료되었습니다.", alertMessage: nil)
                    
                })
            } catch {
                showAlert(alertTitle: "압축 해제에 실패했습니다.", alertMessage: nil)
            }
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandBoxFileURL)
                
                let fileURL = path.appendingPathComponent("ShoppingList_\(Date()).zip") //
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                }, fileOutputHandler: { unzippedFile in
                    self.showAlert(alertTitle: "복구가 완료되었습니다.", alertMessage: nil)
                })
            } catch {
                showAlert(alertTitle: "압축 해제에 실패했습니다.", alertMessage: nil)
            }
        }
        
        
    }
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupFileList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BackupTableViewCell", for: indexPath) as? BackupTableViewCell else {return UITableViewCell()}
        
        cell.fileNameLabel.text = backupFileList?[indexPath.row]
        cell.fileSizeLabel.text = "\(backupFileSize?[indexPath.row] ?? "")KB"
        return cell
    }
}
