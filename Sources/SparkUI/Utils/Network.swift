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
    private var isShowingConnectionLostAlert = false
    
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
    
    public func startMonitoringInSceneWillConnectToSession() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { path in
            if self.current != path.status {
                
                if self.shouldShowConnectionLostAlert,
                    !self.isShowingConnectionLostAlert,
                    path.status != .satisfied {
                    self.showConnectionLostAlert()
                }
                
                self.current = path.status
                self.didChange.setValue(path.status)
                self.isOnline.getValue = path.status == .satisfied ? true : false
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
    
    public func checkConnectionInSceneDidBecomeActive() {
        guard isMonitoring else { return }
        if self.shouldShowConnectionLostAlert,
            !self.isShowingConnectionLostAlert,
            !isConnected {
            showConnectionLostAlert()
        }
    }
    
    private func showConnectionLostAlert() {
        isShowingConnectionLostAlert = true
        DispatchQueue.main.async {
            let settingsAction = UIAlertAction(title: "Go to Settings", style: .cancel) { (action) in
                self.isShowingConnectionLostAlert = false
                UIApplication.openSettingsApp()
            }
            let tryAgainAction = UIAlertAction(title: "Try again", style: .default) { (action) in
                self.isShowingConnectionLostAlert = false
                self.checkConnectionInSceneDidBecomeActive()
            }
            Alert.show(.alert, title: "Looks like you're offline", message: "Make sure you're connected to wi-fi or check if 'Mobile Data' is turned ON in your phone's Settings", actions: [settingsAction, tryAgainAction], completion: nil)
        }
    }
    
}
