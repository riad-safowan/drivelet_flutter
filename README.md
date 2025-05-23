# drivelet

A Vehicle Rental App

## Getting Started

# Vehicle Rental App

A cross-platform Flutter application for vehicle rentals featuring clean architecture, offline caching, and modern UI design.

## Features

- **Authentication**: Login with demo credentials
- **Vehicle List**: Browse available vehicles with real-time status
- **Vehicle Details**: View detailed information including location, battery, and cost
- **Google Maps API**: To view the location from the lat,lng provided.
- **Rental Management**: Start vehicle rentals with confirmation
- **User Profile**: View user statistics and trip history
- **Offline Support**: Cached data for offline viewing
- **Pull-to-Refresh**: Update vehicle list with pull gesture
- **Clean Architecture**: Separation of concerns with proper layer isolation

## Architecture

This app follows **Clean Architecture** principles with three main layers:

### Presentation Layer
- **Pages**: UI screens (Login, Vehicle List, Vehicle Detail, Profile)
- **Widgets**: Reusable UI components
- **BLoC**: State management using flutter_bloc

### Domain Layer
- **Entities**: Core business objects
- **Use Cases**: Business logic operations
- **Repository Interfaces**: Abstract data access contracts

### Data Layer
- **Models**: Data transfer objects
- **Data Sources**: Remote (API) and Local (Cache) data access
- **Repository Implementations**: Concrete data access implementations

## Tech Stack

- **Flutter 3.x**: Cross-platform development framework
- **Dart**: Programming language
- **flutter_bloc**: State management
- **http**: API communication
- **shared_preferences**: Local data persistence
- **cached_network_image**: Image caching
- **connectivity_plus**: Network connectivity checking
- **get_it**: Dependency injection
- **dartz**: Functional programming utilities
- **equatable**: Value equality

## Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android device/emulator or iOS device/simulator

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/riad-safowan/drivelet_flutter.git
   cd drivelet_flutter
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Demo Credentials

Use these credentials to test the app:

- **Email**: `user@example.com`
- **Password**: `123456`
