//
//  CallingCodeMetadata.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/15.
//  Copyright © 2019 MeChat. All rights reserved.
//

import Foundation

public class CallingCodeMetadata: Decodable {

    /// 国家（地区）旗帜，例如 "🇨🇳"
    public let regionFlag: String
    /// 国家（地区）名称，例如 "中国"
    public let regionName: String
    /// 国家（地区）编码，例如 "CN"
    public let regionCode: String
    /// 国家（地区）区号，例如 "+86"
    public let callingCode: String

    class var resource: String {
        fatalError()
    }

    class func metadataList() -> [CallingCodeMetadata] {
        return _metadataList() as [CallingCodeMetadata]
    }

    class func metadataListGroup(for list: [CallingCodeMetadata]) -> [String: [CallingCodeMetadata]] {
        fatalError()
    }

    class func filterMetadataList(_ list: [CallingCodeMetadata], forKeyword keyword: String) -> [CallingCodeMetadata] {
        fatalError()
    }

    static func _metadataList<T: CallingCodeMetadata>() -> [T] {
        let resourceURL = resourcesBunlde.url(forResource: resource, withExtension: nil)!
        let data = try! Data(contentsOf: resourceURL)
        let metadataList = try! JSONDecoder().decode([T].self, from: data)
        return metadataList
    }

    static func trimmingKeyword(_ keyword: String) -> String {
        return String(keyword.trimmingCharacters(in: .whitespaces).split(separator: " ").first!)
    }
}

// MARK: -
extension CallingCodeMetadata {

    enum RegExpType: String {
        case number = "^\\+?\\d+$"
        case letter = "^[a-zA-Z]+$"
        case chinese = "^[\\u4e00-\\u9fa5]+$"
    }

    static func evaluateText(_ text: String, with regExp: RegExpType) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regExp.rawValue).evaluate(with: text)
    }
}
