//
//  GeneralSettings.swift
//  Academatica
//
//  Created by Roman on 11.02.2022.
//

import SwiftUI

struct GeneralSettingsView: View {
    @StateObject var viewModel: GeneralSettingsViewModel
    @State private var heightOfset: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            Group {
                BigBubbleShape()
                    .offset(y: UIScreen.main.bounds.height / 18 + heightOfset*0.05)
                    .fill(LinearGradient(
                        gradient: Gradient(
                            stops: [
                                .init(color: viewModel.colors[0], location: 0),
                                .init(color: viewModel.colors[1], location: 0.5)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                SmallBubbleShape()
                    .offset(
                        x: UIScreen.main.bounds.width / 1.5,
                        y: UIScreen.main.bounds.height / 18 + UIScreen.main.bounds.height / 20  - heightOfset*0.1
                    )
                    .fill(LinearGradient(
                        gradient: Gradient(
                            stops: [
                                .init(color: viewModel.colors[2], location: 0.1),
                                .init(color: viewModel.colors[3], location: 0.3)]),
                        startPoint: .top,
                        endPoint: .bottom))
            }
            .offset(y: -heightOfset*1.1)
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                ZStack {
                    Text("Настройки")
                        .font(.system(size: UIScreen.main.bounds.height / 50, weight: .bold))
                        .foregroundColor(viewModel.colors[4])
                        .padding(.vertical, 10)
                    Button(action: {
                        dismiss()
                    }, label: {
                        SmothArrow()
                            .fill(viewModel.colors[4])
                            .frame(width: 11, height: 20)
                    })
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.horizontal, 26)
                NavigationLink {
                    AccountSettingsView(viewModel: AccountSettingsViewModel())
                } label: {
                    HStack(spacing: 0) {
                        AsyncImage(
                            url: viewModel.userModel?.profilePicUrl,
                            transaction: Transaction(animation: .spring()))
                        { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(.black.opacity(0.5))
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
                                    .fill(.black.opacity(0.5))
                                    .scaledToFit()
                                    .background(
                                        Image(systemName: "wifi.slash")
                                            .resizable()
                                            .scaledToFill()
                                            .padding(25)
                                            .foregroundColor(.white)
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
                        
                        VStack(alignment: .leading, spacing: 2) {
                            if (viewModel.userModel?.firstName == nil || viewModel.userModel?.lastName == nil) {
                                RoundedRectangle(cornerRadius: 10).fill(.black.opacity(0.5))
                                    .blendMode(.overlay)
                                    .frame(width: UIScreen.main.bounds.size.width / 2.7, height: UIScreen.main.bounds.width / 20)
                            } else {
                                Text("\(viewModel.userModel!.firstName) \(viewModel.userModel!.lastName)")
                                    .font(.system(size: UIScreen.main.bounds.width / 20.8, weight: .bold))
                                    .lineLimit(1)
                            }
                            Spacer()
                            Text("\(viewModel.userModel?.firstName ?? "...........") \(viewModel.userModel?.lastName ?? "..........")")
                                .font(.system(size: UIScreen.main.bounds.width / 20.8, weight: .bold))
                                .lineLimit(1)
                                .foregroundColor(.clear)
                                .frame(height: 0.5)
                                .padding(.horizontal, 3)
                                .background(viewModel.colors[4])
                                .cornerRadius(2)
                                .offset(y: -8)
                            if (viewModel.userModel?.email == nil) {
                                RoundedRectangle(cornerRadius: 10).fill(.black.opacity(0.5))
                                    .blendMode(.overlay)
                                    .frame(width: UIScreen.main.bounds.size.width / 2.7, height: UIScreen.main.bounds.width / 31)
                            } else {
                            Text("\(viewModel.userModel!.email)")
                                .font(.system(size: UIScreen.main.bounds.width / 31.25, weight: .thin))
                            }
                            if (viewModel.userModel?.username == nil) {
                                RoundedRectangle(cornerRadius: 10).fill(.black.opacity(0.5))
                                    .blendMode(.overlay)
                                    .frame(width: UIScreen.main.bounds.size.width / 2.7, height: UIScreen.main.bounds.width / 31)
                            } else {
                                Text("@\(viewModel.userModel!.username)")
                                    .font(.system(size: UIScreen.main.bounds.width / 31.25, weight: .thin))
                            }
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 10, alignment: .leading)
                        .transition(.opacity)
                        SmothArrow()
                            .fill(viewModel.colors[4])
                            .rotationEffect(Angle(degrees: 180))
                            .frame(width: 9, height: 15)
                            .padding(.trailing, 5)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding(.top, UIScreen.main.bounds.height / 65)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 0)
                HStack {
                    Image("ringing")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: UIScreen.main.bounds.height / 40,
                            height: UIScreen.main.bounds.height / 40
                        )
                    Text("Звук")
                        .font(.system(size: UIScreen.main.bounds.height / 58, weight: .thin))
                    Toggle("", isOn: $viewModel.toggle)
                        .toggleStyle(SwitchToggleStyle(tint: viewModel.colors[2]))
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .padding(.top, UIScreen.main.bounds.height / 70)
                .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 0)
                Button("Выйти из учётной записи", role: .destructive) {
                    viewModel.logOut()
                }
                .font(.system(size: UIScreen.main.bounds.height / 58))
                .offset(y: UIScreen.main.bounds.height / 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.updatePicture()
        }
    }
}

struct GeneralSettings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GeneralSettingsView(viewModel: GeneralSettingsViewModel())
        }
    }
}

struct BigBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height / 2.6
        path.move(to: CGPoint(x: 0.03863*width, y: 0.82045*height))
        path.addCurve(to: CGPoint(x: 0.29684*width, y: 0.72307*height), control1: CGPoint(x: 0.16889*width, y: 0.92357*height), control2: CGPoint(x: 0.16889*width, y: 0.74885*height))
        path.addCurve(to: CGPoint(x: 0.63414*width, y: 0.99517*height), control1: CGPoint(x: 0.42478*width, y: 0.69729*height), control2: CGPoint(x: 0.43409*width, y: 0.94362*height))
        path.addCurve(to: CGPoint(x: 0.96214*width, y: 0.53403*height), control1: CGPoint(x: 0.8342*width, y: 1.04673*height), control2: CGPoint(x: 1.09939*width, y: 0.67151*height))
        path.addCurve(to: CGPoint(x: 0.70858*width, y: 0.09294*height), control1: CGPoint(x: 0.82489*width, y: 0.39655*height), control2: CGPoint(x: 0.96214*width, y: 0.17027*height))
        path.addCurve(to: CGPoint(x: 0.16889*width, y: 0.09294*height), control1: CGPoint(x: 0.45502*width, y: 0.0156*height), control2: CGPoint(x: 0.21542*width, y: -0.07032*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.3333*height), control1: CGPoint(x: 0.12962*width, y: 0.23074*height), control2: CGPoint(x: 0.04395*width, y: 0.23795*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.39967*height), control1: CGPoint(x: 0, y: 0.35033*height), control2: CGPoint(x: 0, y: 0.375*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.77456*height), control1: CGPoint(x: 0, y: 0.4213*height), control2: CGPoint(x: 0, y: 0.77456*height))
        path.addCurve(to: CGPoint(x: 0.03863*width, y: 0.82045*height), control1: CGPoint(x: 0.0099*width, y: 0.79217*height), control2: CGPoint(x: 0.02258*width, y: 0.80775*height))
        path.closeSubpath()
        return path
    }
}

