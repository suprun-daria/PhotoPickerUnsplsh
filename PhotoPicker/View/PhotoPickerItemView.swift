//
//  File.swift
//  PhotoPicker
//
//  Created by daria.suprun on 10.10.2024.
//

import SwiftUI


struct PhotoPickerItemView: View {
    let size: Double
    let item: UnsplashPhoto

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: item.urlBy(kind: .small) ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}
