//
//  CalendarHeader.swift
//  TodoApp
//
//  Created by TaHieu on 7/7/23.
//

import UIKit

class CalendarHeader: UITableViewHeaderFooterView {
    static let identifier = "CalendarHeader"

    @IBOutlet private var todoButton: UIButton!
    @IBOutlet private var completedButton: UIButton!
    @IBOutlet private var backgroundContentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        todoButton.roundCorners(with: 4)
        completedButton.roundCorners(with: 4)
        backgroundContentView.roundCorners(with: 4)
        completedButton.border(width: 2, color: UIColor(named: "979797") ?? .white)
    }
}
