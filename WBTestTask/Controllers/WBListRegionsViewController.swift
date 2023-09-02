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
        addConstraints()
        wbListRegionsView.delegate = self
        title = "Регионы России"
        view.backgroundColor = .systemBackground
    }
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
    
    func wbListRegionsView(_ listRegionsView: WBListRegionsView, didSelectRegion region: WBRegion) {
        //opens screen with detail information
        let viewModel = WBRegionDetailViewViewModel(region: region)
        let detailVC = WBRegionDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

