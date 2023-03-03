//
//  SettingsView.swift
//  People
//
//  Created by J on 2023-02-28.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultKeys.haptcisEnabled) private var isHaptcisEnabled: Bool = true
    
    var body: some View {
        Form {
            haptics
        }
        .navigationTitle("Settings")
        .embedInNavigation()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHaptcisEnabled)
    }
}
