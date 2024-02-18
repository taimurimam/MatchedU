//
//  KFImageView.swift
//  N8 Essential
//
//  Created by Sk Azad on 16/06/23.
//
/*
import SwiftUI
import Kingfisher

struct KFImageView: View {
    let imageURL: String
    let phImage: String
    @Binding var localImg: UIImage?
    let w: CGFloat
    let h: CGFloat
    var cornerRad: CGFloat = 10
    
    var body: some View {
        if let image = localImg {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: w, height: h)
                .clipped()
                .cornerRadius(cornerRad)
        }
        else {
            KFImage(URL(string: formatURLString(imageURL)))
                .placeholder {
                    Image(phImage)
                }
                .onFailure { error in
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: w, height: h)
                .clipped()
                .cornerRadius(cornerRad)
                .progressViewStyle(.circular)
        }
    }
}

*/ 
