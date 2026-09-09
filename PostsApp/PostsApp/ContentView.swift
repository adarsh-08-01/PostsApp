import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading repos...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.repos) { repo in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(repo.name)
                                .font(.headline)
                            Text(repo.description ?? "No description")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            HStack {
                                if let language = repo.language {
                                    Text(language)
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                                Text("⭐ \(repo.stargazers_count)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("My Repos")
            .task {
                await viewModel.loadRepos()
            }
        }
    }
}
