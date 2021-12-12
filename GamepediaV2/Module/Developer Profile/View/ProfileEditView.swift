//
//  ProfileEditView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import SwiftUI

struct EditProfile: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingEmptyFieldAlert = false
    @State private var showImagePicker = false
    @State var name = ""
    @State var email = ""
    @State var emptyField = ""
    @State var image: Image?
    @State var localImage: UIImage?
    let presenter = ProfilePresenter()
    var body: some View {
        VStack {
            ZStack {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .background(Color.gray)
                    .clipShape(Circle())
                Image("layer")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .opacity(0.1)
                Image(systemName: "pencil")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10)
                    .opacity(0.8)
                    .onTapGesture {
                        self.showImagePicker = true
                    }
            }
            .padding(.vertical, 8)
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundColor(.white)
                    .opacity(0.2)
                VStack(alignment: .leading) {
                    Text("Nama: ")
                        .font(.callout)
                    TextField("Masukkan Nama", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    Text("Email: ")
                        .font(.callout)
                        .padding(.top, 16)
                    TextField("Masukkan Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            print("save action")
                            if email.isEmpty && name.isEmpty {
                                self.emptyField = "nama dan email"
                                self.showingEmptyFieldAlert.toggle()
                            } else if name.isEmpty {
                                self.emptyField = "nama"
                                self.showingEmptyFieldAlert.toggle()
                            } else if email.isEmpty {
                                self.emptyField = "email"
                                self.showingEmptyFieldAlert.toggle()
                            } else {
                                let newImage = localImage?.jpegData(compressionQuality: 0.1) ?? UIImage(systemName: "person")?.jpegData(compressionQuality: 0.1)
                                presenter.saveAllData(name: name, email: email, image: newImage!)
                                presenter.synchronize()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("Simpan")
                                .font(.headline)
                                .frame(width: 110, height: 40)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        })
                        Spacer()
                        Button(action: {
                            presenter.deleteAllData() ? resetData() : print("tidak berhasil")
                            presenter.synchronize()
                        }, label: {
                            Text("Reset Data")
                                .font(.headline)
                                .frame(width: 110, height: 40)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                        })
                        Spacer()
                    }
                    .padding(.top, 32)
                    .frame(height: 64)
                }
                .padding(.horizontal, 30)
            }
        }
        .onAppear(perform: {
            name = presenter.getName()
            email = presenter.getEmail()
            image = Image(uiImage: UIImage(data: presenter.getImage()) ?? UIImage(systemName: "person")!)
        })
        .alert(isPresented: $showingEmptyFieldAlert) {
            Alert(title: Text("Perhatian"), message: Text("Data \(emptyField) sepertinya kosong"), dismissButton: .default(Text("ok")))
        }
        .sheet(isPresented: $showImagePicker, onDismiss: takeImage, content: {
            GetLocalImage(image: self.$localImage)
        })
        .navigationBarTitle("Edit Profile", displayMode: .inline)
    }
    func takeImage() {
        guard let localImage = localImage else {
            return
        }
        image = Image(uiImage: localImage)
    }
    func resetData() {
        name = ""
        email = ""
        image = Image(uiImage: UIImage(systemName: "person")!)
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
