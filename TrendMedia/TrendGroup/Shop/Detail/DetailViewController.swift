import UIKit

import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var shoppingDetailLabel: UILabel!
    
    var shoppingInfoHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        if let info = shoppingInfoHandler {
            info()
        } else {
            return
        }
        
    }
    
    func setupUI() {
        view.backgroundColor = .black
        shoppingDetailLabel.font = .boldSystemFont(ofSize: 24)
        shoppingDetailLabel.textColor = .white
        shoppingDetailLabel.textAlignment = .center
        shoppingDetailLabel.numberOfLines = 0
    }

}
