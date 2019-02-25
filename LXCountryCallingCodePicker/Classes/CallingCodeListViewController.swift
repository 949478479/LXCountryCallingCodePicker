//
//  CallingCodeListViewController.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/15.
//  Copyright © 2019 MeChat. All rights reserved.
//

import UIKit

class CallingCodeListViewController: UITableViewController {

    var searchDelay: TimeInterval = 0.5

    var searchBar: UISearchBar {
        return searchController.searchBar
    }

    private var searchText: String?

    private var language: Language {
        return CallingCodeMetadataStore.language
    }

    @IBOutlet private var noResultLabel: UILabel!
    @IBOutlet private var dataSource: CallingCodeListDataSource!
    @IBOutlet private var searchResultsDataSource: SearchResultsDataSource!
    private let searchController = UISearchController(searchResultsController: nil)
}

// MARK: - 生命周期
extension CallingCodeListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deactiveSearchController() // 解决 self 无法 deinit 的问题
    }
}

// MARK: - 设置视图
private extension CallingCodeListViewController {

    func setupTableView() {
        tableView.backgroundView = noResultLabel
        noResultLabel.text = language.noResultTips
    }

    func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchBar.returnKeyType = .done
        searchBar.autocapitalizationType = .none
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = language.searchBarPlaceholder
        searchBar.tintColor = navigationController?.navigationBar.tintColor
        searchBar.setValue(language.searchBarCancelButtonTitle, forKey: "cancelButtonText")

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }

        definesPresentationContext = true
    }
}

// MARK: - 搜索
private extension CallingCodeListViewController {

    func setSearchText(_ text: String?) {
        searchText = text
    }

    func cancelPendingSearch() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }

    func performSearch(forText text: String, afterDelay delay: TimeInterval) {
        perform(#selector(performSearch(forText:)), with: text, afterDelay: delay)
    }

    @objc func performSearch(forText text: String) {
        if text.isEmpty {
            searchResultsDataSource.datametaList = []
        } else {
            searchResultsDataSource.datametaList = CallingCodeMetadataStore.shared.metadataList(forKeyword: text)
        }

        reloadSearchResultList()
    }

    func reloadSearchResultList() {
        noResultLabel.isHidden = !searchResultsDataSource.datametaList.isEmpty

        if tableView.dataSource !== searchResultsDataSource {
            tableView.dataSource = searchResultsDataSource
        }
        tableView.reloadData()
    }

    func exitSearchResultList() {
        noResultLabel.isHidden = false
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    func deactiveSearchController() {
        if searchController.isActive {
            searchController.isActive = false
        }
    }
}

// MARK: - UISearchResultsUpdating
extension CallingCodeListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else {
            cancelPendingSearch()
            setSearchText(nil)
            return
        }

        guard let text = searchController.searchBar.text, searchText != text else {
            return
        }

        setSearchText(text)

        cancelPendingSearch()
        if text.isEmpty {
            performSearch(forText: text)
        } else {
            performSearch(forText: text, afterDelay: searchDelay)
        }
    }
}

// MARK: - UISearchControllerDelegate
extension CallingCodeListViewController: UISearchControllerDelegate {

    func didDismissSearchController(_ searchController: UISearchController) {
        exitSearchResultList()
    }
}

// MARK: - UITableViewDelegate
extension CallingCodeListViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if
            let dataSource = tableView.dataSource as? CallingCodeListDataSourceProtocol,
            let picker = parent as? CallingCodePickerController
        {
            picker.didSelectMetadata?(dataSource.metadata(forRowAt: indexPath))
        }
    }
}
