//
//  PaginationHeaderViewCell.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

struct PaginationHeaderViewCellModel {
    
    let title: String?
    let icon: UIImage?
    
    init(title: String? = nil, icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
    }
}

final class PaginationHeaderViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let stackView = UIStackView()
    var model: PaginationHeaderViewCellModel?
    
    override var isSelected: Bool {
        didSet {
            let color = UIColor.green
            let backgroundColor: UIColor = isSelected ? color.withAlphaComponent(0.15) : .clear
            let textColor: UIColor = isSelected ? color : .red //.TPCTheme.textCaption
            containerView.backgroundColor = backgroundColor
            titleLabel.textColor = textColor
            if isSelected {
                iconImageView.image = model?.icon?.withRenderingMode(.alwaysTemplate)
                //            iconImageView.tintColor = .TPCTheme.primaryButtonBackgroundActive
            } else {
                iconImageView.image = model?.icon?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func configure(model: PaginationHeaderViewCellModel) {
        self.model = model
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        let attributedText = NSMutableAttributedString(string: model.title ?? "")
        attributedText.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedText.length)
        )
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .center
        //      if isSelected {
        //         titleLabel.textColor = .TPCTheme.textButton
        //         iconImageView.image = model.icon?.withRenderingMode(.alwaysTemplate)
        //         iconImageView.tintColor = .TPCTheme.primaryButtonBackgroundActive
        //      } else {
        //         titleLabel.textColor = .TPCTheme.textCaption
        //         iconImageView.image = model.icon?.withRenderingMode(.alwaysOriginal)
        //      }
    }
    
    private func setUpViews() {
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        
        containerView.backgroundColor = .clear
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4.0
        
        titleLabel.numberOfLines = 0
        //      titleLabel.font = .Primary.regular(style: .small)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10.0)
            $0.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(iconImageView, titleLabel)
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(24.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
