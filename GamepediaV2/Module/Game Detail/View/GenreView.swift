//
//  GenreView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI
import Detail

struct GenreView: View {
    let developerModel: [DetatailDeveloperModel]
    let color = [Color.blue, Color.red, Color.yellow, Color.gray, Color.green, Color.orange]
    var body: some View {
        ScrollView(.horizontal, content: {
            HStack {
                ForEach(0..<developerModel.count) { idx in
                    Button(action: {
                    }, label: {
                        Text(developerModel[idx].name)
                            .font(.subheadline)
                            .bold()
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(color[Int.random(in: 0..<color.count)], lineWidth: 2)
                            )
                    })
                    .frame(height: 30)
                    .padding(.leading, idx == 0 ? 16 : 8)
                    .accentColor(.black)
                }
            }
        })
    }
}
