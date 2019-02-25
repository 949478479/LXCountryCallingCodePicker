//
//  CallingCodeListDataSource.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/15.
//  Copyright © 2019 MeChat. All rights reserved.
//

import UIKit

class CallingCodeListDataSource: NSObject, CallingCodeListDataSourceProtocol {

    private let cellIdentifier = "\(CallingCodeTableViewCell.self)"
}

// MARK: - 数据源
extension CallingCodeListDataSource {

    func metadata(forRowAt indexPath: IndexPath) -> CallingCodeMetadata {
        return metadataList(inSection: indexPath.section)[indexPath.row]
    }

    private var metadataGroup: [String: [CallingCodeMetadata]] {
        return CallingCodeMetadataStore.shared.metadataGroup
    }

    private var groupHeaderTitles: [String] {
        return CallingCodeMetadataStore.shared.groupHeaderTitles 
    }

    private func metadataList(inSection section: Int) -> [CallingCodeMetadata] {
        return metadataGroup[groupHeaderTitles[section]]!
    }
}

// MARK: - UITableViewDataSource
extension CallingCodeListDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return metadataGroup.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metadataList(inSection: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CallingCodeTableViewCell
        cell.configure(with: metadata(forRowAt: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupHeaderTitles[section]
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupHeaderTitles
    }
}
