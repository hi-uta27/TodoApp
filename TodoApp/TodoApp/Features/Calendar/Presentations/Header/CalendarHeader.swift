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

    var touchUpInsideTodoButton: (() -> Void)!
    var touchUpInsideCompletedButton: (() -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        todoButton.roundCorners(with: 4)
        completedButton.roundCorners(with: 4)
        backgroundContentView.roundCorners(with: 4)
        completedButton.border(width: 2, color: UIColor(named: "979797") ?? .white)
    }
}

extension CalendarHeader {
    @IBAction private func touchUpInsideTodoButton(_ sender: Any) {
        configButton(todoButton, backgroundColor: UIColor(named: "8687E7"), with: 0, borderColor: .clear)
        configButton(completedButton, backgroundColor: .clear, with: 2, borderColor: UIColor(named: "979797"))
        touchUpInsideTodoButton?()
    }

    @IBAction private func touchUpInsideCompletedButton(_ sender: Any) {
        configButton(completedButton, backgroundColor: UIColor(named: "8687E7"), with: 0, borderColor: .clear)
        configButton(todoButton, backgroundColor: .clear, with: 2, borderColor: UIColor(named: "979797"))
        touchUpInsideCompletedButton?()
    }

    private func configButton(_ button: UIButton, backgroundColor: UIColor?, with: CGFloat, borderColor: UIColor?) {
        button.backgroundColor = backgroundColor
        button.border(width: with, color: borderColor ?? .white)
    }
}
