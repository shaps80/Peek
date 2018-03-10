//
//  ViewController.swift
//  NotTwitter
//
//  Created by Shaps Benkau on 10/03/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit
import Peek

public final class TimelineViewController: UITableViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.accessibilityHint = "New Message"
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "com.152percent.notTwitter.newMessage"
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: Peek
extension TimelineViewController {
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // iOS 10 now requires device motion handlers to be on a UIViewController
        view.window?.peek.handleShake(motion)
    }
    
}
