//
//  LanguageViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class LanguageViewController: UIViewController {
    
    var pointOrigin: CGPoint?
    
    var hasSetPointOrigin = false
    
    var padding: CGFloat = 20
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineColor")!
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var semesterLabel = MainLabel(text: "Languages", textColor: UIColor(named: "LabelColor")!, textAlignment: .center, font: UIFont(name: "Poppins-Regular", size: 16)!)
    
    lazy var lineView1: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "LineColor")!
        line.layer.cornerRadius = 0.5
        return line
    }()
    
    lazy var lineView2: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "LineColor")!
        line.layer.cornerRadius = 0.5
        return line
    }()
    
    lazy var addButton = MainButton(title: "Change")
    lazy var uzbekButton = MainButton(title: "Uzbek")
    lazy var englishButton = MainButton(title: "English")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        addSubviews()
        setConstraints()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        configureButtons()
        
    }
    
    @objc func addButtonTapped() {
        print("Change Language")
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureButtons() {
        for button in [uzbekButton, englishButton] {
            button.backgroundColor = .clear
            button.layer.borderWidth = 1.0
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
            button.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        }
        setUpButtonUI()
    }
    
    @objc func changeLanguage(sender: UIButton) {
        if sender == uzbekButton {
            UD.isUzbek = true
            setUpButtonUI()
        } else {
            UD.isUzbek = false
            setUpButtonUI()
        }
    }
    
    func setUpButtonUI() {
        if UD.isUzbek {
            uzbekButton.layer.borderColor = blueColor.cgColor
            uzbekButton.layer.borderWidth = 1.5
            englishButton.layer.borderColor = blueColor.withAlphaComponent(0.5).cgColor
            englishButton.layer.borderWidth = 1.0
        } else {
            englishButton.layer.borderColor = blueColor.cgColor
            englishButton.layer.borderWidth = 1.5
            uzbekButton.layer.borderColor = blueColor.withAlphaComponent(0.5).cgColor
            uzbekButton.layer.borderWidth = 1.0
        }
    }
    
    private func addSubviews() {
        view.addSubview(topView)
        view.addSubview(semesterLabel)
        view.addSubview(lineView1)
        view.addSubview(addButton)
        view.addSubview(uzbekButton)
        view.addSubview(englishButton)
        view.addSubview(lineView2)
    }
    
    private func setConstraints() {
        topView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(14)
            make.height.equalTo(5)
            make.width.equalTo(50)
        }
        
        semesterLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(topView.snp.bottom).offset(16)
        }
        
        lineView1.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.top.equalTo(semesterLabel.snp.bottom).offset(16)
            make.height.equalTo(1)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-(33 + padding))
            make.height.equalTo(60)
        }
        
        uzbekButton.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(58)
        }
        
        englishButton.snp.makeConstraints { make in
            make.top.equalTo(uzbekButton.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(58)
        }
        
        lineView2.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(addButton.snp.top).offset(-15)
            make.height.equalTo(1)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else {
            if translation.y >= -20 {
                view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
            } else {
                view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y - 20)
            }
            
            if sender.state == .ended {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
            return
        }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                // Velocity fast enough to dismiss the uiview
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 375)
                }
            }
        }
    }


}
