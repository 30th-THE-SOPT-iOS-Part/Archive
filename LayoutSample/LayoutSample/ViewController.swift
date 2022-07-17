//
//  ViewController.swift
//  LayoutSample
//
//  Created by taekki on 2022/07/15.
//

import UIKit

protocol ReusableCell: AnyObject {
    static var cellIdentifier: String { get }
}

extension ReusableCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableCell {}

// 리스트 형태의 셀
final class ListCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .red
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 그리드 형태의 셀
final class GridCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .blue
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum CellCategory: Int {
    case listCell
    case gridCell
    
    var cellSize: CGSize {
        switch self {
        case .listCell:
            return CGSize(width: 330, height: 180)
        case .gridCell:
            return CGSize(width: 80, height: 150)
        }
    }
}

final class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var tag: CellCategory = .listCell {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.cellIdentifier)
        self.collectionView.register(GridCell.self, forCellWithReuseIdentifier: GridCell.cellIdentifier)
    }
    
    @IBAction func tagButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.tag = .listCell
        case 1:
            self.tag = .gridCell
        default:
            self.tag = .listCell
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.cellIdentifier, for: indexPath) as? ListCell,
              let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.cellIdentifier, for: indexPath) as? GridCell
        else { return UICollectionViewCell() }

        switch tag {
        case .listCell:
            return listCell
        case .gridCell:
            return gridCell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 330, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return tag.cellSize
    }
}
