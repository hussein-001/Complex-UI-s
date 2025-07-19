//
//  SpotifyApp.swift
//  Spotify
//
//  Created by Hussien Awada on 27/06/2025.
//

import SwiftUI

@main
struct SpotifyApp: App {
    var body: some Scene {
        WindowGroup {
            SpotifyHomeView()
        }
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
