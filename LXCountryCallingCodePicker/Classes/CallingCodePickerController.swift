//
//  CallingCodePickerController.swift
//  LXCountryCallingCodePicker
//
//  Created by 吕小怼 on 2019/2/16.
//  Copyright © 2019 MeChat. All rights reserved.
//

import UIKit

public class CallingCodePickerController: UINavigationController {

    public override var title: String? {
        didSet {
            contentController.title = title
        }
    }
    
    /// 默认 0.5 s
    public var searchDelay: TimeInterval {
        get {
            return contentController.searchDelay
        }
        set {
            contentController.searchDelay = newValue
        }
    }

    public var tableView: UITableView {
        return contentController.tableView
    }

    public var searchBar: UISearchBar {
        return contentController.searchBar
    }

    public var didSelectMetadata: ((CallingCodeMetadata) -> Void)?

    private let contentController: CallingCodeListViewController

    public init() {
        contentController = UIStoryboard(name: "CallingCodePicker", bundle: resourcesBunlde)
            .instantiateInitialViewController() as! CallingCodeListViewController
        super.init(nibName: nil, bundle: nil)
        viewControllers.append(contentController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CallingCodePickerController {

    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

let resourcesBunlde: Bundle = {
    let bundle = Bundle(for: CallingCodePickerController.self)
    let bundleName = bundle.object(forInfoDictionaryKey: "CFBundleName") as! String
    return Bundle(path: bundle.bundlePath +  "/\(bundleName).bundle")!
}()
