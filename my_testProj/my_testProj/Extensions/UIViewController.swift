//
//  UIViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 8/1/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showToast(with title: String, message: String?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
        
    func setRootWindow() {
        UIApplication.shared.keyWindow?.rootViewController = self
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        fadeAnimation()
    }
    
    private func fadeAnimation() {
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.alpha = 1.0
        }
    }
}
