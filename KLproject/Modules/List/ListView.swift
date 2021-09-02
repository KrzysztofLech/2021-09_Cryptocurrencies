//
//  ListView.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit
import SnapKit

final class ListView: UIView {
    
    var isDataPlaceholderHidden = true {
        willSet {
            tableView.backgroundView = newValue ? nil : noDataPlaceholderLabel
        }
    }
    
    // MARK: - UI Components -
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.color = AppColor.text
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = AppColor.background
        return tableView
    }()
    
    private let noDataPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textColor =  AppColor.text
        label.text = "No data"
        return label
    }()
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup -
    
    private func setup() {
        backgroundColor = AppColor.background
        isDataPlaceholderHidden = false
    }
    
    // MARK: - Layout -
    
    private func defineLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(tableView)
        }
    }
    
    // MARK: - Public methods -
    
    func showActivityIndicator(_ show: Bool) {
        if show {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
        
        tableView.isUserInteractionEnabled = !show
    }
}
