import UIKit

import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var shoppingDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
        
    }
    
    func setupUI() {
        view.backgroundColor = .black
        shoppingDetailLabel.font = .boldSystemFont(ofSize: 24)
        shoppingDetailLabel.textColor = .white
        shoppingDetailLabel.textAlignment = .center
    }

}
