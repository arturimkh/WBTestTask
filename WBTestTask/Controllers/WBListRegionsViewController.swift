//
//  ViewController.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import UIKit


/// Controller to show list of Regions
final class WBListRegionsViewController: UIViewController {
    
    private let wbListRegionsView = WBListRegionsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        addConstraints()
        wbListRegionsView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wbListRegionsView.collectionView.reloadData()
    }
    private func setView(){
        title = "Регионы России"
        view.backgroundColor = .systemBackground
    }
    /// adding constraints
    private func addConstraints(){
        view.addSubview(wbListRegionsView)
        NSLayoutConstraint.activate([
            wbListRegionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wbListRegionsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            wbListRegionsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            wbListRegionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WBListRegionsViewController:WBListRegionsViewDelegate{
    
    /// push to detail view controller
    /// - Parameters:
    ///   - listRegionsView: view of region list
    ///   - region: selected region
    func wbListRegionsView(_ listRegionsView: WBListRegionsView, didSelectRegion region: WBRegion) {
        //opens screen with detail information
        let viewModel = WBRegionDetailViewViewModel(region: region)
        let detailVC = WBRegionDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


