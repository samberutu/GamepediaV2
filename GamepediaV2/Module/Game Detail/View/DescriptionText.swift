//
//  DescriptionText.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI

struct DescriptionText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var text: String
    let lineLimit: Int
    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "read less" : " read more"
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .onAppear(perform: {
                    DispatchQueue.main.async {
                        text = text.html2String
                    }
                })
                .font(.subheadline)
                .lineLimit(expanded ? nil : lineLimit)
                .background(
                    Text(text).lineLimit(lineLimit)
                        .background(GeometryReader { visibleTextGeometry in
                            ZStack {
                                Text(self.text)
                                    .background(GeometryReader { fullTextGeometry in
                                        Color.clear.onAppear {
                                            self.truncated = fullTextGeometry.size.height > visibleTextGeometry.size.height
                                        }
                                    })
                            }
                            .frame(height: .greatestFiniteMagnitude)
                        })
                        .hidden()
                )
            if truncated {
                Button(action: {
                    withAnimation {
                        expanded.toggle()
                    }
                }, label: {
                    Text(moreLessText)
                        .foregroundColor(.blue)
                })
            }
        }
    }
}
