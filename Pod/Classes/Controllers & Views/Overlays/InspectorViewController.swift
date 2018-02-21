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
    
    internal init() {
        tableView = UITableView(frame: .zero, style: .grouped)
        super.init(nibName: nil, bundle: nil)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
//        let redView = UIView(frame: view.bounds)
//        view.addSubview(redView)
        prepareTableView()
        prepareNavigationBar()
        prepareTabBar()
    }
    
    private func prepareTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.bottomAnchor), equal(\.topAnchor)
        ])
    }
    
    private func prepareNavigationBar() {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        view.addSubview(effectView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor), equal(\.topAnchor)
        ])
        
        topLayoutGuide.bottomAnchor.constraint(equalTo: effectView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func prepareTabBar() {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        view.addSubview(effectView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor), equal(\.bottomAnchor)
            ])
        
        bottomLayoutGuide.topAnchor.constraint(equalTo: effectView.topAnchor, constant: 0).isActive = true
    }
    
    // MARK: Unused
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InspectorViewController: UITableViewDelegate {
    
}

extension InspectorViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
}
