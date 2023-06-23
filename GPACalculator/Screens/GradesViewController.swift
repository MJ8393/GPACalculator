//
//  GradesViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class GradesViewController: UIViewController {
    
    var subjects = [Subject]()
    var semester: Semester?
    var index = Int()
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var isEmpty: Bool = true {
        didSet {
            if isEmpty {
                imageView.isHidden = false
                mainLabel.isHidden = false
                tableView.isHidden = true
            } else {
                imageView.isHidden = true
                mainLabel.isHidden = true
                tableView.isHidden = false
            }
        }
    }
    
    lazy var imageView = UIImageView(image: UIImage(named: "empty"))
    lazy var mainLabel = MainLabel(text: "Please tap plus button to add more subjects or download button to fetch subjects", textColor: UIColor.init(hex: "#B1B1B1"), textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 15)!)
    
    lazy var bootomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TabBarColor")
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 104
        view.layer.shadowOffset = CGSize(width: 0, height: -7)
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    lazy var addButton = MainButton(title: "Get from database")
    
    let cLabel2 = MainLabel(text: "17", textColor: UIColor.init(hex: "F08F5F"), textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 18)!)
    
    let gLabel2 = MainLabel(text: "4.50", textColor: UIColor.init(hex: "F08F5F"), textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 18)!)

    override func viewDidLoad() {
        super.viewDidLoad()
        if let semester = semester {
            subjects = DataManager.shared.subjects(semester: semester)
            isEmpty = subjects.isEmpty
        }
        update()
        
        configureUI()
        configureTableView()
        addSubviews()
        setConstriants()
    }
    
    init(index: Int) {
        self.index = index
        self.semester = semesters[index]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func downloadTapped() {
        let filterVC = AddSemesterViewController(isSubject: true)
        filterVC.modalPresentationStyle = .custom
        filterVC.transitioningDelegate = self
        self.present(filterVC, animated: true, completion: nil)
        filterVC.addUniverSubject = { [weak self] univerSubjects in
            guard let self = self else { return }
            for (_, subject) in self.subjects.enumerated() {
                DataManager.shared.deleteSubject(subject: subject)
                self.subjects.remove(at: 0)
            }
            
            DataManager.shared.save()
            
            for i in univerSubjects[self.index] {
                let subject = DataManager.shared.subject(name: i.name, grade: i.grade, credits: i.credits, scale: i.scale, semester: self.semester!)
                self.subjects.append(subject)
                DataManager.shared.save()
            }
            self.tableView.reloadData()
            self.isEmpty = semesters.isEmpty
            self.update()
        }
    }
    
    @objc private func plusTapped() {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: "Add new subject", message: "Enter name for the subject to add", buttonTitle: "Add")
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle  = .crossDissolve
            self.present(alertVC, animated: true)
            alertVC.addSubjectTapped = { [weak self] name in
                guard let self = self else { return }
                let subject = DataManager.shared.subject(name: name, grade: "GPA", credits: 0, scale: 0.0, semester: self.semester!)
                self.subjects.append(subject)
                self.isEmpty = self.subjects.isEmpty
                self.tableView.reloadData()
                DataManager.shared.save()
            }
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.navigationItem.titleView = twoLineTitleView(text: semester?.name ?? "")
        navigationController?.backgroundColor(backgroundcolor: UIColor.white)
        
        let testButton : UIButton = UIButton.init(type: .custom)
        testButton.setImage(UIImage(named: "plus"), for: .normal)
        testButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        testButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let addButton = UIBarButtonItem(customView: testButton)
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(backTapped))
        backButton.tintColor = UIColor.init(hex: "38BCF4")
        navigationItem.rightBarButtonItems = [addButton]
        navigationItem.leftBarButtonItem = backButton
        self.addButton.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
    }

    private func setContraints() {
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(214)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(70)
            make.trailing.equalTo(view).offset(-70)
            make.top.equalTo(imageView.snp.bottom).offset(80)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(GradeTableViewCell.self, forCellReuseIdentifier: GradeTableViewCell.reuseID)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(bootomView)
        bootomView.addSubview(addButton)
        view.addSubview(imageView)
        view.addSubview(mainLabel)
        setContraints()
    }
    
    private func setConstriants() {
        tableView.frame = view.bounds
        bootomView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view)
            make.height.equalTo(120)
        }
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(bootomView).offset(20)
            make.trailing.equalTo(bootomView).offset(-20)
            make.bottom.equalTo(bootomView).offset(-33)
            make.height.equalTo(60)
        }
    }
}

