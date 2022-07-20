//
//  RecommandCollectionViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher
//heightForRow > FlowLayout(이유는 가로세로 다 고려해서해서)

class RecommandCollectionViewController: UICollectionViewController {
    
    var image = URL(string: "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20171019_71%2F1508372895644TRb8c_JPEG%2Fmovie_image.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 컬렉션 뷰의 셀 크기, 셀 사이 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        
        let spacing:CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 3 * 1.4)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as! RecommandCollectionViewCell
        
        cell.posterImageView.backgroundColor = .orange
        cell.posterImageView.kf.setImage(with: image)
        cell.posterImageView.contentMode = .scaleAspectFill
        return cell
    }
    
    // 클릭 시
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        // toast with a specific duration and position
        view.makeToast("\(indexPath.item)번째 셀 선택", duration: 3.0, position: .center)

    }
    

}
