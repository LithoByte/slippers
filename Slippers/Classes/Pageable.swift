//
//  Pageable.swift
//  LUX
//
//  Created by Elliot Schrock on 4/9/20.
//

import Foundation

public protocol Pageable {
    func nextPage()
    func fetchPage(_ page: Int)
}

public extension Pageable {
    func willDisplayFunction(pageSize: Int = 20, pageTrigger: Int = 5) -> (UITableViewCell, UITableView, IndexPath) -> Void {
        return { (cell: UITableViewCell, tableView: UITableView, indexPath: IndexPath) in
            let previousIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if tableView.indexPathsForVisibleRows?.contains(previousIndexPath) == true {
                let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
                if numberOfRows - indexPath.row == pageTrigger && numberOfRows % pageSize == 0  {
                    self.nextPage()
                }
            }
        }
    }
}

public class Pager: Refreshable, Pageable {
    public var page: Int {
        didSet {
            onPageUpdate?(page)
        }
    }
    private let firstPageValue: Int
    public var onPageUpdate: ((Int) -> Void)?
    
    public init(firstPageValue: Int = 0, onPageUpdate: ((Int) -> Void)?) {
        self.firstPageValue = firstPageValue
        self.page = firstPageValue
        self.onPageUpdate = onPageUpdate
    }
    
    open func refresh() {
        page = firstPageValue
    }
    
    open func nextPage() {
        page += 1
    }
    
    open func fetchPage(_ page: Int) {
        self.page = page
    }
}
