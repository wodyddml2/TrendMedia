//
//  ViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    // 언제 아울렛컬렉션을 사용하는 것이 좋을까?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    @IBOutlet weak var greenLeadingConstraint: NSLayoutConstraint!
    
    // 변수의 스코프
    let format = DateFormatter() // 전역변수로 사용 action에 놓으면 그 안에서만 사용가능하며 클릭 할때마다 메모리상에 저장되었다가 지워졌다 반복
//    format.dateFormat = "yyyy/MM/dd"
//    dateLabel.text = "Aaa"
//    실행이 안되는 이유는 언제 실행이 될지 모르기 때문
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        format.dateFormat = "yyyy/MM/dd"
        
        greenLeadingConstraint.constant = 120

    }

    func configureLaberDesign() {
        // 1. OutletCollection(ex. UIView)
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
        }
        
        // 2. UILabel - 나중에 가독성을 높이고 또한 묶이는 객체가 많을 때 하나를 제외하거나 변경사항이 있을 때 이 방법이 좋을 수 있다.
        let labelArr = [dateLabel, dateLabel2]
        for i in labelArr {
            i?.font = .boldSystemFont(ofSize: 20)
            i?.textColor = .brown
        }
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        
        
        dateLabel.text = format.string(from: sender.date)
        
    }
    
}

