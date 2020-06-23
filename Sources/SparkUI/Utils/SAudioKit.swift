//
//  SAudioKit.swift
//  
//
//  Created by Alex Nagy on 23/06/2020.
//

import UIKit
import AVFoundation
import SparkUI

public protocol SAudioKitDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?)
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?)
}

public struct SAudioKitDefaults {
    public static let named = "sound"
    public static let ext = "m4a"
}

public class SAudioKit: NSObject {
    
    public static var shared = SAudioKit()
    
    public var delegate: SAudioKitDelegate?
    
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    private let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
    fileprivate var recordTimer: Timer!
    fileprivate var playTimer: Timer!
    
    public var isPlaying: Bool = false
    public var isRecording: Bool = false
    public var recordingUrl: URL?
    
    public let recordTime = Bucket(0)
    public let playTime = Bucket(0)
    
    public override init() {
        super.init()
        isAuth()
    }
    
    private func recordSetup(named: String, ext: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let url = documentDirectory().appendingPathComponent(named.appending(".\(ext)"))
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
            audioRecorder = try AVAudioRecorder(url: url, settings: self.settings)
            audioRecorder.delegate = self as AVAudioRecorderDelegate
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func record(named: String = SAudioKitDefaults.named, ext: String = SAudioKitDefaults.ext, completion: @escaping (Result<Bool, Error>) -> ()) {
        recordSetup(named: named, ext: ext) { (result) in
            switch result {
            case .success(let finished):
                guard finished else {
                    completion(.failure(SAudioRecorderError.somethingWentWrong))
                    return
                }
                guard let recorder = self.audioRecorder else {
                    completion(.failure(SAudioRecorderError.noAudioRecorder))
                    return
                }
                guard !self.isRecording else {
                    completion(.failure(SAudioRecorderError.recording))
                    return
                }
                do {
                    try self.audioSession.setActive(true)
                    self.recordTime.value = 0
                    self.recordTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRecordTimer), userInfo: nil, repeats: true)
                    recorder.record()
                    self.isRecording = true
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    @objc private func updateRecordTimer() {
        if isRecording && !isPlaying {
            recordTime.value += 1
        } else {
            recordTimer.invalidate()
        }
    }
    
    public func stopRecording(completion: @escaping (Result<Bool, Error>) -> ()) {
        audioRecorder.stop()
        isRecording = false
        do {
            try audioSession.setActive(false)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func play(from url: URL? = nil, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard !isRecording else {
            completion(.failure(SAudioRecorderError.recording))
            return
        }
        guard !isPlaying else {
            completion(.failure(SAudioRecorderError.playing))
            return
        }
        guard let recorder = self.audioRecorder else {
            completion(.failure(SAudioRecorderError.noAudioRecorder))
            return
        }
        var choosenUrl = URL(string: "")
        if let url = url {
            choosenUrl = url
        } else {
            choosenUrl = recordingUrl
        }
        if recorder.url.path == choosenUrl?.path && choosenUrl != nil {
            audioPlayer.play()
            isPlaying = true
            playTime.value = 0
            playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayTimer), userInfo: nil, repeats: true)
            completion(.success(true))
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recorder.url)
            audioPlayer.delegate = self as AVAudioPlayerDelegate
            recordingUrl = audioRecorder.url
            audioPlayer.play()
            isPlaying = true
            playTime.value = 0
            playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayTimer), userInfo: nil, repeats: true)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func playNamed(_ named: String = SAudioKitDefaults.named, ext: String = SAudioKitDefaults.ext, completion: @escaping (Result<Bool, Error>) -> ()) {
        let bundle = documentDirectory().appendingPathComponent(named.appending(".\(ext)"))
        let manager = FileManager.default
        guard manager.fileExists(atPath: bundle.path) else {
            completion(.failure(SAudioRecorderError.documentDoesNotExist))
            return
        }
        guard !isRecording else {
            completion(.failure(SAudioRecorderError.recording))
            return
        }
        guard !isPlaying else {
            completion(.failure(SAudioRecorderError.playing))
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bundle)
            audioPlayer.delegate = self as AVAudioPlayerDelegate
            audioPlayer.play()
            isPlaying = true
            playTime.value = 0
            playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayTimer), userInfo: nil, repeats: true)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func playFrom(_ data: Data, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard !isRecording else {
            completion(.failure(SAudioRecorderError.recording))
            return
        }
        guard !isPlaying else {
            completion(.failure(SAudioRecorderError.playing))
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer.delegate = self as AVAudioPlayerDelegate
            audioPlayer.play()
            isPlaying = true
            playTime.value = 0
            playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayTimer), userInfo: nil, repeats: true)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    @objc private func updatePlayTimer() {
        if !isRecording && isPlaying {
            playTime.value += 1
        } else {
            playTimer.invalidate()
        }
    }
    
    public func deleteRecording(named: String = SAudioKitDefaults.named, ext: String = SAudioKitDefaults.ext, completion: @escaping (Result<Bool, Error>) -> ()) {
        let bundle = documentDirectory().appendingPathComponent(named.appending(".\(ext)"))
        let manager = FileManager.default
        guard manager.fileExists(atPath: bundle.path) else {
            completion(.failure(SAudioRecorderError.documentDoesNotExist))
            return
        }
        do {
            try manager.removeItem(at: bundle)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func stopPlaying(completion: @escaping () -> ()) {
        audioPlayer.stop()
        isPlaying = false
        playTimer.invalidate()
        completion()
    }
    
    private func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
    
    @discardableResult
    public func isAuth() -> Bool {
        var result:Bool = false
        AVAudioSession.sharedInstance().requestRecordPermission { (res) in
            result = res == true ? true : false
        }
        return result
    }
    
    public func getRecordedData(named: String = SAudioKitDefaults.named, ext: String = SAudioKitDefaults.ext, completion: @escaping (Result<Data, Error>) -> ()) {
        let bundle = documentDirectory().appendingPathComponent(named.appending(".\(ext)"))
        let manager = FileManager.default
        guard manager.fileExists(atPath: bundle.path) else {
            completion(.failure(SAudioRecorderError.documentDoesNotExist))
            return
        }
        guard !isRecording else {
            completion(.failure(SAudioRecorderError.recording))
            return
        }
        guard !isPlaying else {
            completion(.failure(SAudioRecorderError.playing))
            return
        }
        guard let data = FileManager.default.contents(atPath: bundle.path) else {
            completion(.failure(SAudioRecorderError.noData))
            return
        }
        completion(.success(data))
    }
    
}

extension SAudioKit: AVAudioRecorderDelegate {
    
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recordingUrl = nil
        isRecording = false
        recordTimer.invalidate()
        delegate?.audioRecorderDidFinishRecording(recorder, successfully: flag)
    }
    
    public func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        delegate?.audioRecorderEncodeErrorDidOccur(recorder, error: error)
    }
}

extension SAudioKit: AVAudioPlayerDelegate {
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        playTimer.invalidate()
        delegate?.audioPlayerDidFinishPlaying(player, successfully: flag)
    }
    
    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        delegate?.audioPlayerDecodeErrorDidOccur(player, error: error)
    }
    
}

public struct SAudioRecorderError {
    public static let documentDoesNotExist = NSError(domain: "Document Does Not Exist", code: 1, userInfo: nil)
    public static let recording = NSError(domain: "Recording", code: 1, userInfo: nil)
    public static let playing = NSError(domain: "Playing", code: 1, userInfo: nil)
    public static let somethingWentWrong = NSError(domain: "Something went wrong", code: 1, userInfo: nil)
    public static let noAudioRecorder = NSError(domain: "No audio recorder", code: 1, userInfo: nil)
    public static let noData = NSError(domain: "No data", code: 1, userInfo: nil)
}

