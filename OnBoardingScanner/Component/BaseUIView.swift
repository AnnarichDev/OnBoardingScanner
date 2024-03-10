//
//  BaseUIView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

class BaseUIView: UIView {
    
    private var _isBuildUI: Bool = false
    private var _frame: CGRect = .null
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _buildUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _buildUI()
        
        if !_frame.equalTo(frame) {
            _frame = frame
            frameDidChange()
        }
    }
    
    // MARK: - Methods
    
    func buildUI() {
        _isBuildUI = true
    }
    
    func frameDidChange() {
        
    }
    
    private func _buildUI() {
        if !_isBuildUI {
            buildUI()
        }
    }
}
