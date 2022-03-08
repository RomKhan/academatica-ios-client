//
//  ProfileView.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    @State var contentOffset: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    var isOtherAccount: Bool = false
    var body: some View {
        ZStack {
            ProfileViewShapeBack()
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: Color(uiColor: UIColor(red: 1, green: 139 / 255.0, blue: 132 / 255.0, alpha: 1)), location: 0.6    ),
                            .init(color: Color(uiColor: UIColor(red: 0, green: 18 / 255.0, blue: 182 / 255.0, alpha: 1)), location: 0)
                        ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .offset(y: -contentOffset)
                .ignoresSafeArea()
            ProfileViewShapeMiddle()
                .offset(y: -contentOffset)
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: Color(uiColor: UIColor(red: 187 / 255.0, green: 134 / 255.0, blue: 255 / 255.0, alpha: 1)), location: 0),
                            .init(color: Color(uiColor: UIColor(red: 122 / 255.0, green: 53 / 255.0, blue: 210 / 255.0, alpha: 1)), location: 0.4)
                        ]),
                    startPoint: .top,
                    endPoint: .bottom))
                .ignoresSafeArea()
                .offset(y: max(UIScreen.main.bounds.height / 3.5, 240))
                .shadow(color: Color(uiColor: UIColor(red: 180 / 255.0, green: 125 / 255.0, blue: 250 / 255.0, alpha: 0.7)), radius: 25, x: 0, y: -10)
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $contentOffset) {
                ZStack {
                    if (isOtherAccount) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            SmothArrow()
                                .fill(.white)
                                .frame(width: 11, height: 20)
                        })
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Text("Profile")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                    if (!isOtherAccount) {
                        NavigationLink(destination: GeneralSettingsView(viewModel: GeneralSettingsViewModel()), label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.horizontal, 20)
                HStack(spacing: 0) {
                    Image(viewModel.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                        .mask(
                            RoundedRectangle(cornerRadius: 20)
                                .frame(minWidth: 74, minHeight: 74)
                                .frame(
                                    width: UIScreen.main.bounds.height / 9.3 - 24,
                                    height: UIScreen.main.bounds.height / 9.3 - 24)
                        )
                        .padding(.horizontal, -5)
                        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 0)
                        .blendMode(.overlay)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(viewModel.userModel.firstName!) \(viewModel.userModel.lastName!)")
                            .font(.system(size: 18, weight: .heavy))
                        Text("@\(viewModel.userModel.userName!)")
                            .font(.system(size: 14, weight: .thin))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    VStack(spacing: 0) {
                        Text(viewModel.userStateModel.legue)
                            .textCase(.uppercase)
                            .font(.callout)
                        Image("gold")
                            .resizable()
                            .scaledToFit()
                        Text("League")
                            .textCase(.uppercase)
                            .font(.callout)
                    }
                    .blendMode(.overlay)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(12)
                    .padding(.trailing, 6)
                }
                .frame(minHeight: 98)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: UIScreen.main.bounds.height / 9.3)
                .frame(minHeight: 98)
                .background(.ultraThinMaterial)
                .cornerRadius(23)
                .padding(.horizontal, 20)
                .padding(.top, 17)
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("**Level \(viewModel.userLevel)** - \(viewModel.userLevelState)")
                            .font(.system(size: 20))
                            .padding(.bottom, 8)
                        Text("EXP " + String(viewModel.userStateModel.exp) + "/\(viewModel.maxLevelExp)")
                            .font(.system(size: 14))
                            .foregroundColor(Color(uiColor: UIColor(red: 0, green: 1, blue: 72 / 255.0, alpha: 1)))
                        Text("+ \(viewModel.howMushExpAtThisWeek) EXP THIS WEEK")
                            .font(.system(size: 14))
                            .foregroundColor(Color(uiColor: UIColor(red: 0, green: 1, blue: 72 / 255.0, alpha: 1)))
                    }
                    .padding(.leading, 5)
                    .padding(.horizontal, 12)
                    Spacer()
                    CircleProgressBar(progress: $viewModel.progressBar)
                        .frame(maxWidth: 98, maxHeight: 98, alignment: .trailing)
                        .padding()
                }
                .frame(minHeight: 98)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: UIScreen.main.bounds.height / 7.5)
                .frame(minHeight: 98)
                .background(.ultraThinMaterial)
                .cornerRadius(23)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                Text("Акитвность")
                    .padding(.top, UIScreen.main.bounds.height / (0.05*UIScreen.main.bounds.width))
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                HeapmapCalendarView()
                    .frame(height: max(140, UIScreen.main.bounds.height / 6))
                    .padding(.top, 10)
                    .blendMode(.overlay)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                Text("Достижения")
                    .padding(.top, UIScreen.main.bounds.height / (0.045*UIScreen.main.bounds.width))
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                HStack(alignment: .top, spacing: 20) {
                    VStack(spacing: 20) {
                        ForEach(viewModel.achievementsOfLeftStack) { model in
                            AchievemntCardView(
                                viewModel: AchievemntCardViewModel(model: model)
                            )
                        }
                    }
                    VStack(spacing: 20) {
                        ForEach(viewModel.achievementsOfRightStack) { model in
                            AchievemntCardView(
                                viewModel: AchievemntCardViewModel(model: model)
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
                Text("")
                    .frame(height: 95)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(stops: [
                .init(color: Color(uiColor: UIColor(red: 61 / 255.0, green: 49 / 255.0, blue: 125 / 255.0, alpha: 1)), location: 0.7),
                .init(color: Color(uiColor: UIColor(red: 32 / 255.0, green: 31 / 255.0, blue: 71 / 255.0, alpha: 1)), location: 1)
            ]), startPoint: .top, endPoint: .bottom)
        )
        .navigationBarHidden(true)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileViewShapeBack: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = max(rect.size.height / 2, 380)
        path.move(to: CGPoint(x: 0.44933*width, y: 0.94022*height))
        path.addCurve(to: CGPoint(x: 0.10267*width, y: 0.99864*height), control1: CGPoint(x: 0.38355*width, y: 0.95698*height), control2: CGPoint(x: 0.22213*width, y: 0.99212*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.96651*height), control1: CGPoint(x: 0.06069*width, y: 1.00093*height), control2: CGPoint(x: 0.02681*width, y: 0.98752*height))
        path.addLine(to: CGPoint(x: 0, y: 0.81929*height))
        path.addLine(to: CGPoint(x: 0, y: -1.46875*height))
        path.addLine(to: CGPoint(x: width, y: -1.46875*height))
        path.addLine(to: CGPoint(x: width, y: 0.81386*height))
        path.addLine(to: CGPoint(x: width, y: 0.85054*height))
        path.addCurve(to: CGPoint(x: 0.824*width, y: 0.91033*height), control1: CGPoint(x: 0.96706*width, y: 0.88825*height), control2: CGPoint(x: 0.90627*width, y: 0.92954*height))
        path.addCurve(to: CGPoint(x: 0.44933*width, y: 0.94022*height), control1: CGPoint(x: 0.7216*width, y: 0.88641*height), control2: CGPoint(x: 0.53155*width, y: 0.92029*height))
        path.closeSubpath()
        return path
    }
}


