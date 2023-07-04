import SVPullToRefresh
import UIKit

public extension UIScrollView {
    func configPullToRefreshView() {
//        pullToRefreshView.titleLabel.textColor = .white
//        pullToRefreshView.subtitleLabel.textColor = .white
//        pullToRefreshView.arrowColor = .white
//        pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorView.Style.medium
        pullToRefreshView?.setTitle("Pull To Refresh", for: .stopped)
        pullToRefreshView?.setTitle("Release To Refresh", for: .triggered)
        pullToRefreshView?.setTitle("Loading", for: .loading)
    }

    func stopPullToRefreshAnimation() {
        pullToRefreshView?.stopAnimating()
    }

    func stopInfiniteScrollingAnimation() {
        infiniteScrollingView?.stopAnimating()
    }

    var canLoadMore: Bool {
        get {
            return infiniteScrollingView?.enabled ?? false
        }
        set {
            infiniteScrollingView?.enabled = newValue
        }
    }

    func configPullToRefresh(with actionHandler: @escaping (() -> Void)) {
        self.addPullToRefresh(actionHandler: actionHandler)
    }

    func configLoadMore(with actionHandler: @escaping (() -> Void)) {
        self.addInfiniteScrolling(actionHandler: actionHandler)
    }
}
