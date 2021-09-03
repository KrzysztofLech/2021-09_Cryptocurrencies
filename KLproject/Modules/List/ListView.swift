//
//  ListView.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit
import SnapKit

protocol ListViewDelegate: AnyObject {
    func didChangeSortMethod(_ sortMethod: SortMethod)
}

final class ListView: UIView {
    
    var isDataPlaceholderHidden = true {
        willSet {
            tableView.backgroundView = newValue ? nil : noDataPlaceholderLabel
        }
    }
    
    weak var delegate: ListViewDelegate?
    
    // MARK: - UI Components -
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Name", "Volume", "24h Change"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = AppColor.background
        segmentedControl.selectedSegmentTintColor = AppColor.text
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.background ?? .red], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.text ?? .red], for: .normal)
        segmentedControl.addTarget(self, action: #selector(didSegmentedControlValueChange), for: .valueChanged)
        return segmentedControl
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
        addSegmentedControl()
        addTableView()
    }
    
    private func addSegmentedControl() {
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    private func addTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions -
    
    @objc private func didSegmentedControlValueChange() {
        guard let sortMethod = SortMethod.init(rawValue: segmentedControl.selectedSegmentIndex)
        else { return }
        
        delegate?.didChangeSortMethod(sortMethod)
    }
}
