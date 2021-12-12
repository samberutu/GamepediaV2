//
//  ScreenShootCard.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ScreenShotCard: View {
    let imageURL: String
    let width: CGFloat
    private var image: some View {
        Group {
            WebImage(url: URL(string: imageURL))
                .placeholder(content: {
                    ProgressView()
                })
                .onFailure(perform: { error in
                    print("error: \(error.localizedDescription)")
                })
                .resizable()
                .cornerRadius(10)
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width/2, alignment: .center)
                .clipped()
        }
        .frame(width: width, height: width/2)
    }
    init(screenShotURL: String, width: CGFloat) {
        self.imageURL = screenShotURL
        self.width = width
    }
    var body: some View {
        image
    }
}

struct ScreenShotCard_Previews: PreviewProvider {
    static var previews: some View {
        ScreenShotCard(screenShotURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png", width: UIScreen.screenWidth-64)
    }
}

struct ScreenShootPreview: View {
    let screenshot: [ShortScreenshotModel]
    var body: some View {
        ScrollView(.horizontal, content: {
            HStack {
                ForEach(0..<screenshot.count) { idx in
                    ScreenShotCard(screenShotURL: screenshot[idx].image, width: UIScreen.screenWidth-64)
                        .padding(.leading, idx == 0 ? 16 : 0)
                }
            }
        })
        .frame(height: 100)
    }
}
