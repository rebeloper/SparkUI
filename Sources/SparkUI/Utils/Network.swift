//
//  Network.swift
//  
//
//  Created by Alex Nagy on 22/05/2020.
//

import UIKit
import Network

public class Network {
    
    // MARK: - Properties
    
    public static let status = Network()
    
    var monitor: NWPathMonitor?
    
    public var shouldShowConnectionLostAlert = true
    
    public var isMonitoring = false
    public var current = NWPath.Status.requiresConnection
    
    public let didChange = Bucket(NWPath.Status.requiresConnection)
    public let isOnline = Bucket(false)
    
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
    
    
    // MARK: - Init & Deinit
    
    private init() { }
    
    
    deinit {
        stopMonitoring()
    }
    
    
    // MARK: - Method Implementation
    
    public func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { path in
            if self.current != path.status {
                
                if self.shouldShowConnectionLostAlert, path.status != .satisfied {
                    self.showConnectionLostAlert()
                }
                
                self.current = path.status
                self.didChange.value = path.status
                self.isOnline.value = path.status == .satisfied ? true : false
            }
        }
        
        isMonitoring = true
    }
    
    
    public func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
    
    public func checkConnection() {
        guard isMonitoring, let monitor = monitor else { return }
        if self.shouldShowConnectionLostAlert, !isConnected {
            showOfflineAlert()
        }
    }
    
    private func showConnectionLostAlert() {
        DispatchQueue.main.async {
            let settingsAction = UIAlertAction(title: "Go to Settings", style: .cancel) { (action) in
                UIApplication.openSettingsApp()
            }
            Alert.show(.alert, title: "You are offline", message: "Connect to the internet", actions: [settingsAction], completion: nil)
        }
    }
    
}
