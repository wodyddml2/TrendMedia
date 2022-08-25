//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

extension UIViewController {
    func setBackgroudColor () {
        view.backgroundColor = .orange
    }
    
    func showAlert(alertTitle: String, alertMessage: String?) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
