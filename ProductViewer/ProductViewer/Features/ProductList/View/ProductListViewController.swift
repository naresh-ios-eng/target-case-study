//
//  ProductListViewController.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

final class ProductListViewController: UIViewController {
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        item.edgeSpacing = .init(
            leading: nil,
            top: .fixed(2),
            trailing: nil,
            bottom: .fixed(2)
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(
            group: group
        )
        
        let layout = UICollectionViewCompositionalLayout(
            section: section
        )
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.backgroundColor = UIColor.background
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            ProductListItem.self,
            forCellWithReuseIdentifier: ProductListItem.id
        )
        
        return collectionView
    }()
    
    private var viewModel: any ProductListProvidable
    
    weak var coordinator: ProductCoordinatable?
    
    private var loaderProvidable: LoaderProvidable
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: any ProductListProvidable, loaderProvidable: LoaderProvidable) {
        self.viewModel = viewModel
        self.loaderProvidable = loaderProvidable
        super.init(nibName: nil, bundle: nil)
        self.viewModel.set(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.contentInset = UIEdgeInsets(
            top: 20.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0
        )
        
        title = "List"
        view.addAndPinSubview(collectionView)
    }
}

// MARK: - UICollectionViewDelegate -
extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.viewModel.products[indexPath.row]
        coordinator?.openProductDetail(for: product)
    }
}

// MARK: - UICollectionViewDataSource -
extension ProductListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductListItem.id,
            for: indexPath) as? ProductListItem
        else {
            return UICollectionViewCell()
        }
        
        let product = self.viewModel.products[indexPath.row]
        
        cell.listItemView.configure(for: product)
        
        return cell
    }
}

// MARK: -  -
extension ProductListViewController: ViewInteractionDelegate {
    
    /// This function will be used to show / hide the loading indicator on controller when a aysn task started on view model side.
    /// - Parameter loading: true means show loader, false means hide loader.
    func show(loading: Bool) {
        if loading {
            loaderProvidable.present(sender: self.view)
        } else {
            loaderProvidable.dismiss(sender: self.view)
        }
    }
    
    /// This function is used to reload the table or collectionview.
    func reloadUserInterface() {
        self.collectionView.reloadData()
    }
    
    /// This function we can use to show an error popup or toast based on requirement.
    /// - Parameter error: the error message we need to show.
    func show(error: String) {
        /// show alert or toast
    }
    
    /// This function we can use to show an success popup or toast based on requirement.
    /// - Parameter success: the success message we need to show.
    func show(success: String) {
        /// show alert or toast
    }
}
