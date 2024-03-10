//
//  CodeInputView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 29/2/2567 BE.
//

protocol CodeInputViewDelegate: AnyObject {
    
    func didSubmitted(_ string: String)
    func endEditing()
}

final class CodeInputView: UIView {
    
    weak var delegate: CodeInputViewDelegate?
    private let stackView = UIStackView()
    private let detailLabel = UILabel()
    private let inputTextField = BaseTextField()
    private let submitButton = UIButton()
    private let footerView = UIView()
    private let containerView = UIView()
    
    init() {
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    private func setUpViews() {
        stackView.axis = .vertical
        stackView.spacing = 32.0
        backgroundColor = .clear
        detailLabel.numberOfLines = 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.36
        let attributedText = NSMutableAttributedString(string: "enter_code_invite_message".localized())
        let range = NSRange(location: 0, length: attributedText.length)
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor,
            NSAttributedString.Key.font: OnBoardingScannerFont.text,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        attributedText.addAttributes(attrs, range: range)
        detailLabel.attributedText = attributedText
        
        addSubviews(containerView, footerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubviews(detailLabel, inputTextField)
        stackView.backgroundColor = .clear
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(footerView.snp.top)
        }
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(32.0)
            $0.centerY.equalToSuperview()
        }
        
        inputTextField.snp.makeConstraints {
            $0.height.equalTo(56.0)
        }
        
        footerView.snp.makeConstraints {
            $0.height.equalTo(91.0)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets.bottom).inset(37.0)
        }
        
        setUpTextField()
        setUpFooterView()
    }
    
    private func setUpTextField() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributedText = NSMutableAttributedString(string: "Enter code")
        let range = NSRange(location: 0, length: attributedText.length)
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.dustyGrayColor,
            NSAttributedString.Key.font: OnBoardingScannerFont.text,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        attributedText.addAttributes(attrs, range: range)
        
        inputTextField.backgroundColor = .whiteColor
        inputTextField.attributedPlaceholder = attributedText
        inputTextField.textAlignment = .center
        inputTextField.layer.borderWidth = 1.0
        inputTextField.layer.cornerRadius = 4.0
        inputTextField.layer.borderColor = UIColor.borderColor.cgColor
        inputTextField.returnKeyType = .done
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setUpFooterView() {
        footerView.backgroundColor = .clear
        
        footerView.addSubview(submitButton)
        
        submitButton.backgroundColor = .secondaryColor
        submitButton.setTitle("verify_button_title".localized(), for: .normal)
        submitButton.layer.cornerRadius = 4.0
        submitButton.titleLabel?.font = OnBoardingScannerFont.textBold
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.setEnable(false)
        
        submitButton.snp.makeConstraints {
            $0.height.equalTo(56.0)
            $0.horizontalEdges.equalToSuperview().inset(24.0)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func submitTapped(_ sender: UIButton) {
        let textInput = inputTextField.text ?? ""
        guard !textInput.isEmpty, !textInput.regexSpecailCharacter(), textInput.count >= Helper.minimumCharacter else { return }
        delegate?.endEditing()
        delegate?.didSubmitted(textInput)
    }
}

extension CodeInputView: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        submitButton.setEnable(textField.text?.count ?? 0 > 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let countText = textField.text?.count ?? 0
        delegate?.endEditing()
        
        if countText >= Helper.minimumCharacter {
            delegate?.didSubmitted(textField.text ?? "")
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (string.regexSpecailCharacter() == false)
    }
}