struct ProfileViewShapeMiddle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = CGFloat(350)
        path.move(to: CGPoint(x: 0.692*width, y: 0.13651*height))
        path.addCurve(to: CGPoint(x: 0.08133*width, y: 0.27138*height), control1: CGPoint(x: 0.572*width, y: 0.12829*height), control2: CGPoint(x: 0.21467*width, y: 0.28125*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.25221*height), control1: CGPoint(x: 0.04819*width, y: 0.26893*height), control2: CGPoint(x: 0.0214*width, y: 0.26175*height))
        path.addLine(to: CGPoint(x: 0, y: 0.25493*height))
        path.addLine(to: CGPoint(x: 0, y: 0.79441*height))
        path.addLine(to: CGPoint(x: 0, y: 0.88698*height))
        path.addCurve(to: CGPoint(x: 0.04*width, y: 0.91118*height), control1: CGPoint(x: 0.01254*width, y: 0.89792*height), control2: CGPoint(x: 0.02601*width, y: 0.90661*height))
        path.addCurve(to: CGPoint(x: 0.38*width, y: 0.83553*height), control1: CGPoint(x: 0.10533*width, y: 0.93257*height), control2: CGPoint(x: 0.26667*width, y: 0.8898*height))
        path.addCurve(to: CGPoint(x: 0.76*width, y: 0.8898*height), control1: CGPoint(x: 0.49333*width, y: 0.78125*height), control2: CGPoint(x: 0.62667*width, y: 0.83553*height))
        path.addCurve(to: CGPoint(x: width, y: 0.85824*height), control1: CGPoint(x: 0.84619*width, y: 0.92489*height), control2: CGPoint(x: 0.94166*width, y: 0.89146*height))
        path.addLine(to: CGPoint(x: width, y: 0.83717*height))
        path.addLine(to: CGPoint(x: width, y: 0.10526*height))
        path.addLine(to: CGPoint(x: width, y: 0.08516*height))
        path.addCurve(to: CGPoint(x: 0.884*width, y: 0.17928*height), control1: CGPoint(x: 0.96842*width, y: 0.13161*height), control2: CGPoint(x: 0.92484*width, y: 0.17928*height))
        path.addCurve(to: CGPoint(x: 0.692*width, y: 0.13651*height), control1: CGPoint(x: 0.80933*width, y: 0.17928*height), control2: CGPoint(x: 0.812*width, y: 0.14474*height))
        path.closeSubpath()
        return path
    }
}
