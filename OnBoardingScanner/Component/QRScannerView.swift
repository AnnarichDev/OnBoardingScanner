//
//  QRScannerView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

import SnapKit
import AVFoundation

protocol QRScannerViewDelegate: AnyObject {
    
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ string: String?)
    func qrScanningDidStop()
    func qrScanningFailed(title: String, message: String)
    func qrScaningPresentAlert()
}

final class QRScannerView: UIView {
    
    weak var delegate: QRScannerViewDelegate?
    
    var captureSession: AVCaptureSession?
    let metadataOutput = AVCaptureMetadataOutput()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialSetup()
    }
    
    init(delegate: QRScannerViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        backgroundColor = .borderColor
        doInitialSetup()
    }

    //MARK: overriding the layerClass to return `AVCaptureVideoPreviewLayer`.
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
}
extension QRScannerView {
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    func startScanning() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession?.startRunning()
        }
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
    }
    
    /// Does the initial setup for captureSession
    private func doInitialSetup() {
        clipsToBounds = true
        captureSession = AVCaptureSession()
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            print("LLOG: AA")
            setupScanner()
        case .denied:
            print("LLOG: bb")
            delegate?.qrScaningPresentAlert()
        case .notDetermined:
            print("LLOG: cc")
            AVCaptureDevice.requestAccess(for: .video) { [weak self] success in
                guard let self else { return }
                if success {
                    self.setupScanner()
                } else {
                    print("Permission denied")
                }
            }
        default: 
            print("LLOG: DD")
            break
        }
        
    }
    
    private func setupScanner() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error)
            return
        }
        
        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            scanningDidFail()
            return
        }

        if (captureSession?.canAddOutput(metadataOutput) ?? false) {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417, .code128]
        } else {
            scanningDidFail()
            return
        }
        
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        startScanning()

    }
    
    func scanningDidFail() {
        delegate?.qrScanningDidFail()
        captureSession = nil
    }
    
    func found(code: String) {
        print("LLOG: code", code)
        delegate?.qrScanningSucceededWithCode(code)
    }
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        stopScanning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
}
