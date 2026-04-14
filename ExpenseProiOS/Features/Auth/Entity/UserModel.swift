import Foundation

struct UserModel: Codable {
    let id: String
    let phone: String
    let email: String?
    let name: String?
    let avatarURL: String?
    let gender: String?

    func toEntity() -> UserEntity {
        UserEntity(
            id: id,
            phone: phone,
            email: email,
            name: name,
            avatarURL: avatarURL.flatMap(URL.init(string:)),
            gender: gender.flatMap(UserEntity.Gender.init(rawValue:))
        )
    }
}
