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
                Text("Настройки аккаунта")
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
                    AsyncImage(
                        url: viewModel.userModel?.profilePicUrl,
                        transaction: Transaction(animation: .spring()))
                    { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(.white.opacity(0.5))
                                .scaledToFit()
                                .blendMode(.overlay)
                        case .success(let image):
                            Rectangle()
                                .fill(.clear)
                                .scaledToFit()
                                .background(
                                    image
                                        .resizable()
                                        .scaledToFill()
                                )
                        case .failure:
                            Rectangle()
                                .fill(.white.opacity(0.5))
                                .scaledToFit()
                                .background(
                                    Image(systemName: "wifi.slash")
                                        .resizable()
                                        .scaledToFill()
                                        .padding(25)
                                        .foregroundColor(.black)
                                )
                                .blendMode(.overlay)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(
                        width: UIScreen.main.bounds.height / 10,
                        height: UIScreen.main.bounds.height / 10
                    )
                    .cornerRadius(15)
                }
                Spacer()
                if (viewModel.userModel?.firstName == nil || viewModel.userModel?.lastName == nil) {
                    RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.5))
                        .blendMode(.overlay)
                        .frame(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.width / 15)
                } else {
                    Text("\(viewModel.userModel!.firstName) \(viewModel.userModel!.lastName)")
                        .font(.system(size: UIScreen.main.bounds.width / 15, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                Spacer()
                    .frame(maxHeight: 10)
                
                if (viewModel.userModel?.username == nil) {
                    RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.5))
                        .blendMode(.overlay)
                        .frame(width: UIScreen.main.bounds.size.width / 2.7, height: UIScreen.main.bounds.width / 21)
                } else {
                    Text("@\(viewModel.userModel!.username)")
                        .font(.system(size: UIScreen.main.bounds.width / 22))
                        .foregroundColor(.white)
                        .blendMode(.overlay)
                }
                Spacer()
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height / 3.5)
            VStack {
                ForEach(viewModel.disclosureRows) { disclosureRow in
                    DisclosureGroup(isExpanded: $flags[disclosureRow.id]) {
                        ForEach (disclosureRow.subRows) { dataSettingsRow in
                            NavigationLink {
                                if dataSettingsRow.settingsMode != .codeConfirm {
                                    DataChangeView(mode: dataSettingsRow.settingsMode)
                                } else {
                                    DataChangeView(viewModel: DataChangeViewModel(secondaryMode: .emailChange), mode: dataSettingsRow.settingsMode)
                                }
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
            
            Group {
                if (viewModel.serverStatus == .loading) {
                    ProgressView("Идет загрузка...")
                        .foregroundColor(.white)
                        .tint(.white)
                } else if (viewModel.serverStatus == .success) {
                    Text("Изображение профиля обновлено")
                        .foregroundColor(ButtonState.active.getColor())
                        .shadow(color: ButtonState.active.getColor(), radius: 10, x: 0, y: 0)
                } else if (viewModel.serverStatus == .error) {
                    Text("Произошла ошибка :(")
                        .foregroundColor(Color(.systemRed))
                        .shadow(color: Color(.systemRed), radius: 20, x: 0, y: 0)
                }
            }
            .padding(.top, UIScreen.main.bounds.height / 8)
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
                self.viewModel.patchPicture(image: image)
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
