//
//  Asyn_ImageView.swift
//  THE WiLL
//
//  Created by Taimur imam on 08/09/23.
//

import SwiftUI
import CachedAsyncImage


struct Asyn_ImageView_demo: View {
    var url = ""
    var width = 0
    var height = 0
    var cornerRedious = 0
    var body: some View {
          //  GeometryReader {  geo in
                CachedAsyncImage(url: URL(string: url ) , urlCache: .imageCache ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: CGFloat( height))
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .clipped()
                        .cornerRadius(CGFloat(cornerRedious))
                } placeholder: {
                    ProgressView()
                }
          //  }
        }
    }


struct Asyn_ImageView: View {
    var url = ""
    var width = 0
    var height = 0
    var cornerRedious = 0
    var body: some View {
          //  GeometryReader {  geo in
                CachedAsyncImage(url: URL(string: url ) , urlCache: .imageCache ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill) 
                        .frame(height: CGFloat( height))
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                        .cornerRadius(CGFloat(cornerRedious))

                } placeholder: {
                    ProgressView()
                }
          //  }
        }
    }


struct Asyn_profile_ImageView: View {
    var url = ""
    var width = 0
    var height = 0
    var cornerRedious = 0
    var body: some View {
          //  GeometryReader {  geo in
                CachedAsyncImage(url: URL(string: url ) , urlCache: .imageCache ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: CGFloat( height))
                        .frame(width: CGFloat( width))
                        .cornerRadius(CGFloat(width/2))
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
          //  }
        }
    }



struct Asyn_ImageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView() 
    }
}
