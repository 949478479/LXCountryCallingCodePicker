//
//  CallingCodeMetadata_zh.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/5/27.
//

import Foundation

class CallingCodeMetadata_zh: CallingCodeMetadata {

    /// 国家（地区）拼音音节，例如 ["zhong", "guo"]
    private let regionSyllables: [String]

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        regionSyllables = try container.decode([String].self, forKey: .regionSyllables)
        try super.init(from: decoder)
    }

    override class var resource: String {
        return "CallingCodes_zh.json"
    }

    override class func metadataList() -> [CallingCodeMetadata] {
        return _metadataList() as [CallingCodeMetadata_zh]
    }

    override class func metadataListGroup(for list: [CallingCodeMetadata]) -> [String: [CallingCodeMetadata]] {
        let list = list as! [CallingCodeMetadata_zh]
        let group = Dictionary(grouping: list) { String($0.regionSyllables.first!.first!) }.mapValues {
            $0.sorted {
                $0.regionName.localizedStandardCompare($1.regionName) == .orderedAscending
            }
        }
        return group
    }

    override class func filterMetadataList(_ list: [CallingCodeMetadata], forKeyword keyword: String) -> [CallingCodeMetadata] {
        let text = trimmingKeyword(keyword)
        let metaList = list as! [CallingCodeMetadata_zh]

        if evaluateText(text, with: .number) {
            return metaList.filter { $0.callingCode.contains(text) }
        }

        if evaluateText(text, with: .letter) {
            let code = text.uppercased()
            let syllable = text.lowercased()
            return metaList.filter { $0.regionCode.contains(code) || $0.regionSyllables.contains(syllable) }
        }

        if evaluateText(text, with: .chinese) {
            return metaList.filter { $0.regionName.contains(text) }
        }

        return []
    }
}

private extension CallingCodeMetadata_zh {

    enum CodingKeys: String, CodingKey {
        case regionSyllables
    }
}
