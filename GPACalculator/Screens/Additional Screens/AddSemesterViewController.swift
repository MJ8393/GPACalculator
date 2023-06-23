//
//  FilterViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

var unSelectedSemesters = [SemesterModel]()

class AddSemesterViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var padding: CGFloat = 20
    var onDoneBlock : (([SemesterModel]) -> Void)?
    var addUniverSubject : (([[SubjectModel]]) -> Void)?
    var isUniversity: Bool = false
    var selectedUniversity: Int = -1
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineColor")!
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    lazy var semesterLabel = MainLabel(text: "Add Semester", textColor: UIColor(named: "LabelColor")!, textAlignment: .center, font: UIFont(name: "Poppins-Regular", size: 16)!)
    
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
    
    lazy var addButton = MainButton(title: "Add")
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setData()
        setupViews()
        addSubviews()
        setConstraints()
    }
    
    init(isSubject: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isUniversity = isSubject
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setData() {
        unSelectedSemesters = []
        let availableSemesters = semesters.map { $0.name }
        for sem in allsemesters {
            if !availableSemesters.contains(sem.name) {
                unSelectedSemesters.append(sem)
            }
        }
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
        
        tableView.register(SemesterTableViewCell.self, forCellReuseIdentifier: SemesterTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        if isUniversity {
            addUniverSubject!(subjects[selectedUniversity]!)
            dismiss(animated: true)
            return
        }
        
        var markSemesters = [SemesterModel]()
        for semester in unSelectedSemesters {
            guard let marked = semester.isMarked else { return }
            if marked {
                markSemesters.append(semester)
                if let index = unSelectedSemesters.firstIndex(of: semester) {
                    unSelectedSemesters.remove(at: index)
                }
            }
        }
        onDoneBlock!(markSemesters)
        dismiss(animated: true)
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else {
            return
        }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1000 {
                // Velocity fast enough to dismiss the uiview
                onDoneBlock!([])
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

extension AddSemesterViewController {
    private func addSubviews() {
        view.addSubview(topView)
        view.addSubview(semesterLabel)
        view.addSubview(lineView1)
        view.addSubview(lineView2)
        view.addSubview(addButton)
        view.addSubview(tableView)
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
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(lineView1.snp.bottom)
            make.bottom.equalTo(lineView2.snp.top)
        }
    }
}

extension AddSemesterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isUniversity ? universities.count : unSelectedSemesters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SemesterTableViewCell.reuseID, for: indexPath) as? SemesterTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if isUniversity {
            cell.setUniversities(index: indexPath.row, isUniversity: true)
            cell.univerTapped = { [weak self] index in
                if self!.selectedUniversity != -1 {
                    let indexPath = IndexPath(item: self!.selectedUniversity, section: 0)
                    if let cell = tableView.cellForRow(at: indexPath) as? SemesterTableViewCell {
                        cell.mainImageView.image = UIImage(named: "off")
                        cell.isOn = false
                    }
                }
                if index != -1 {
                    self?.selectedUniversity = index
                } else {
                    self?.selectedUniversity = -1
                }
            }
        } else {
            cell.setData(semester: unSelectedSemesters[indexPath.row], index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
