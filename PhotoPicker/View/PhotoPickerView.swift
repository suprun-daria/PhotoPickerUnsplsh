//
//  PhotoPickerView.swift
//  PhotoPicker
//
//  Created by daria.suprun on 10.10.2024.
//

import SwiftUI


struct PhotoPickerView: View {
    @EnvironmentObject var dataModel: PhotoPickerUnsplashViewModel

    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    
    private static let initialColumns = 3
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(dataModel.items) { item in
                        GeometryReader { geo in
                            NavigationLink(destination: PhotoDetailView(item: item)) {
                                PhotoPickerItemView(size: geo.size.width, item: item)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                        .onAppear {
                            if item == dataModel.items.last {
                                dataModel.fetchPhotoBy(collectionId: AppConfig.unsplshShared.editorialCollectionId)
//                                dataModel.fetchPhotosBy(string: "music")
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    dataModel.fetchPhotoBy(collectionId: AppConfig.unsplshShared.editorialCollectionId)
//                    dataModel.fetchPhotosBy(string: "music")
                }
                .alert(dataModel.errorMessage, isPresented: $dataModel.isError) {
                    Button("ok_button", role: .cancel) { }
                }
            }
        }
        .navigationBarTitle("photo_grid_title")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView().environmentObject(PhotoPickerUnsplashViewModel(with: UnsplashService()))
            .previewDevice("iPad (8th generation)")
    }
}
