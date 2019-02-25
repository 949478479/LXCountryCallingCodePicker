//
//  CallingCodeTableViewCell.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/15.
//  Copyright © 2019 MeChat. All rights reserved.
//

import UIKit

class CallingCodeTableViewCell: UITableViewCell {

    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var codeLabel: UILabel!

    func configure(with metadata: CallingCodeMetadata) {
        countryLabel?.text = metadata.regionFlag + " " + metadata.regionName
        codeLabel?.text = metadata.callingCode
    }
}
