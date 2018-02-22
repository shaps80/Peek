//
//  File.swift
//  Peek-Example
//
//  Created by Shaps Benkau on 21/02/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit

internal final class InspectorViewController: UIViewController {
    
    internal let tableView: UITableView
    private var navigationBarEffectsView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var tabBarEffectsView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    internal init() {
        tableView = UITableView(frame: .zero, style: .grouped)
        super.init(nibName: nil, bundle: nil)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareTabBar()
        prepareNavigationBar()
        prepareNavigationItems(animated: false)
    }
    
    // MARK: Unused
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Reporting
extension InspectorViewController {
    
    private func prepareNavigationItems(animated: Bool) {
        if tableView.isEditing {
            tableView.allowsMultipleSelection = true
            
            let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(endReport))
            navigationItem.setLeftBarButton(cancel, animated: animated)
            
            let send = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendReport))
            navigationItem.setRightBarButton(send, animated: animated)
            
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationBarEffectsView.backgroundColor = .editingTint
                self.navigationController?.navigationBar.tintColor = .white
            }
        } else {
            tableView.allowsMultipleSelection = false
            
//            let settings = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showSettings))
//            navigationItem.setLeftBarButton(settings, animated: animated)
            navigationItem.setLeftBarButton(nil, animated: animated)
            
            let report = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(beginReport))
            navigationItem.setRightBarButton(report, animated: animated)
            
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationBarEffectsView.backgroundColor = .inspectorBackground
                self.navigationController?.navigationBar.tintColor = .secondaryTint
            }
        }
    }
    
    @objc private func beginReport() {
        tableView.setEditing(true, animated: true)
        prepareNavigationItems(animated: true)
    }
    
    @objc private func sendReport() {
        let sheet = UIActivityViewController(activityItems: ["Peek"], applicationActivities: nil)
        
        sheet.completionWithItemsHandler = { [weak self] type, success, activities, error in
            if success {
                self?.endReport()
            }
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    @objc private func endReport() {
        tableView.setEditing(false, animated: true)
        prepareNavigationItems(animated: true)
    }
    
    @objc private func showSettings() {
        print("Show settings no implemented")
    }
    
}

// MARK: - Bars
extension InspectorViewController {
    
    private func prepareNavigationBar() {
        view.addSubview(navigationBarEffectsView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor), equal(\.topAnchor)
        ])
        
        topLayoutGuide.bottomAnchor.constraint(equalTo: navigationBarEffectsView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func prepareTabBar() {
        view.addSubview(tabBarEffectsView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor), equal(\.bottomAnchor)
        ])
        
        bottomLayoutGuide.topAnchor.constraint(equalTo: tabBarEffectsView.topAnchor, constant: 0).isActive = true
    }
    
}

// MARK: - Table View Prep
extension InspectorViewController {
    
    private func prepareTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 44
        tableView.estimatedSectionFooterHeight = 0
        tableView.allowsSelectionDuringEditing = true
        tableView.backgroundColor = .inspectorBackground
        tableView.separatorColor = UIColor(white: 1, alpha: 0.1)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.bottomAnchor), equal(\.topAnchor)
        ])
    }
    
}

extension InspectorViewController: UITableViewDelegate {
    
    
}

extension InspectorViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath)"
        cell.textLabel?.textColor = UIColor(white: 0.9, alpha: 1)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
}
