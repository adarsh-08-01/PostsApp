import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchRepos() async throws -> [Repo] {
        guard let url = URL(string: "https://api.github.com/users/adarsh-08-01/repos") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode([Repo].self, from: data)
    }
}
