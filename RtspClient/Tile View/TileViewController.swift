//
//  TileViewController.swift
//  RtspClient
//
//  Created by Andrew Farquharson on 1/09/21.
//  Copyright © 2021 Andres Rojas. All rights reserved.
//

import UIKit

class TileViewController: UIViewController {

    private lazy var _view: TitleView = {
        let result: TitleView = .init()
        print("load")

        return result
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        print("load")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _view.start()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
