//
//  GFAlertViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

import UIKit

class GFAlertVC: UIViewController {
    
    var addSubjectTapped: ((String) -> Void)?
    
    let containerView = GFAlertContainerView()
    let titleLabel = MainLabel(text: "Add new subject", textColor: UIColor(named: "LabelColor3")!, textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 16)!)
    
    let messageLabel = MainLabel(text: "Add new subject", textColor: UIColor.init(hex: "B1B1B1"), textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 12)!)
    let actionButton = MainButton(title: "Add")
    let cancelButton = MainButton(title: "Cancel")
    let textFieldLabel = MainLabel(text: "Subject name", textColor: UIColor.init(hex: "B1B1B1"), textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 12)!)
    
    lazy var textField = AITextField()
    
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    let padding: CGFloat = 20
    
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        configureTextField()
    }
    
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 104
        containerView.layer.shadowOffset = CGSize(width: 0, height: -7)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            containerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    

    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).offset(-20)
        }
    }


    private func configureActionButton() {
        containerView.addSubview(actionButton)
        containerView.addSubview(cancelButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.layer.cornerRadius = 12
        actionButton.titleLabel!.font = UIFont(name: "Poppins-SemiBold", size: 14)
        actionButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        actionButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(containerView).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        cancelButton.backgroundColor = .clear
        cancelButton.setTitleColor(UIColor(named: "LabelColor3"), for: .normal)
        cancelButton.titleLabel!.font = UIFont(name: "Poppins-SemiBold", size: 14)
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalTo(actionButton.snp.leading).offset(-10)
            make.bottom.equalTo(actionButton)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }


    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"

        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureTextField() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.trailing.leading.equalTo(titleLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(25)
            make.height.equalTo(55)
        }
        
        view.addSubview(textFieldLabel)
        textFieldLabel.backgroundColor = UIColor(named: "BackgroundColor")!
        textFieldLabel.snp.makeConstraints { make in
            make.leading.equalTo(textField).offset(10)
            make.width.equalTo(textFieldLabel.text!.width(withConstrainedHeight: 11, font: textFieldLabel.font) + 12)
            make.centerY.equalTo(textField.snp.top)
        }
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func addTapped() {
        addSubjectTapped!(textField.text ?? "")
        dismiss(animated: true)
    }
}

