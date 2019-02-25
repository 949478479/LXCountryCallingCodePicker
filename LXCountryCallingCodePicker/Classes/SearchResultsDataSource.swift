//
//  SearchResultsDataSource.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/16.
//  Copyright © 2019 MeChat. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, CallingCodeListDataSourceProtocol {

    var datametaList = [CallingCodeMetadata]()

    func metadata(forRowAt indexPath: IndexPath) -> CallingCodeMetadata {
        return datametaList[indexPath.row]
    }

    private let cellIdentifier = "\(CallingCodeTableViewCell.self)"
}

// MARK: - UITableViewDataSource
extension SearchResultsDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datametaList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CallingCodeTableViewCell
        cell.configure(with: datametaList[indexPath.row])
        return cell
    }
}
