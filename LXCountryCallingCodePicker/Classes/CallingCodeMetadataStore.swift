//
//  CallingCodeMetadataStore.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/16.
//  Copyright © 2019 MeChat. All rights reserved.
//

import Foundation

public class CallingCodeMetadataStore {

    public static var language: Language = .chinese {
        didSet {
            if language != oldValue {
                shared = CallingCodeMetadataStore(language: language)
            }
        }
    }

    public private(set) static var shared = CallingCodeMetadataStore(language: language)

    public let language: Language
    public let groupHeaderTitles: [String]
    public let metadataList: [CallingCodeMetadata]
    public let metadataGroup: [String: [CallingCodeMetadata]]

    private let metadataByRegionCode: [String: CallingCodeMetadata]
    private let metadataListByCallingCode: [String: [CallingCodeMetadata]]

    public init(language: Language = .chinese) {
        let metadataType = language.metadataType
        let metaList = metadataType.metadataList()
        let metaListGroup = metadataType.metadataListGroup(for: metaList)

        self.language = language
        metadataList = metaList
        metadataGroup = metaListGroup
        groupHeaderTitles = metaListGroup.keys.sorted()
        metadataListByCallingCode = Dictionary(grouping: metaList) { $0.callingCode }
        metadataByRegionCode = Dictionary(uniqueKeysWithValues: metaList.map { ($0.regionCode, $0) })
    }
}

public extension CallingCodeMetadataStore {

    func metadataList(forKeyword keyword: String) -> [CallingCodeMetadata] {
        return language.metadataType.filterMetadataList(metadataList, forKeyword: keyword)
    }

    func metadataList(forCallingCode code: String) -> [CallingCodeMetadata]? {
        let code = code.hasPrefix("+") ? code : "+" + code
        return metadataListByCallingCode[code]
    }

    func metadata(forRegionCode code: String) -> CallingCodeMetadata? {
        return metadataByRegionCode[code]
    }

    func flagEmoji(forRegionCode code: String) -> String? {
        return metadata(forRegionCode: code)?.regionFlag
    }
}
