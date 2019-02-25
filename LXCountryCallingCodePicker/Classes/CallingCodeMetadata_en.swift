//
//  CallingCodeMetadata_en.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/5/27.
//

import Foundation

class CallingCodeMetadata_en: CallingCodeMetadata {

    override class var resource: String {
        return "CallingCodes_en.json"
    }

    override class func metadataListGroup(for list: [CallingCodeMetadata]) -> [String: [CallingCodeMetadata]] {
        return Dictionary(grouping: list) { String($0.regionName.first!) }.mapValues {
            $0.sorted {
                $0.regionName.localizedStandardCompare($1.regionName) == .orderedAscending
            }
        }
    }

    override class func filterMetadataList(_ list: [CallingCodeMetadata], forKeyword keyword: String) -> [CallingCodeMetadata] {
        let text = trimmingKeyword(keyword)

        if evaluateText(text, with: .number) {
            return list.filter { $0.callingCode.contains(text) }
        }

        if evaluateText(text, with: .letter) {
            let code = text.uppercased()
            let name = text.lowercased()
            return list.filter { $0.regionCode.contains(code) || $0.regionName.contains(name) }
        }

        return []
    }
}
