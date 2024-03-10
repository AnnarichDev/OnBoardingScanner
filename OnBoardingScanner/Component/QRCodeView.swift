//
//  QRCodeView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

protocol QRCodeViewDelegate: AnyObject {
    
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ string: String?)
    func qrScanningDidStop()
    func qrScanningFailed(title: String, message: String)
    func qrScaningPresentAlert()
    func qrDidPickerImage()
}

final class QRCodeView: UIView {
    
    weak var delegate: QRCodeViewDelegate?

    var qrScanner: QRScannerView?
    private let footerView = UIView()
    private let pickerImageButton = UIButton()
    private let stackView = UIStackView()
    private let footerLabel = UILabel()
    private let iconImageView = UIImageView()
    
    init(delegate: QRCodeViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        backgroundColor = .clear
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    private func setUpViews() {
        qrScanner = QRScannerView(delegate: self)

        let image = UIImage(named: "ic-qr-scan", in: Bundle(for: type(of: self)), compatibleWith: nil)
        iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .darkGrayColor
        iconImageView.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.spacing = 0.0

        footerLabel.numberOfLines = 2
        footerLabel.font = OnBoardingScannerFont.text
        let footerMessage = "qr_code_message".localized()
        footerLabel.textColor = .primaryColor
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.36
        paragraphStyle.alignment = .center
        let attributedText = NSMutableAttributedString(string: footerMessage)
        attributedText.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedText.length)
        )
        footerLabel.attributedText = attributedText
        
        let containerPickerButton = UIView()
        containerPickerButton.backgroundColor = .darkTransparent
        containerPickerButton.layer.cornerRadius = 60.0 / 2.0
        containerPickerButton.layer.borderColor = UIColor.whiteColor.cgColor
        containerPickerButton.layer.borderWidth = 3.0
        
        let pickerIcon = UIImage(named: "ic-image-picker", in: Bundle(for: type(of: self)), compatibleWith: nil)
        pickerImageButton.setTitle("", for: .normal)
        pickerImageButton.setImage(pickerIcon, for: .normal)
        pickerImageButton.addTarget(self, action: #selector(didTapPicker), for: .touchUpInside)
        
        footerView.backgroundColor = .clear
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(stackView, containerPickerButton,  iconImageView)
        containerPickerButton.addSubview(pickerImageButton)
        
        stackView.backgroundColor = .clear
        
        let spaceView = UIView()
        spaceView.backgroundColor = .clear
        stackView.addArrangedSubviews(qrScanner ?? UIView(), footerView, spaceView)

        spaceView.snp.makeConstraints {
            $0.height.equalTo(34.0)
        }
        footerView.addSubview(footerLabel)
        
        guard let qrScanner else { return }

        containerPickerButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.0)
            $0.size.equalTo(60.0)
            $0.bottom.equalTo(qrScanner.snp.bottom).inset(16.0)
        }
        
        pickerImageButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50.0)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        footerView.backgroundColor = .clear
        footerView.snp.makeConstraints {
            $0.height.equalTo(80.0)
        }
        
        footerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalTo(qrScanner.snp.centerY)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(220.0)
        }
    }
    
    @objc private func didTapPicker() {
        delegate?.qrDidPickerImage()
    }
}

extension QRCodeView: QRScannerViewDelegate {
    
    func qrScanningDidFail() {
        
    }
    
    func qrScanningSucceededWithCode(_ string: String?) {
        delegate?.qrScanningSucceededWithCode(string)
    }
    
    func qrScanningDidStop() {
        
    }
    
    func qrScanningFailed(title: String, message: String) {
        
    }
    
    func qrScaningPresentAlert() {
        delegate?.qrScaningPresentAlert()
    }
}
