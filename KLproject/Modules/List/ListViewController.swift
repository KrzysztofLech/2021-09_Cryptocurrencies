//
//  ListViewController.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func showAlert(title: String, message: String, errorHandler: @escaping () -> ())
}

final class ListViewController: UIViewController {
    
    // MARK: - Public properties -
    
    weak var delegate: ListViewControllerDelegate?
    
    // MARK: - Private properties -
    
    private let viewModel: ListViewModelProtocol
    private let contentView = ListView()
    
    // MARK: - Lifecycle -
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupView()
        
        fetchData()
    }
    
    // MARK: - Setup view -
    
    private func setupView() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColor.text ?? UIColor.black]
        contentView.tableView.dataSource = self
        contentView.tableView.register(
            ListItemTableViewCell.self,
            forCellReuseIdentifier: ListItemTableViewCell.className)
    }
    
    private func setupTitle() {
        title = viewModel.title
    }
    
    // MARK: - Data methods -
    
    private func fetchData() {
        contentView.showActivityIndicator(true)
        
        viewModel.fetchData() { [weak self] errorText in
            DispatchQueue.main.async {
                self?.contentView.showActivityIndicator(false)
                
                if let errorText = errorText {
                    self?.delegate?.showAlert(
                        title: "Data dwonloading problem!",
                        message: errorText,
                        errorHandler: {
                            self?.fetchData()
                        })
                } else {
                    self?.setupTitle()
                    self?.presentData()
                }
            }
        }
    }
    
    private func presentData() {
        contentView.isDataPlaceholderHidden = !viewModel.cryptocurrencies.isEmpty
        contentView.tableView.reloadData()
    }
}

// MARK: - TableView data source methods -

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptocurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.className, for: indexPath) as? ListItemTableViewCell
        else { return UITableViewCell() }
        let currency = viewModel.cryptocurrencies[indexPath.row]
        let priceChange = viewModel.getPriceChange(atIndex: indexPath.row)
        cell.configure(withCurrency: currency, andPriceChange: priceChange)
        return cell
    }
}
