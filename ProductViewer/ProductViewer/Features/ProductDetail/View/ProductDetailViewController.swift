//
//  ProductDetailViewController.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ProductDetailProvidable
    private var loaderProvidable: LoaderProvidable
    weak var coordinator: ProductCoordinatable?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureTableView()
        self.setUpNavigationBar()
        self.title = "Detail"
    }
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: any ProductDetailProvidable, loaderProvidable: LoaderProvidable) {
        self.viewModel = viewModel
        self.loaderProvidable = loaderProvidable
        super.init(nibName: nil, bundle: nil)
        self.viewModel.set(delegate: self)
    }
    
    private func setUpNavigationBar() {
        let backItem = UIBarButtonItem(image: UIImage.init(named: "ic_back"), style: .plain, target: self, action: #selector(backButtonPressed(sender: )))
        backItem.tintColor = UIColor.targetRed
        self.navigationItem.setLeftBarButton(backItem, animated: true)
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.coordinator?.navigateBack()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate -
extension ProductDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib.init(nibName: ProductDetailCell.id, bundle: nil), forCellReuseIdentifier: ProductDetailCell.id)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailCell.id, for: indexPath) as? ProductDetailCell else {
            return UITableViewCell()
        }
        cell.bind(productModel: self.viewModel.product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        /// this action is dynamic view, we can have multiple options like, Add to cart, Buy now, Add to watchlist etc
        let actionView = ActionView.initialise(actions: [.addToCart], delegate: self)
        return actionView
    }
}

//MARK: - ViewInteractionDelegate -
extension ProductDetailViewController: ViewInteractionDelegate {
    func show(loading: Bool) {
        if loading {
            self.loaderProvidable.present(sender: self.view)
        } else {
            self.loaderProvidable.dismiss(sender: self.view)
        }
    }
    
    func reloadUserInterface() {
        self.tableView.reloadData()
    }
    
    func show(error: String) {
        
    }
    
    func show(success: String) {
        
    }
}

// MARK: - ActionViewDelegate -
extension ProductDetailViewController: ActionViewDelegate {
    func didTriggeredAction(action: Action) {
        self.viewModel.didTriggeredAction(action: action)
    }
}
