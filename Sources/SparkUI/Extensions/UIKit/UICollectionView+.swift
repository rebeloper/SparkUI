//
//  UICollectionView+.swift
//  
//
//  Created by Alex Nagy on 01/07/2020.
//

import UIKit

public extension UICollectionView {
    
    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor?) -> UICollectionView {
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func systemBackgroundColor() -> UICollectionView {
        self.backgroundColor = .systemBackground
        return self
    }
    
    @discardableResult
    func systemWhiteBackgroundColor() -> UICollectionView {
        self.backgroundColor = .systemWhite
        return self
    }
    
    @discardableResult
    func systemBlackBackgroundColor() -> UICollectionView {
        self.backgroundColor = .systemBlack
        return self
    }
    
    @discardableResult
    func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool = true) -> UICollectionView {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return self
    }
    
    @discardableResult
    func hidesVerticalScrollIndicator(_ hidesVerticalScrollIndicator: Bool = true) -> UICollectionView {
        self.showsVerticalScrollIndicator = !hidesVerticalScrollIndicator
        return self
    }
    
    @discardableResult
    func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool = true) -> UICollectionView {
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return self
    }
    
    @discardableResult
    func hidesHorizontalScrollIndicator(_ hidesHorizontalScrollIndicator: Bool = true) -> UICollectionView {
        self.showsHorizontalScrollIndicator = !hidesHorizontalScrollIndicator
        return self
    }
    
    @discardableResult
    func enablePaging(_ isPagingEnabled: Bool = true) -> UICollectionView {
        self.isPagingEnabled = isPagingEnabled
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIViewController?) -> UICollectionView {
        self.delegate = delegate as? UICollectionViewDelegate
        return self
    }
    
    @discardableResult
    func dataSource(_ dataSource: UIViewController?) -> UICollectionView {
        self.dataSource = dataSource as? UICollectionViewDataSource
        return self
    }
    
    @discardableResult
    func registerCell(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) -> UICollectionView {
        self.register(cellClass.self, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func registerSupplementaryView(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) -> UICollectionView {
        self.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func dragInteractionEnabled(_ dragInteractionEnabled: Bool) -> UICollectionView {
        self.dragInteractionEnabled = dragInteractionEnabled
        return self
    }
    
    @discardableResult
    func dragDelegate(_ dragDelegate: UIViewController?) -> UICollectionView {
        self.dragDelegate = dragDelegate as? UICollectionViewDragDelegate
        return self
    }
    
    @discardableResult
    func dropDelegate(_ dropDelegate: UIViewController?) -> UICollectionView {
        self.dropDelegate = dropDelegate as? UICollectionViewDropDelegate
        return self
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadSectionsOnMainThread(_ sections: IndexSet) {
        DispatchQueue.main.async {
            self.reloadSections(sections)
        }
    }
    
    func reloadItemsOnMainThread(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.reloadItems(at: indexPaths)
        }
    }
}
