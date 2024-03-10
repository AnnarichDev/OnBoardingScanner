//
//  HeaderDetailView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

final class HeaderDetailView: UIView {
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PassCodeView init(coder:) has not been implemented")
    }
}

private extension HeaderDetailView {
    
    func setUpViews() {
        setUpLayout()
        stackView.axis = .vertical
        stackView.spacing = 4.0
        titleLabel.text = "Happy new year :D"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = .black
        detailLabel.numberOfLines = 0
        detailLabel.text = "Have a nice day ^^"
        detailLabel.font = UIFont.systemFont(ofSize: 14.0)
        detailLabel.textColor = .black
    }
    
    func setUpLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubviews(titleLabel, detailLabel)
    }
}
