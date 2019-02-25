//
//  Language.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/5/27.
//

import Foundation

public enum Language {

    case chinese
    case english

    var metadataType: CallingCodeMetadata.Type {
        switch self {
        case .chinese:
            return CallingCodeMetadata_zh.self
        case .english:
            return CallingCodeMetadata_en.self
        }
    }


}

extension Language {

    var searchBarPlaceholder: String {
        switch self {
        case .chinese:
            return "地区名称、拼音、代码，区号"
        case .english:
            return "region name or code, calling code"
        }
    }

    var noResultTips: String {
        switch self {
        case .chinese:
            return "无结果"
        case .english:
            return "No Results"
        }
    }

    var searchBarCancelButtonTitle: String {
        switch self {
        case .chinese:
            return "取消"
        case .english:
            return "Cancel"
        }
    }
}
