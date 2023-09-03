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
    
    private let detailView: WBRegionDetailView
    
    //MARK: - Init
    init(viewModel: WBRegionDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = WBRegionDetailView(frame:.zero,viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        addConstraints()
    }
    private func setView(){
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    /// adding constraints
    private func addConstraints(){
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}
