//
//  View+Navigation.swift
//  People
//
//  Created by J on 2023-03-03.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func embedInNavigation() -> some View {
        
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
        
    }
}
