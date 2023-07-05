//
//  DetailTaskViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/5/23.
//

import Foundation

class DetailTaskViewController: BaseViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var dateTimeLabel: UIButton!
    @IBOutlet private var categoryTitleLabel: UILabel!
    @IBOutlet private var categoryIconLabel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideCancelButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideRefreshButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideCheckBoxButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideEditTitleButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideDateTimeButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideCategoryButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsidePriorityButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideSubTaskButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideDeleteButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideEditTaskButton(_ sender: Any) {
        print(Self.self, #function)
    }
}
