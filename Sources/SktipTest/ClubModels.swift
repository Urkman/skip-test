import Foundation

// MARK: - Club Models

struct Club: Codable, Identifiable {
    let id: UUID
    let name: String
    let creatorId: String
    let createdAt: Date
    let isPrivate: Bool
    let inviteCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case creatorId = "creator_id"
        case createdAt = "created_at"
        case isPrivate = "is_private"
        case inviteCode = "invite_code"
    }
}
