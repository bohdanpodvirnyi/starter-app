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
        let onAppear: Command
        
        static let initial = StarterViewController.Props(onAppear: .empty)
    }
    
    private var props = StarterViewController.Props.initial
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        props.onAppear.perform()
    }
    
    func render(props: StarterViewController.Props) {
        self.props = props
        view.setNeedsLayout()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

private extension StarterViewController {
    func setupUI() {
        view.backgroundColor = .cyan
    }
}
