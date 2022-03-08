//
//  AccountSettingsView.swift
//  Academatica
//
//  Created by Roman on 13.02.2022.
//

import SwiftUI

struct AccountSettingsView: View {
    @StateObject var viewModel: AccountSettingsViewModel
    @State private var heightOfset: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    @State private var flags: [Bool] = [false, false]
    @State var image: Image? = nil
    @State var showImagePicker: Bool = false
    
    var body: some View {
        if (!UIAccessibility.isReduceTransparencyEnabled) {
            UITableView.appearance().backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            UITableView.appearance().backgroundView = blurEffectView
            
            //if you want translucent vibrant table view separator lines
            UITableView.appearance().separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
            UITableView.appearance().frame = UITableView.appearance().frame.inset(by: UIEdgeInsets(top: 800, left: 8, bottom: 8, right: 8))
        }
        return ScrollView {
            ZStack {
                Text("Настройки Аккаунта")
                    .font(.system(size: UIScreen.main.bounds.height / 50, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                Button(action: {
                    dismiss()
                }, label: {
                    SmothArrow()
                        .fill(.white)
                        .frame(width: 11, height: 20)
                })
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.horizontal, 26)
            VStack(spacing: 0) {
                Spacer()
                Button {
                    showImagePicker.toggle()
                } label: {
                    Image("young-girls")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: UIScreen.main.bounds.height / 10,
                            height: UIScreen.main.bounds.height / 10
                        )
                        .cornerRadius(15)
                }
                Spacer()
                Text("\(viewModel.userModel.firstName!) \(viewModel.userModel.lastName!)")
                    .font(.system(size: UIScreen.main.bounds.width / 15, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer()
                    .frame(maxHeight: 10)
                Text("@\(viewModel.userModel.userName!)")
                    .font(.system(size: UIScreen.main.bounds.width / 22))
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                Spacer()
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height / 3.5)
            VStack {
                ForEach(viewModel.disclosureRows) { disclosureRow in
                    DisclosureGroup(isExpanded: $flags[disclosureRow.id]) {
                        ForEach (disclosureRow.subRows) { dataSettingsRow in
                            NavigationLink {
                                DataChangeView(mode: dataSettingsRow.settingsMode)
                            } label: {
                                Text(dataSettingsRow.title)
                                    .padding(.bottom, dataSettingsRow.isLast ? 5 : 0)
                                    .padding(.top, dataSettingsRow.id == disclosureRow.subRows[0].id ? 5 : 0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            if (!dataSettingsRow.isLast) {
                                Divider()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .padding(.vertical, 5)
                    } label: {
                        HStack {
                            Image(systemName: disclosureRow.icon)
                            Text(disclosureRow.title)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                self.flags[disclosureRow.id].toggle()
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    if (disclosureRow.id == 0) {
                        Divider()
                    }
                }
            }
            .accentColor(.black)
            .padding(20)
            .background(.white.opacity(0.1))
            .background(VisualEffectView(effect: UIBlurEffect(style: .light)))
            .cornerRadius(25)
            .padding(.horizontal, 20)
            .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 0)
            
        }
        .background(
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: viewModel.colors[0], location: 0),
                        .init(color: viewModel.colors[1], location: 1.1)
                    ]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading)
        )
        .navigationBarHidden(true)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.image = Image(uiImage: image)
            }
        }
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountSettingsView(viewModel: AccountSettingsViewModel())
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
