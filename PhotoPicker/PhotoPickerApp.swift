//
//  PhotoPickerApp.swift
//  PhotoPicker
//
//  Created by daria.suprun on 07.10.2024.
//

import SwiftUI

@main
struct PhotoPickerApp: App {
    @StateObject var dataModel = PhotoPickerUnsplashViewModel(with: UnsplashService())

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PhotoPickerView()
            }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}
