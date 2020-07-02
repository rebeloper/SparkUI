//
//  Array+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

public extension Array {
    
    /// use case: let filteredContacts = myContacts.filterDuplicates { $0.name == $1.name && $0.phone == $1.phone }
    func filterDuplicates(includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
    
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    mutating func move(from sourceIndex: Index, to destinationIndex: Index) {
        // Don't work for free and use swap when indices are next to each other - this
        // won't rebuild the array and will be super efficient.
        if sourceIndex == destinationIndex { return }
        if abs(destinationIndex - sourceIndex) == 1 { return self.swapAt(sourceIndex, destinationIndex) }
        self.insert(self.remove(at: sourceIndex), at: destinationIndex)
    }
    
    static func empty() -> Array {
        self.init()
    }
    
    mutating func makeEmpty() {
        self.removeAll()
    }
}

public extension Array where Element: Equatable {
    mutating func move(_ element: Element, to destinationIndex: Index) {
        if let oldIndex: Int = self.firstIndex(of: element) { self.move(from: oldIndex, to: destinationIndex) }
    }
}

public extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        self = self.filter({$0 != element})
    }
}

public extension Array where Element: Equatable {
    mutating func remove(elements: [Element]) {
        for element in elements {
            remove(element: element)
        }
    }
}
