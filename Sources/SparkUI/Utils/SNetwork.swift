//
//  SNetwork.swift
//  
//
//  Created by Alex Nagy on 22/05/2020.
//

import Network

public struct NetworkMonitor {
    static let status = Bucket(NWPath.Status.requiresConnection)
    static let isExpensive = Bucket(true)
}

public class SNetwork: NSObject {
    
    let monitor: NWPathMonitor?
    
    public init(connectionType: NWInterface.InterfaceType) {
        monitor = NWPathMonitor(requiredInterfaceType: connectionType)
        super.init()
        onNext()
        start()
    }
    
    public init() {
        monitor = NWPathMonitor()
        super.init()
        onNext()
        start()
    }
    
    func onNext() {
        guard let monitor = monitor else { return }
        monitor.pathUpdateHandler = { path in
            NetworkMonitor.status.value = path.status
            NetworkMonitor.isExpensive.value = path.isExpensive
        }
    }
    
    func start() {
        guard let monitor = monitor else { return }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