extension GradesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GradeTableViewCell.reuseID, for: indexPath) as? GradeTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.index = gradeDict[subjects[indexPath.row].grade ?? "GPA"] ?? 0
        cell.setData(subject: subjects[indexPath.row])
        cell.gradeTapped = { [weak self] result in
            let filterVC = AddGradeViewController(index: result)
            filterVC.modalPresentationStyle = .custom
            filterVC.transitioningDelegate = self
            self?.present(filterVC, animated: true, completion: nil)
            filterVC.onDoneBlock = { [weak self] index in
                print(index)
                cell.gradeView.gradeLabel.text = grades[index].name
                cell.index = index
                self?.subjects[indexPath.row].grade = grades[index].name
                self?.subjects[indexPath.row].scale = grades[index].scale
                DataManager.shared.save()
                self?.update()
                self?.dismiss(animated: true)
            }
        }
        cell.creditView.creditTapped = { [weak self] credit in
            self?.subjects[indexPath.row].credits = Int16(credit)
            DataManager.shared.save()
            self?.update()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let label = MainLabel(text: "Subjects", textColor: UIColor(named: "LabelColor2")!, textAlignment: .left, font: UIFont(name: "Poppins-Bold", size: 15)!)
        let glabel = MainLabel(text: "Grades", textColor: UIColor(named: "LabelColor2")!, textAlignment: .left, font: UIFont(name: "Poppins-Regular", size: 15)!)
        let clabel = MainLabel(text: "Credits", textColor: UIColor(named: "LabelColor2")!, textAlignment: .left, font: UIFont(name: "Poppins-Regular", size: 15)!)
        
        label.frame = CGRect.init(x: 44, y: 15, width: (label.text?.widthOfString(usingFont: label.font)) ?? 0, height: headerView.frame.height)
        glabel.frame = CGRect.init(x: UIScreen.main.bounds.width / 2, y: 15, width: (glabel.text?.widthOfString(usingFont: clabel.font)) ?? 0, height: headerView.frame.height)
        clabel.frame = CGRect.init(x: UIScreen.main.bounds.width / 2 + 40 + CGFloat(glabel.text?.widthOfString(usingFont: clabel.font) ?? 0) , y: 15, width: (clabel.text?.widthOfString(usingFont: clabel.font)) ?? 0, height: headerView.frame.height)
        
        headerView.addSubview(label)
        headerView.addSubview(glabel)
        headerView.addSubview(clabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 150))
        let cLabel1 = MainLabel(text: "Credits:", textColor: UIColor(named: "LabelColor2")!, textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 18)!)
        footerView.addSubview(cLabel1)
        cLabel1.snp.makeConstraints { make in
            make.leading.equalTo(footerView).offset(40)
            make.top.equalTo(footerView).offset(15)
            make.width.equalTo(75)
        }
        
        footerView.addSubview(cLabel2)
        cLabel2.snp.makeConstraints { make in
            make.leading.equalTo(cLabel1.snp.trailing).offset(5)
            make.top.equalTo(footerView).offset(15)
            make.width.equalTo(20)
        }
        
        let gLabel1 = MainLabel(text: "GPA:", textColor: UIColor(named: "LabelColor2")!, textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 18)!)
        footerView.addSubview(gLabel1)
        gLabel1.snp.makeConstraints { make in
            make.leading.equalTo(footerView.snp.centerX).offset(25)
            make.top.equalTo(footerView).offset(15)
            make.width.equalTo(45)
        }
        
        footerView.addSubview(gLabel2)
        gLabel2.snp.makeConstraints { make in
            make.leading.equalTo(gLabel1.snp.trailing).offset(5)
            make.top.equalTo(footerView).offset(15)
            make.width.equalTo(45)
        }
        
        return footerView
    }
}

extension GradesViewController: UIViewControllerTransitioningDelegate {
    // 2.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let filterPreCont = FilterPresentationController(presentedViewController: presented, presenting: presenting)
        filterPreCont.setHeight(390)
        return filterPreCont
    }
    
    func calculateGPA() -> (Int, Double) {
        var creditCount = 0
        var sum: Double = 0.0
        var gpa: Double = 0.0
        for subject in subjects {
            if subject.grade == "GPA" || subject.credits == 0 {
                continue
            }
            creditCount += Int(subject.credits)
            sum += Double(Int(subject.credits)) * subject.scale
        }
        if !(creditCount == 0) {
            gpa = sum / Double(creditCount)
        }
       
        return (creditCount, gpa)
    }
    
    func update() {
        let (numCredits, gpa) = calculateGPA()
        cLabel2.text = String(numCredits)
        gLabel2.text = String(format: "%.2f", gpa)
        semesters[index].credits = Int16(numCredits)
        semesters[index].gpa = gpa
        DataManager.shared.save()
    }
}


