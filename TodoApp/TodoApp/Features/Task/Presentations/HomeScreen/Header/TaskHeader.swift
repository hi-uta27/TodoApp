//
//  TaskHeader.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import UIKit

class TaskHeader: UITableViewHeaderFooterView {
    static let identifier = "TaskHeader"
    @IBOutlet private var label: UILabel!
    @IBOutlet private var backgroundStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundStackView.roundCorners(with: 6)
    }

    @IBAction private func touchUpInsideHeader(_ sender: Any) {
        print(Self.self, #function, "This feature is under development")
    }
}

extension TaskHeader {
    func binding(_ title: String) {
        label.text = title
    }
}
