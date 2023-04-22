import Foundation

class StructWrapper<T>: NSObject {

    let value: T

    init(_ _struct: T) {
        self.value = _struct
    }
}

class CacheService {
    static let shared = CacheService()
    
    private var userAchievements = NSCache<NSString, StructWrapper<[AchievementModel]>>()
    private var userModel = NSCache<NSString, StructWrapper<UserModel>>()
    private var otherUserModel = NSCache<NSString, StructWrapper<UserModel>>()
    private var activityMatrix = NSCache<NSString, StructWrapper<[String: Int]>>()
    
    private var userState = NSCache<NSString, StructWrapper<UserStateModel>>()
    private var userLeaderboardState = NSCache<NSString, StructWrapper<LeaderboardStateModel>>()
    private var otherUserLeaderboardState = NSCache<NSString, StructWrapper<LeaderboardStateModel>>()
    private var otherUserAchievements = NSCache<NSString, StructWrapper<[AchievementModel]>>()
    
    private var upcomingClasses = NSCache<NSString, StructWrapper<[UpcomingClassModel]>>()
    private var tiers = NSCache<NSString, StructWrapper<[TierModel]>>()
    private var topics = NSCache<NSString, StructWrapper<[TopicModel]>>()
    private var classes = NSCache<NSString, StructWrapper<[ClassModel]>>()
    private var completedTopicCount = NSCache<NSString, StructWrapper<Int>>()
    private var completedTopics = NSCache<NSString, StructWrapper<[CustomPracticeTopicModel]>>()
    
    private init() {}
    
    var cachedUpcomingClasses: [UpcomingClassModel]? {
        get { getter(self.upcomingClasses) }
        set(newObj) { setter(self.upcomingClasses, newObj) }
    }
    
    var cachedUserAchievements: [AchievementModel]? {
        get { getter(self.userAchievements) }
        set(newObj) { setter(self.userAchievements, newObj) }
    }
    
    var cachedUserModel: UserModel? {
        get { getter(self.userModel) }
        set(newObj) { setter(self.userModel, newObj) }
    }
    
    var cachedOtherUserModel: UserModel? {
        get { getter(self.otherUserModel) }
        set(newObj) { setter(self.otherUserModel, newObj) }
    }
    
    var cachedActivityMatrix: [String: Int]? {
        get { getter(self.activityMatrix) }
        set(newObj) { setter(self.activityMatrix, newObj) }
    }
    
    var cachedUserState: UserStateModel? {
        get { getter(self.userState) }
        set(newObj) { setter(self.userState, newObj) }
    }
    
    var cachedUserLeaderboardState: LeaderboardStateModel? {
        get { getter(self.userLeaderboardState) }
        set(newObj) { setter(self.userLeaderboardState, newObj) }
    }
    
    var cachedOtherUserLeaderboardState: LeaderboardStateModel? {
        get { getter(self.otherUserLeaderboardState) }
        set(newObj) { setter(self.otherUserLeaderboardState, newObj) }
    }
    
    var cachedOtherUserAchievements: [AchievementModel]? {
        get { getter(self.otherUserAchievements) }
        set(newObj) { setter(self.otherUserAchievements, newObj) }
    }
    
    var cachedTiers: [TierModel]? {
        get { getter(self.tiers) }
        set(newObj) { setter(self.tiers, newObj) }
    }
    
    var cachedTopics: [TopicModel]? {
        get { getter(self.topics) }
        set(newObj) { setter(self.topics, newObj) }
    }
    
    var cachedClasses: [ClassModel]? {
        get { getter(self.classes) }
        set(newObj) { setter(self.classes, newObj) }
    }
    
    var cachedCompletedTopicCount: Int? {
        get { getter(self.completedTopicCount) }
        set(newObj) { setter(self.completedTopicCount, newObj) }
    }
    
    var cachedCompletedTopics: [CustomPracticeTopicModel]? {
        get { getter(self.completedTopics) }
        set(newObj) { setter(self.completedTopics, newObj) }
    }
    
    private func getter<T: NSCache<NSString,StructWrapper<W>>, W: Any>(_ cache: T) -> W? {
        let cachedObj = cache.object(forKey: "CachedObject")
        return cachedObj?.value
    }
    
    private func setter<T: NSCache<NSString,StructWrapper<W>>, W: Any>(_ cache: T, _ newObj: W?) {
        let newObj = StructWrapper(newObj!)
        cache.setObject(newObj, forKey: "CachedObject")
    }
    
    func clearChache() {
        upcomingClasses.removeAllObjects()
        userAchievements.removeAllObjects()
        userModel.removeAllObjects()
        otherUserModel.removeAllObjects()
        activityMatrix.removeAllObjects()
        userState.removeAllObjects()
        userLeaderboardState.removeAllObjects()
        otherUserLeaderboardState.removeAllObjects()
        otherUserAchievements.removeAllObjects()
    }
    
    func clearUserModel() {
        userModel.removeAllObjects()
    }
    
    func clearOtherUserModel() {
        otherUserModel.removeAllObjects()
        otherUserLeaderboardState.removeAllObjects()
        otherUserAchievements.removeAllObjects()
    }
    
    func clearActivityMatrix() {
        userModel.removeAllObjects()
    }
    
    func clearUserState() {
        userState.removeAllObjects()
    }
    
    func clearTopics() {
        topics.removeAllObjects()
        classes.removeAllObjects()
    }
    
    func clearClasses() {
        classes.removeAllObjects()
    }
    
    func clearCourseInfo() {
        topics.removeAllObjects()
        classes.removeAllObjects()
        completedTopicCount.removeAllObjects()
        upcomingClasses.removeAllObjects()
        activityMatrix.removeAllObjects()
        userAchievements.removeAllObjects()
        userLeaderboardState.removeAllObjects()
        userState.removeAllObjects()
        completedTopics.removeAllObjects()
    }
    
}
