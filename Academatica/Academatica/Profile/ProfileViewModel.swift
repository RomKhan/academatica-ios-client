//
//  ProfileViewModel.swift
//  SmartMath
//
//  Created by Roman on 13.01.2022.
//

import SwiftUI

class ProfileViewModel : ObservableObject {
    @State var progressBar: Float = 1250.0 / 5000;
    let imageName: String = "young-girls"
    let userModel = UserModel(id: "1",
                              email: "fsfd@gmail.com",
                              userName: "jreyers",
                              firstName: "Jaseon",
                              lastName: "Reyers",
                              registereAt: "312",
                              profilePicURL: "")
    let userStateModel = UserStateModel(id: "1",
                                        exp: 1250,
                                        buoysLeft: 5,
                                        daysStreak: 2,
                                        lastClassFinishedAt: "d",
                                        legue: "Gold")
    let achievementsOfRightStack = [
        AchievemntModel(
            id: "1",
            name: "Get started",
            description: "Completed first lesson (and some text for the second line)",
            imageUrl: "shuttle",
            count: 2
        ),
        AchievemntModel(
            id: "2",
            name: "Get started",
            description: "Completed first lesson (and some text for the second line) fgdgfdfgdf",
            imageUrl: "shuttle",
            count: 10
        ),
        AchievemntModel(
            id: "3",
            name: "Get started",
            description: "Completed first lesson",
            imageUrl: "shuttle",
            count: 99
        ),
        AchievemntModel(
            id: "4",
            name: "Get started and fsfd",
            description: "Completed first lesson (and some text for the second line)",
            imageUrl: "shuttle",
            count: 9
        )
    ]
    let achievementsOfLeftStack = [
        AchievemntModel(
            id: "5",
            name: "Get started",
            description: "Completed first lesson (and some text)",
            imageUrl: "shuttle",
            count: 2
        ),
        AchievemntModel(
            id: "6",
            name: "Get started",
            description: "Completed first lesson (and some text for the second line)",
            imageUrl: "shuttle",
            count: 20
        ),
        AchievemntModel(
            id: "7",
            name: "Get started hehehhe",
            description: "Completed first lesson (and some text for the second line)",
            imageUrl: "shuttle",
            count: 2
        ),
        AchievemntModel(
            id: "8",
            name: "Get started",
            description: "Completed first lesson (and some text for the second line)",
            imageUrl: "shuttle",
            count: 2
        )
    ]
    let userLevel = 2
    let userLevelState = "Novice"
    let maxLevelExp = 5000
    let howMushExpAtThisWeek = 100
    
    init() {
        progressBar = Float(userStateModel.exp / maxLevelExp)
    }
}