struct SmallBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width / 2.62
        let height = rect.size.height / 4.7
        path.move(to: CGPoint(x: 0.43363*width, y: 0.95223*height))
        path.addCurve(to: CGPoint(x: 1.18584*width, y: 0.70064*height), control1: CGPoint(x: 0.80531*width, y: 1.06051*height), control2: CGPoint(x: 1.34513*width, y: 0.95223*height))
        path.addCurve(to: CGPoint(x: 1.18584*width, y: 0.23248*height), control1: CGPoint(x: 1.02655*width, y: 0.44904*height), control2: CGPoint(x: 1.4469*width, y: 0.46815*height))
        path.addCurve(to: CGPoint(x: 0.13274*width, y: 0.1656*height), control1: CGPoint(x: 0.92478*width, y: -0.00319*height), control2: CGPoint(x: 0.41593*width, y: -0.10828*height))
        path.addCurve(to: CGPoint(x: 0.43363*width, y: 0.95223*height), control1: CGPoint(x: -0.15044*width, y: 0.43949*height), control2: CGPoint(x: 0.06195*width, y: 0.84395*height))
        path.closeSubpath()
        return path
    }
}

struct SmothArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.0338*width, y: 0.45388*height))
        path.addCurve(to: CGPoint(x: 0.0338*width, y: 0.54612*height), control1: CGPoint(x: -0.01127*width, y: 0.47935*height), control2: CGPoint(x: -0.01127*width, y: 0.52065*height))
        path.addLine(to: CGPoint(x: 0.7681*width, y: 0.96116*height))
        path.addCurve(to: CGPoint(x: 0.93128*width, y: 0.96116*height), control1: CGPoint(x: 0.81316*width, y: 0.98663*height), control2: CGPoint(x: 0.88622*width, y: 0.98663*height))
        path.addCurve(to: CGPoint(x: 0.93128*width, y: 0.86893*height), control1: CGPoint(x: 0.97634*width, y: 0.93569*height), control2: CGPoint(x: 0.97634*width, y: 0.8944*height))
        path.addLine(to: CGPoint(x: 0.27856*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.93128*width, y: 0.13107*height))
        path.addCurve(to: CGPoint(x: 0.93128*width, y: 0.03884*height), control1: CGPoint(x: 0.97634*width, y: 0.10561*height), control2: CGPoint(x: 0.97634*width, y: 0.06431*height))
        path.addCurve(to: CGPoint(x: 0.7681*width, y: 0.03884*height), control1: CGPoint(x: 0.88622*width, y: 0.01337*height), control2: CGPoint(x: 0.81316*width, y: 0.01337*height))
        path.addLine(to: CGPoint(x: 0.0338*width, y: 0.45388*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.19231*width, y: 0.43478*height))
        path.addLine(to: CGPoint(x: 0.11538*width, y: 0.43478*height))
        path.addLine(to: CGPoint(x: 0.11538*width, y: 0.56522*height))
        path.addLine(to: CGPoint(x: 0.19231*width, y: 0.56522*height))
        path.addLine(to: CGPoint(x: 0.19231*width, y: 0.43478*height))
        path.closeSubpath()
        return path
    }
}
