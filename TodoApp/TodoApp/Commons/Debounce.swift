//
//  Debounce.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import Foundation

// https://stackoverflow.com/a/60127933
// enum Debounce<T: Equatable> {
//    static func input(_ input: T, delay: TimeInterval = 0.3, current: @escaping @autoclosure () -> T, perform: @escaping (T) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            guard input == current() else { return }
//            perform(input)
//        }
//    }
// }

// https://daddycoding.com/2020/03/10/ios-tutorial-debounce-your-network-call/

public class Debouncer: NSObject {
    private var callback: () -> Void
    private var delay: Double
    private weak var timer: Timer?

    public init(delay: Double, callback: @escaping (() -> Void)) {
        self.delay = delay
        self.callback = callback
    }

    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc private func fireNow() {
        callback()
    }

    deinit {
        timer?.invalidate()
    }
}
