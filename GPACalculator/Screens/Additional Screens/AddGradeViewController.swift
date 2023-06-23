//
//  AddGradeViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class AddGradeViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var padding: CGFloat = 20
    var onDoneBlock : ((Int) -> Void)?
    var index = 0
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineColor")!
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var semesterLabel = MainLabel(text: "Add grade", textColor: UIColor(named: "LabelColor")!, textAlignment: .center, font: UIFont(name: "Poppins-Regular", size: 16)!)
    
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
    
    lazy var addButton = MainButton(title: "Apply")
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupViews()
        addSubviews()
        setConstraints()
    }
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        print("xxxxxx", index)
        self.index = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    func setupViews() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.register(ChooseGradeCollectionViewCell.self, forCellWithReuseIdentifier: ChooseGradeCollectionViewCell.resuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        onDoneBlock!(index)
        dismiss(animated: true)
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
                onDoneBlock!(0)
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 390)
                }
            }
        }
    }
}

extension AddGradeViewController {
    private func addSubviews() {
        view.addSubview(topView)
        view.addSubview(semesterLabel)
        view.addSubview(lineView1)
        view.addSubview(lineView2)
        view.addSubview(addButton)
        view.addSubview(collectionView)
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
        
        lineView2.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(addButton.snp.top).offset(-15)
            make.height.equalTo(1)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-(33 + padding))
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(lineView1.snp.bottom)
            make.bottom.equalTo(lineView2.snp.top)
        }
    }
}

extension AddGradeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChooseGradeCollectionViewCell.resuseID, for: indexPath) as? ChooseGradeCollectionViewCell else { return UICollectionViewCell() }
        cell.cellIndex = index
        cell.setData(grade: grades[indexPath.row], index: indexPath.row)
        cell.gradeChosen = { [weak self] index in
            let indexPath = IndexPath(item: self!.index, section: 0)
            if self!.index == grades.count - 1 {
                self?.index = index
                return
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? ChooseGradeCollectionViewCell {
                if self?.index == index {
                    return
                }
                cell.mainImageView.image = UIImage(named: "off")
                self?.index = index
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grades.count - 1
    }
}
