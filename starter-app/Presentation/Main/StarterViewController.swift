//
//  StarterViewController.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import Foundation
import UIKit

public final class StarterViewController: UIViewController {
    public struct Props: Equatable {
        
        static let initial = StarterViewController.Props()
    }
    
    private var props = StarterViewController.Props.initial
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func render(props: StarterViewController.Props) {
        self.props = props
        view.setNeedsLayout()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}
