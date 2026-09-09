import Foundation
import Combine

@MainActor
final class PostListViewModel: ObservableObject {
    @Published var repos: [Repo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadRepos() async {
        isLoading = true
        errorMessage = nil

        do {
            repos = try await NetworkManager.shared.fetchRepos()
        } catch {
            errorMessage = "Failed to load repos. Please try again."
        }

        isLoading = false
    }
}
