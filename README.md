# PostsApp — iOS Practical Assignment

SwiftUI app that consumes a public REST API (GitHub API) and displays the data in a list.

## What it does
Fetches my public GitHub repositories and displays each one's name, description, primary language, and star count in a scrollable list.

## API used
`https://api.github.com/users/adarsh-08-01/repos` — GitHub's public REST API, no key required.

## Architecture
MVVM
- **Model.swift** — `Repo` struct (Codable)
- **NetworkManager.swift** — async/await network layer, handles URL/response errors
- **PostListViewModel.swift** — `@MainActor` ObservableObject, publishes loading/error/data state
- **ContentView.swift** — SwiftUI List UI, driven by `.task` on appear

## How it works
1. `ContentView` triggers `loadRepos()` via `.task` when the view appears
2. `NetworkManager` makes an async `URLSession` call, validates the HTTP response, decodes JSON with `Codable`
3. Decoded repos are published via `@Published`, so the UI updates automatically
4. `List` renders each repo — name, description, language, stars

## Requirements
- Xcode 15+
- iOS 16+
- No third-party dependencies, no API key needed
