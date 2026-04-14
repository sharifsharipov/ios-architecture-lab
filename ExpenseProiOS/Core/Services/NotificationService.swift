import Foundation
import UserNotifications

protocol NotificationServiceProtocol {
    func requestAuthorization() async -> Bool
    func schedule(title: String, body: String, after seconds: TimeInterval, id: String) async
}

final class NotificationService: NotificationServiceProtocol {
    private let center = UNUserNotificationCenter.current()

    func requestAuthorization() async -> Bool {
        (try? await center.requestAuthorization(options: [.alert, .badge, .sound])) ?? false
    }

    func schedule(title: String, body: String, after seconds: TimeInterval, id: String) async {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        try? await center.add(request)
    }
}
