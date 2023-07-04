//
//  ChooseTimeViewController.swift
//  TodoApp
//
//  Created by Heligate on 20/06/2023.
//

import SwiftDate
import UIKit

class ChooseTimeViewController: BaseViewController {
    @IBOutlet private var backgroundContentView: UIView!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var hourPickerView: SinglePickerView!
    @IBOutlet private var minutePickerView: SinglePickerView!
    @IBOutlet private var kindOfTimePickerView: SinglePickerView!

    private var didSelectTime: ((Int, Int) -> Void)!
    private var selectedDate: Date!

    override func configSubView() {
        print(Self.self, #function)
        backgroundContentView.roundCorners(with: 4)
        saveButton.roundCorners(with: 4)
        hourPickerView.roundCorners(with: 4)
        minutePickerView.roundCorners(with: 4)
        kindOfTimePickerView.roundCorners(with: 4)
        configPickerView()
    }

    private func configPickerView() {
        let hours = TimeSinglePickerItem.hours
        hourPickerView.models = hours
        if let selectedHours = hours.first(where: { $0.title == selectedDate.toFormat("hh") }) {
            hourPickerView.selecteAt(selectedHours)
        }
        hourPickerView.didSelect = { [weak self] hour in
            if let item = hour as? TimeSinglePickerItem {
                let hourValue = item.value
                self?.selectedDate = self?.selectedDate.dateBySet([.hour: hourValue])
            }
        }

        let minutes = TimeSinglePickerItem.minutes
        minutePickerView.models = minutes
        if let selectedMinutes = minutes.first(where: { $0.value == selectedDate.minute }) {
            minutePickerView.selecteAt(selectedMinutes)
        }
        minutePickerView.didSelect = { [weak self] minute in
            if let item = minute as? TimeSinglePickerItem {
                let minuteValue = item.value
                self?.selectedDate = self?.selectedDate.dateBySet([.minute: minuteValue])
            }
        }

        let ampm = KindOfTime.allCases.map { AMPMSinglePickerItem($0) }
        kindOfTimePickerView.models = ampm
        if let selectedKindOfTime = ampm.first(where: { $0.title == selectedDate.toFormat("a") }) {
            kindOfTimePickerView.selecteAt(selectedKindOfTime)
        }
        kindOfTimePickerView.didSelect = { [weak self] ampm in
            if let item = ampm as? AMPMSinglePickerItem {
                let ampmValue = item.value
                self?.selectedDate = ampmValue == .AM ? self?.selectedDate.toAM() : self?.selectedDate.toPM()
            }
        }
    }

    override func shoudClose() -> Bool {
        navigationController?.popSlideDown()
        return false
    }

    @IBAction private func touchUpInsideSaveButton(_ sender: Any) {
        print(Self.self, #function)
        didSelectTime?(selectedDate.hour, selectedDate.minute)
        dismiss(animated: true)
    }
}

extension ChooseTimeViewController {
    static func initialize(hour: Int?, minute: Int?,
                           didSelectTime: @escaping (Int, Int) -> Void) -> Self
    {
        let viewController = initial()
        let today = Date()
        if let hour = hour, let minute = minute {
            viewController.selectedDate = today.dateBySet([.hour: hour, .minute: minute])
        } else {
            viewController.selectedDate = today
        }

        viewController.didSelectTime = didSelectTime
        return viewController
    }
}

extension UIViewController {
    func presentChooseTime(hour: Int?, minute: Int?,
                           didSelectTime: @escaping (Int, Int) -> Void,
                           complete: (() -> Void)?)
    {
        let viewController = ChooseTimeViewController.initialize(hour: hour, minute: minute, didSelectTime: didSelectTime)
        present(viewController, animated: true)
    }
}
