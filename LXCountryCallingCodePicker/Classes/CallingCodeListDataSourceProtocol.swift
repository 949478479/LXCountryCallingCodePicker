//
//  CallingCodeListDataSourceProtocol.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/5/27.
//

import UIKit

protocol CallingCodeListDataSourceProtocol: UITableViewDataSource {
    func metadata(forRowAt indexPath: IndexPath) -> CallingCodeMetadata
}
