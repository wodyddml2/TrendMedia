import UIKit

class BackupTableViewCell: UITableViewCell {
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        fileNameLabel.font = .boldSystemFont(ofSize: 17)
        fileSizeLabel.font = .boldSystemFont(ofSize: 15)
    }

    

}
