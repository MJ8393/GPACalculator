//
//  MainViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit
import SnapKit
import SwipeCellKit


var semesters = [Semester]()

class MainViewController: UIViewController {
    
    var cellTapped : ((Int) -> Void)?
    
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
    
    lazy var imageView = UIImageView(image: UIImage(named: "main"))
    lazy var mainLabel = MainLabel(text: "Please tap + button on the right top of the screen to add semesters ", textColor: UIColor.init(hex: "#B1B1B1"), textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 15)!)
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        addSubviews()
        setContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("xxx")
        
        semesters = DataManager.shared.semesters()
        isEmpty = semesters.isEmpty
        print(isEmpty)
        
        var subjects = [Subject]()
        for semester in semesters {
            print("YYY")
            subjects += DataManager.shared.subjects(semester: semester)
        }
        let (credit, gpa) = calculateGPA(subjects: subjects)
        cLabel2.text = String(credit)
        gLabel2.text = String(format: "%.2f", gpa)

        tableView.reloadData()
    }

    func calculateGPA(subjects: [Subject]) -> (Int, Double) {
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
    
    let cLabel2 = MainLabel(text: "17", textColor: UIColor.init(hex: "F08F5F"), textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 18)!)
    
    let gLabel2 = MainLabel(text: "4.50", textColor: UIColor.init(hex: "F08F5F"), textAlignment: .left, font: UIFont(name: "Poppins-SemiBold", size: 18)!)

    
    @objc private func plusTapped() {
        print("Helloooo")
        let filterVC = AddSemesterViewController(isSubject: false)
        filterVC.modalPresentationStyle = .custom
        filterVC.transitioningDelegate = self
        self.present(filterVC, animated: true, completion: nil)
        filterVC.onDoneBlock = { [weak self] markedSemesters in
            if markedSemesters.isEmpty { return }
            for markedSemester in markedSemesters {
                let semester = DataManager.shared.semester(semester: markedSemester)
                semesters.append(semester)
                DataManager.shared.save()
            }
            semesters = semesters.sorted(by: { $0.key < $1.key })
            self?.tableView.reloadData()
            self?.isEmpty = semesters.isEmpty
        }
    }
    
    private func configureUI() {
        view.backgroundColor =  UIColor(named: "BackgroundColor")
        self.navigationItem.titleView = twoLineTitleView(text: "Semesters")
        navigationController?.backgroundColor(backgroundcolor: UIColor(named: "BackgroundColor")!)
       
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "plus"), style: .done, target: self, action: #selector(plusTapped)), animated: true)
        navigationItem.rightBarButtonItem?.tintColor = blueColor
    }
    
    private func configureTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(mainLabel)
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
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return semesters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseID, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.delegate = self
        cell.setData(sem: semesters[indexPath.row])
        cell.lineView.backgroundColor = UIColor.init(hex: "B8C2C0").withAlphaComponent(0.7)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GradesViewController(index: indexPath.row)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            DataManager.shared.deleteSemester(semester: semesters[indexPath.row])
//            tableView.deleteRows(at: [indexPath], with: .fade)
            semesters.remove(at: indexPath.row)
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.font = UIFont(name: "Poppins-Medium", size: 13)!
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
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

extension MainViewController: UIViewControllerTransitioningDelegate {
    // 2.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let filterPreCont = FilterPresentationController(presentedViewController: presented, presenting: presenting)
        filterPreCont.setHeight(390)
        return filterPreCont
    }
}


