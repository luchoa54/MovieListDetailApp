# MovieListDetailApp

## Overview
Simple iOS app demonstrating a list and detail view of movies using TMDB API.

## Features
- List of movies with pull-to-refresh
- Detail view with more info
- Loading and error states
- Retry option on network failure

## Architecture
- Clean Architecture (Presentation / Domain / Data)
- MVVM pattern for presentation layer
- Repository pattern for data layer

## Libraries / Tools
- Alamofire / URLSession for networking
- Combine for reactive state management
- SwiftUI or UIKit
- XCTest for unit/UI tests

## Setup
1. Clone repository
2. Install dependencies (if any)
3. Run the app
4. Optional: provide TMDB API key in `Config.swift`

## Future Improvements
- Pagination for list
- Image caching for posters
- Offline mode
- More unit/UI tests
