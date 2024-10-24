//
//  PhotoDetailView.swift
//  PhotoPicker
//
//  Created by daria.suprun on 10.10.2024.
//

import SwiftUI

struct PhotoDetailView: View {
    let item: UnsplashPhoto

    var body: some View {
        AsyncImage(url: URL(string: item.urlBy(kind: .small) ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}
