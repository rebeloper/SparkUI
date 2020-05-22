//
//  Network.swift
//  
//
//  Created by Alex Nagy on 22/05/2020.
//

import Network

public class Network {
    
    public static let status = Network()
    
    public enum MonitoringStatus {
        case none, started, stoped
    }
    
    var monitor: NWPathMonitor?
    
    public var isMonitoring = false
    
    private init() {}
    
    deinit {
        stopMonitoring()
    }
    
    public let monitoringDidChange = Bucket(Network.MonitoringStatus.none)
    public let didChange = Bucket(NWPath.Status.requiresConnection)
    
    public func startMonitoring() {
        guard !isMonitoring else { return }
     
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
     
        monitor?.pathUpdateHandler = { path in
            self.didChange.value = path.status
        }
     
        isMonitoring = true
        monitoringDidChange.value = .started
    }
    
    public func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        monitoringDidChange.value = .stoped
    }
    
    public var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    public var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
     
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
    }
    
    public var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    public var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
}
