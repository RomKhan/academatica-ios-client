//
//  LeadBoardsView.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI

struct LeadBoardsView: View {
    @State private var heightOfset: CGFloat = 0
    @StateObject var viewModel: LeadBoardsViewModel = LeadBoardsViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            LeadBoardsBackground()
                .offset(y: -heightOfset)
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: viewModel.colors[0], location: 0),
                            .init(color: viewModel.colors[1], location: 0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                Text("Таблица лидеров")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                LeadBoardCardView()
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                Text("Ваше место: \(viewModel.userPlace)".uppercased())
                    .font(.system(size: 13, weight: .bold))
                    .padding(.top, 30)
                
                VStack(spacing: 0) {
                    ForEach(viewModel.leadboardUsers) { userModel in
                        NavigationLink {
                            ProfileView(viewModel: ProfileViewModel(), isOtherAccount: true)
                        } label: {
                            HStack {
                                //                                Text(Int(userModel.id) ?? 0 < 99 ? "\(userModel.id)" : "99+")
                                Text(Int(0) ?? 0 < 99 ? "\(0)" : "99+")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 36)
                                AsyncImage(url: userModel.profilePicUrl, transaction: Transaction(animation: .easeInOut))
                                { phase in
                                    switch phase {
                                    case .empty:
                                        Rectangle().fill(.gray)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .background(Color.gray)
                                            .mask(Circle())
                                            .frame(width: 60)
                                            .padding(5)
                                            .padding(.leading, -5)
                                            .transition(.scale(scale: 0.1, anchor: .center))
                                    case .failure:
                                        Image(systemName: "wifi.slash")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                    
                                VStack(alignment: .leading) {
                                    
                                    Text("\(userModel.firstName) \(userModel.lastName)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .padding(.bottom, -5)
                                    Text("@\(userModel.username)")
                                        .foregroundColor(viewModel.colors[3])
                                        .font(.system(size: 13))
                                    
                                }
                                Spacer()
                                Text("1254")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                                    .padding(5)
                                    .background(
                                        Rectangle().fill(.red)
                                            .blendMode(.overlay)
                                    )
                                    .cornerRadius(10)
                            }
                        }
                        .onAppear {
                            viewModel.loadMoreUsersIfNeeded(currentItem: userModel)
                        }
                        .padding(.horizontal, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 70)
                        .padding(.top, 5)
                        
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .background(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                            .padding(.top, 5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .background(
                    GeometryReader { reader in
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: viewModel.colors[2], location: 0.1),
                                .init(color: viewModel.colors[3], location: 1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                            .frame(height: UIScreen.main.bounds.height * 2)
                            .offset(y: heightOfset - UIScreen.main.bounds.height / 2)
                    }
                )
                .padding(.bottom, -1)
                .cornerRadius(25)
                .padding(.horizontal, 20)
                
                if viewModel.isLoadingUsers {
                    ProgressView()
                }
                Text("")
                    .frame(height: 95)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct LeadBoardsView_Previews: PreviewProvider {
    static var previews: some View {
        LeadBoardsView()
    }
}

struct LeadBoardsBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height / 2.87
        path.move(to: CGPoint(x: width, y: 0.61879*height))
        path.addCurve(to: CGPoint(x: width, y: 0.72392*height), control1: CGPoint(x: width, y: 0.61879*height), control2: CGPoint(x: width, y: 0.66844*height))
        path.addCurve(to: CGPoint(x: 0.95691*width, y: 0.77456*height), control1: CGPoint(x: 0.9898*width, y: 0.74263*height), control2: CGPoint(x: 0.97588*width, y: 0.76053*height))
        path.addCurve(to: CGPoint(x: 0.10612*width, y: 0.99721*height), control1: CGPoint(x: 0.88577*width, y: 0.82713*height), control2: CGPoint(x: 0.33067*width, y: 0.94897*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.95179*height), control1: CGPoint(x: 0.05139*width, y: 1.00897*height), control2: CGPoint(x: 0.01882*width, y: 0.98162*height))
        path.addLine(to: CGPoint(x: 0, y: 0.89362*height))
        path.addLine(to: CGPoint(x: 0, y: -1.56738*height))
        path.addLine(to: CGPoint(x: width, y: -1.56738*height))
        path.addLine(to: CGPoint(x: width, y: 0.61879*height))
        path.closeSubpath()
        return path
    }
}
