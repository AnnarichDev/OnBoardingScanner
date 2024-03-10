//
//  CustomSegmentedControl.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

final class CustomSegmentedControl: UIView {
    
    enum SegmentedControlTheme {
        
        case underline
    }
    
    struct CustomSegmentedModel {
        
        let title: String
        let icon: UIImage?
        
        init(title: String, icon: UIImage? = nil) {
            self.title = title
            self.icon = icon
        }
    }
    
    private var items: [CustomSegmentedModel]
    private var buttons: [UIButton] = []
    private var selectorView = UIView()
    private let theme: SegmentedControlTheme
    private var buttonViews: [UIButton] = []
    
    var textColor = UIColor.lightGray
    var selectorViewColor = UIColor.secondaryColor
    var selectorTextColor = UIColor.secondaryColor
    var didSelected: ((Int) -> Void)?
    var font: UIFont = UIFont.systemFont(ofSize: 20.0)
    
    private(set) var selectedIndex: Int = 0
    
    init(
        theme: SegmentedControlTheme = .underline,
        items: [CustomSegmentedModel],
        defaultIndex: Int = 0,
        didSelected: ((Int) -> Void)?
    ) {
        self.theme = theme
        self.items = items
        self.didSelected = didSelected
        selectedIndex = defaultIndex
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.masksToBounds = true
        updateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectorView.backgroundColor = .secondaryColor
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            let item = self.items[buttonIndex]
            if button == sender {
                let selectorPosition = frame.width / CGFloat(items.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                didSelected?(selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    if let icon = item.icon {
                        button.setImage(icon, for: .normal)
                    }
                    self.selectorView.frame.origin.x = selectorPosition
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

// Configuration View
private extension CustomSegmentedControl {
    
    func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    func configStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.items.count)
        addSubview(selectorView)
        let selectorPosition = frame.width / CGFloat(items.count) * CGFloat(selectedIndex)
        selectorView.snp.makeConstraints {
            $0.width.equalTo(selectorWidth)
            $0.height.equalTo(4.0)
            $0.bottom.equalToSuperview()
            $0.left.equalTo(selectorPosition)
        }
    }
    
    func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(item.title, for: .normal)
            button.addTarget(
                self,
                action: #selector(CustomSegmentedControl.buttonAction(sender:)),
                for: .touchUpInside
            )
            button.layer.masksToBounds = true
            button.titleLabel?.font = font
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = OnBoardingScannerFont.text
            buttons.append(button)
        }
        
        // Set default select title
        buttons[selectedIndex].setTitleColor(selectorTextColor, for: .normal)
        didSelected?(selectedIndex)
    }
}

extension CustomSegmentedControl {
    
    func selectItem(with index: Int) {
        guard index < items.count, index != selectedIndex else { return }
        selectedIndex = index
        updateView()
    }
}
