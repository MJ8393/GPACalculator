//
//  NewViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 14/06/23.
//

import UIKit
import PanModal

class NewViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    @objc func addButtonTapped() {
        button.fadeOut()
        button.backgroundColor = .green
        button.fadeIn()
    }

}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(_ duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}
extension UIButton {
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesMoved(touches, with: event)
            
            guard let touch = touches.first else { return }
            
            let previousLocation = touch.previousLocation(in: self)
            let currentLocation = touch.location(in: self)
            
            let deltaX = currentLocation.x - previousLocation.x
            
            if deltaX > 0 {
                print("Right")
            } else if deltaX < 0 {
                print("Left")
            }
        }
}
