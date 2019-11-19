//
//  FavoriteViewController.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    static let storyboardId = "\(FavoriteViewController.self)"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        tableView.register(UINib(nibName: "\(SavedCell.self)", bundle: Bundle.main), forCellReuseIdentifier: SavedCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedCell.reuseIdentifier, for: indexPath) as! SavedCell
        cell.delegate = self
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
}

extension FavoriteViewController: SavedCellDelegate {
    func onDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var detailsVC: UIViewController!
        if #available(iOS 13.0, *) {
            detailsVC = storyboard.instantiateViewController(identifier: DetailsViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            detailsVC = storyboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func onBook() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var detailsVC: UIViewController!
        if #available(iOS 13.0, *) {
            detailsVC = storyboard.instantiateViewController(identifier: BookViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            detailsVC = storyboard.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}

fileprivate extension FavoriteViewController {
    func prepareNavigation() {
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
    }
}
