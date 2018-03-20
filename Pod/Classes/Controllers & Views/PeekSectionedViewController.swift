//
//  PeekSectionedViewController.swift
//  Peek
//
//  Created by Shaps Benkau on 26/02/2018.
//

import UIKit

internal class PeekSectionedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    internal let tableView: UITableView
    internal unowned let peek: Peek
    
    internal init(peek: Peek) {
        self.peek = peek
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareNavigationBar()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func sectionTitle(for section: Int) -> String {
        return "Peek"
    }
    
    func sectionIsExpanded(for section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InspectorCell", for: indexPath) as? InspectorCell else { fatalError() }
        
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.detailTextLabel?.textColor = .textLight
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.textLabel?.textColor = .neutral
        
        cell.accessoryView = nil
        cell.accessoryType = .none
        cell.editingAccessoryView = nil
        cell.editingAccessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CollapsibleSectionHeaderView") as? CollapsibleSectionHeaderView else { fatalError() }
        header.contentView.backgroundColor = peek.options.theme.backgroundColor
        header.label.text = sectionTitle(for: section)
        header.label.font = UIFont.systemFont(ofSize: 15, weight: .black)
        header.label.textColor = .textLight
        header.setExpanded(sectionIsExpanded(for: section))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionIsExpanded(for: indexPath.section) ? UITableViewAutomaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return peek.previousStatusBarStyle
    }
    
}

extension PeekSectionedViewController {
    
    private func prepareNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = peek.options.theme.backgroundColor
        navigationController?.navigationBar.tintColor = .primaryTint
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17, weight: .regular)
        ]
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
            
            guard navigationController?.viewControllers.count == 1 || self is ReportViewController else {
                navigationItem.largeTitleDisplayMode = .never
                return
            }
            
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
    }
    
    private func prepareTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 44
        tableView.estimatedSectionFooterHeight = 0
        tableView.keyboardDismissMode = .interactive
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = peek.options.theme.backgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.register(InspectorCell.self, forCellReuseIdentifier: "InspectorCell")
        tableView.register(PreviewCell.self, forCellReuseIdentifier: "PreviewCell")
        tableView.register(CollapsibleSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "CollapsibleSectionHeaderView")
        
        view.addSubview(tableView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.bottomAnchor), equal(\.topAnchor)
            ])
    }
    
}
