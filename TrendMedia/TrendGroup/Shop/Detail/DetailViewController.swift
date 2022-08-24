import UIKit

import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var shoppingDetailLabel: UILabel!
    @IBOutlet weak var shoppingDetailImageView: UIImageView!
    
    var shoppingInfoHandler: (() -> ())?
    var objectId: ObjectId?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        if let info = shoppingInfoHandler {
            info()
        } else {
            return
        }
        guard let objectId = objectId else {
            return
        }
        
        shoppingDetailImageView.image = loadImageFromDocument(fileName: "\(objectId).jpg")
        
    }
    
    func setupUI() {
        view.backgroundColor = .black
        shoppingDetailLabel.font = .boldSystemFont(ofSize: 24)
        shoppingDetailLabel.textColor = .white
        shoppingDetailLabel.textAlignment = .center
        shoppingDetailLabel.numberOfLines = 0
    }

}
