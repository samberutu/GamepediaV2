//
//  GameCell.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 17/11/21.
//

import SwiftUI
import Home
import SDWebImageSwiftUI

struct GameCard: View {
    var game: HomeGameModel
    private var image: some View {
        Group {
            WebImage(url: URL(string: game.backgroundImage))
                .placeholder(content: {
                    ProgressView()
                })
                .onFailure(perform: { error in
                    print("error: \(error.localizedDescription)")
                })
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
        }
        .cornerRadius(10)
        .frame(width: 100, height: 100)
    }
    init(game: HomeGameModel) {
        self.game = game
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.blue)
                .opacity(0.1)
            HStack(alignment: .center, spacing: 10) {
                image
                    .padding(.leading, 4)
                VStack(alignment: .leading, spacing: 10) {
                    Text(game.name)
                        .font(.headline)
                        .lineLimit(1)
                    Text(game.released)
                        .font(.caption)
                        .lineLimit(1)
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .accentColor(.yellow)
                            .foregroundColor(.yellow)
                        Text("\(String(format: "%.2f", game.rating))/5")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    Text("\(game.reviewsCount) reviewers")
                        .font(.caption)
                        .lineLimit(1)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .padding(.trailing, 4)
            }
            .frame(width: UIScreen.screenWidth - 64, height: 100, alignment: .leading)
        }
        .frame(height: 120)
    }
}
