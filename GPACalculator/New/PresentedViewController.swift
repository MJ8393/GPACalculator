//
//  PresentedViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 14/06/23.
//

import UIKit
import PanModal

class PresentedViewController: UIViewController {

    var dh: CGFloat = 0
    
    lazy var stackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(self.textLabel1)
        stackView.addArrangedSubview(self.textLabel2)
        return stackView
    }()
    
    lazy var textLabel1: UILabel = {
        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.red
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        textLabel.text  = "Label"
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    lazy var textLabel2: UILabel = {
        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.red
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        textLabel.text  = "Label"
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        print("XXX", stackView.frame.height)
    }

}

extension PresentedViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(stackView.intrinsicContentSize.height)
    }
//
}
