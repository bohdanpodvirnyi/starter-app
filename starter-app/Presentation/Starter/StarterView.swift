//
//  StarterViewController.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 15.04.2023.
//

import SwiftUI

// MARK: - View
public struct StarterView: View {
    @State
    var props = StarterView.Props.initial
    
    public var body: some View {
        EmptyView()
            .background(Color.cyan)
            .onAppear {
                props.onAppear.perform()
            }
    }
}

// MARK: - Props
extension StarterView {
    @Observable
    class Props: ViewProps {
        var onAppear: Command
        
        init(onAppear: Command) {
            self.onAppear = onAppear
        }
        
        func update(props: Props) {
            self.onAppear = props.onAppear
        }
        
        static let initial = StarterView.Props(onAppear: .empty)
    }
}

protocol ViewProps: AnyObject {
    func update(props: Self)
}
