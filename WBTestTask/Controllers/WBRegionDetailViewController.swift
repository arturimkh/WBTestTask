//
//  WBRegionDetailViewController.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 01.09.2023.
//

import UIKit


/// Controller to show region detail information
final class WBRegionDetailViewController: UIViewController {

    private let viewModel: WBRegionDetailViewViewModel
    init(viewModel: WBRegionDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
