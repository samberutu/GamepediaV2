//
//  ProfileView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, content: {
                Image("samlo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .padding(.vertical, 20)
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundColor(.blue)
                        .opacity(0.2)
                    VStack(spacing: 10) {
                        Text("Samlo Berutu")
                            .font(.title)
                            .bold()
                        Text("samlo.14117132@student.itera.ac.id")
                            .foregroundColor(Color.black)
                    }
                    .padding(.top, 40)
                }
            })
            .navigationBarTitle("Profile", displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
