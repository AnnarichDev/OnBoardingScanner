//
//  PaginationView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

struct PaginationViewModel {
    
    let menu: PaginationHeaderViewCellModel
    let view: UIView
}

protocol PaginationViewDelegate: AnyObject {
    
    func paginationDidSelected(_ index: Int)
}

final class PaginationView: UIView {
    
    weak var delegate: PaginationViewDelegate?
    
    private let containerStackView = UIStackView()
    private var containerViews: [UIView] = []
    private let scrollView = UIScrollView()
    private let paginationStackView = UIStackView()
    private let headerView = UIView() // PaginationHeaderView()
    private var customSegmentedControl: CustomSegmentedControl?
    private let models: [PaginationViewModel]
    private var selectedPageIndex: Int = 0 {
        didSet {
            delegate?.paginationDidSelected(selectedPageIndex)
        }
    }
    
    init(models: [PaginationViewModel]) {
        self.models = models
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PaginationView init(coder:) has not been implemented ")
    }
    
    private func setUpView() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .equalSpacing
        containerStackView.alignment = .center
        
        containerStackView.backgroundColor = .clear
        
        headerView.backgroundColor = .clear        
        scrollView.backgroundColor = .clear
        
        setUpScrollView()
        setUpPaginationStackView()
        setUpLayout()
    }
    
    private func setUpScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
    }
    
    private func setUpPaginationStackView() {
        paginationStackView.axis = .horizontal
        paginationStackView.distribution = .fillEqually
        paginationStackView.alignment = .fill
        paginationStackView.backgroundColor = .clear
    }
    
    private func setUpLayout() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubviews(headerView, scrollView)
        if models.count == PaginationHeaderView.maxItems {
            let horizontalPadding = 40.0
            let amountItems = models.count
            let screenWidth = UIScreen.main.bounds.width - horizontalPadding
        }
        
        headerView.snp.makeConstraints {
            $0.height.equalTo(60.0)
            $0.width.equalTo(self.snp.width).inset(15.0)
        }
        scrollView.addSubview(paginationStackView)
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        paginationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
        }
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        configuration()
    }
    
    func configuration() {
        var menus: [PaginationHeaderViewCellModel] = []
        var items: [CustomSegmentedControl.CustomSegmentedModel] = []
        models.forEach { model in
            menus.append(model.menu)
            let view = model.view
            paginationStackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.width.equalTo(snp.width)
            }
            items.append(CustomSegmentedControl.CustomSegmentedModel(title: model.menu.title ?? ""))
        }
        let didSelected: ((Int) -> Void) = { [weak self] index in
            self?.handleDidSelectItem(with: index)
        }
                
        customSegmentedControl = CustomSegmentedControl(items: items, didSelected: didSelected)
        
        guard let customSegmentedControl else { return }
        headerView.addSubview(customSegmentedControl)
        customSegmentedControl.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10.0)
        }
    }
}

private extension PaginationView {
    
    func handleDidSelectItem(with index: Int) {
        guard !paginationStackView.arrangedSubviews.isEmpty else { return }
        let pageView = paginationStackView.arrangedSubviews[index]
        let offsetX = pageView.frame.origin.x - scrollView.contentInset.right
        let contentOffset = CGPoint(x: offsetX, y: scrollView.contentOffset.y)
        selectedPageIndex = index
        scrollView.setContentOffset(contentOffset, animated: true)
    }
}

extension PaginationView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let selectedPageIndex = paginationStackView.arrangedSubviews.firstIndex(
            where: { $0.frame.origin.x == scrollView.contentOffset.x }
        ) {
            self.selectedPageIndex = selectedPageIndex
            guard let customSegmentedControl else { return }
            customSegmentedControl.selectItem(with: selectedPageIndex)
        }
    }
}
