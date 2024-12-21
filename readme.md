
# MarvelSwiftUI

MarvelSwiftUI is an iOS app built using SwiftUI that interacts with the Marvel API to display a list of heroes and their associated series. The app implements the MVVM architecture, adheres to Clean Code principles, and utilizes modern Swift features such as `async/await`, Combine, and custom transitions.

## Features

- **Hero Listing**: Displays a list of Marvel heroes with their names, descriptions, and metrics such as comics and events.
- **Series Listing**: For each hero, users can view a list of series they are part of.
- **Platform-Specific UI**: Adapts the user interface for different platforms, including watchOS.
- **State Management**: Handles loading, error, and empty states effectively with smooth transitions.
- **Mock Data Support**: Includes mock implementations for testing and previews.

## Architecture

The app is designed with the MVVM (Model-View-ViewModel) architecture, emphasizing separation of concerns and testability.

- **Models**: Encapsulates the data structures (e.g., `ResultHero`, `ResultSeries`) that represent API responses.
- **ViewModels**: Manages the state and logic for views (e.g., `HeroListViewModel`, `SeriesListViewModel`).
- **Views**: Presents the UI components (e.g., `HeroListContent`, `SeriesRowDefault`).

## Technologies Used

- **SwiftUI**: For declarative UI design.
- **Combine**: For binding ViewModels to Views.
- **Async/Await**: For handling asynchronous API calls.
- **Marvel API**: Retrieves data about heroes and series.
- **Custom Transitions**: Adds animations for loading, content, and error states.

## Screens

### Hero List
Displays a scrollable list of Marvel heroes. Each row includes:
- Hero image
- Name
- Metrics such as available comics and series

### Series List
For each selected hero, a list of their associated series is displayed. Each row includes:
- Series image
- Title
- Metrics such as available comics and events

## State Management

The app manages states (`loading`, `loaded`, `error`) using enums:

```swift
enum StateScreen: Equatable {
    case loading
    case loaded
    case error(String)
}
```

Each state triggers a corresponding view:
- **Loading**: Displays a `LoadingView`.
- **Loaded**: Shows content with `HeroListContent` or `SeriesContentView`.
- **Error**: Displays an `ErrorView` with retry options.

## API Integration

### Endpoints
The app communicates with the Marvel API using predefined endpoints:
- **Fetch Heroes**: `/characters`
- **Fetch Hero Series**: `/characters/{characterId}/series`

### Authentication
Marvel API requires authentication with public and private keys. You need to provide your own API credentials in the `ConstantsApp` struct located at `Shared/Domain/Tools`:

```swift
public struct ConstantsApp {
    public static let CONS_API_PUBLIC_KEY = "YOUR_PUBLIC_KEY_HERE"
    public static let CONS_API_TS = "1"
    public static let CONS_API_HASH = "YOUR_HASH_HERE"
}
```

#### Generating the MD5 Hash
1. Obtain your **private key** and **public key** from the [Marvel Developer Portal](https://developer.marvel.com/).
2. Use the following formula to compute the hash:
   ```
   md5(ts + privateKey + publicKey)
   ```
   - `ts` is the timestamp value (e.g., "1").
   - `privateKey` is your private key.
   - `publicKey` is your public key.
3. Use any MD5 hash generator to create the hash. For example:
   ```bash
   echo -n "1your_private_keyyour_public_key" | md5
   ```
4. Update the `ConstantsApp` struct with the generated hash.

## Components Overview

### Common Views
- **LoadingView**: Displays an animated loading indicator.
- **ErrorView**: Shows error messages with retry options.
- **CustomTransitions**: Adds smooth animations for view state changes.

### Hero List
- **HeroListContent**: Displays the main list of heroes.
- **HeroRowCompact**: Compact layout for hero rows (e.g., watchOS).
- **HeroRowDefault**: Default layout for hero rows (e.g., iOS).

### Series List
- **SeriesListView**: Displays series associated with a hero.
- **SeriesRowCompact**: Compact layout for series rows.
- **SeriesRowDefault**: Default layout for series rows.

## Testing and Previews

The app includes mock data and previews for testing:

- **Mocks**: Implements `HeroesUseCaseMock` and `SeriesUseCaseMock` for isolated testing.
- **Previews**: Provides comprehensive previews for all states and components.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/HerniRG/MarvelSwiftUI.git
   ```
2. Open the project in Xcode.
3. Provide your API credentials in the `ConstantsApp` struct located at `Shared/Domain/Tools`.
4. Run the app on your desired simulator or device.

## Credits

- **Marvel API**: [Marvel Developer Portal](https://developer.marvel.com/)
- **Developer**: Hernán Rodríguez
- **Contact**: hernanrg85@gmail.com

---

Explore the world of Marvel heroes with this intuitive and beautifully designed app!
