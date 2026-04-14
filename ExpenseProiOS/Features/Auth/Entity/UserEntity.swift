import Foundation

struct UserEntity: Equatable, Identifiable {
    let id: String
    let phone: String
    let email: String?
    let name: String?
    let avatarURL: URL?
    let gender: Gender?

    enum Gender: String, Codable { case male, female, other }
}
