import Foundation

struct Repo: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let language: String?
}
