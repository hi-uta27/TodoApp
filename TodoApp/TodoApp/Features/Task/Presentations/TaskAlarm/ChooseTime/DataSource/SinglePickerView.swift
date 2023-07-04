//
//  TimePickerViewDataSource.swift
//  TodoApp
//
//  Created by Heligate on 20/06/2023.
//

import UIKit

protocol SinglePickerItem: Hashable {
    var title: String { get }
}

class SinglePickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubview()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configSubview()
    }

    func configSubview() {
        dataSource = self
        delegate = self
    }

    var models: [any SinglePickerItem] = [] {
        didSet {
            reloadAllComponents()
        }
    }

    var didSelect: ((any SinglePickerItem) -> Void)?

    func selecteAt(_ model: any SinglePickerItem) {
        if let index = models.firstIndex(where: { model.title == $0.title }) {
            selectRow(index, inComponent: 0, animated: true)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        models.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let cell = TimePickerCell.initial()
        cell.binding(models[row].title)
        return cell
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelect?(models[row])
    }
}
