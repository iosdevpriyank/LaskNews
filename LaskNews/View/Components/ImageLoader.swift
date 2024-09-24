//
//  ImageLoader.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 23/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    var imageURL: URL
    @State private var imageLoaded: Bool = false
    
    var body: some View {
        WebImage(url: imageURL, options: [.scaleDownLargeImages, .avoidAutoSetImage]) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
        } placeholder: {
            if !imageLoaded {
                Image(systemName: "photo.badge.exclamationmark.fill")
                    .foregroundStyle(.systemError)
                    .frame(width: 80, height: 80)
            } else {
                CustomizedProgressView()
            }
        }
        .onSuccess { _,_,_ in
            DispatchQueue.main.async {
                imageLoaded = true
            }
        }
        .onFailure { error in
            DispatchQueue.main.async {
                imageLoaded = false
            }
        }
        .onAppear {
            SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 20
            SDImageCache.shared.config.maxDiskSize = 1024 * 1024 * 100
        }
        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
    }
}

#Preview {
    ImageLoader(imageURL: URL(string:"https://www.google.com/image.png")!)
}
