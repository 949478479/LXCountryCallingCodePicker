//
//  ViewController.swift
//  LXCountryCallingCodePicker
//
//  Created by 949478479 on 05/27/2019.
//  Copyright (c) 2019 949478479. All rights reserved.
//

import UIKit
import LXCountryCallingCodePicker

class ViewController: UIViewController {

    @IBOutlet private var codeLabel: UILabel!

    @IBAction func presentCallingCodePicker() {
        CallingCodeMetadataStore.language = .chinese
        let picker = CallingCodePickerController()
        picker.navigationBar.tintColor = .black
        picker.title = "选择国际区号"
        picker.didSelectMetadata = { [weak self] metadata in
            guard let self = self else { return }

            self.codeLabel.text = metadata.regionFlag + " " + metadata.callingCode
            self.dismiss(animated: true, completion: nil)
        }

        present(picker, animated: true, completion: nil)
    }
}
