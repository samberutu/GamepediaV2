//
//  PlatformLogo.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI
import Detail

struct PlatformLogo: View {
    let parentPlarform: [DetailParentPlatformModel]
    let myPlatform = ["android", "mac", "linux", "nintendo", "playstation", "windows", "xbox", "ios", "pc"]
    var body: some View {
        ScrollView(.horizontal, content: {
            HStack {
                ForEach(0..<parentPlarform.count) { idx in
                    if myPlatform.contains(where: {$0 == parentPlarform[idx].platform.slug}) {
                        Image(parentPlarform[idx].platform.slug)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)                    }
                }
            }
        })
        .frame(height: 20)
    }
}
