//
//  PaginationHeaderView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

final class PaginationHeaderView: UIView {

    static let maxItems = 4
    static let defaultTabSize = CGSize(width: 80.0, height: 80.0)

    private var menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var items = [PaginationHeaderViewCellModel]()
    var didSelectItem: ((Int) -> Void)?
    private var initialSelectionMode = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with models: [PaginationHeaderViewCellModel]) {
        items = models
        initialSelectionMode = false
        menuCollectionView.reloadData()
        setUpViews()
    }

    private func setUpViews() {
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self

        menuCollectionView.register(PaginationHeaderViewCell.self)
        menuCollectionView.showsHorizontalScrollIndicator = false
        menuCollectionView.showsVerticalScrollIndicator = false

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .horizontal
        menuCollectionView.collectionViewLayout = layout
        menuCollectionView.backgroundColor = .clear
        addSubview(menuCollectionView)
        menuCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self.snp.width)
        }
        selectFirstItemIfNeeded()
    }

    private func selectFirstItemIfNeeded() {
        guard !initialSelectionMode else {
            return
        }

        initialSelectionMode = true

        let indexPath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }

    func selectItem(with index: Int) {
        guard index < items.count else { return }
        let indexPath = IndexPath(item: index, section: 0)
        menuCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }

    func selectLastItem() {
        guard !items.isEmpty else { return }
        let lastItemIndex = items.count - 1
        selectItem(with: lastItemIndex)
    }
}

// MARK: - UICollectionView

extension PaginationHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeue(forType: PaginationHeaderViewCell.self, at: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(model: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath.row)
    }
}

extension PaginationHeaderView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if items.count == PaginationHeaderView.maxItems {
            let horizontalPadding = 40.0
            let amountItems = items.count
            let screenWidth = UIScreen.main.bounds.width - horizontalPadding
            let widthItem = screenWidth / Double(amountItems)
            if widthItem > 100.0 {
                return CGSize(width: widthItem, height: PaginationHeaderView.defaultTabSize.height)
            } else {
                return CGSize(width: widthItem, height: widthItem)
            }
        } else {
            return PaginationHeaderView.defaultTabSize
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
