# clock_app

A clock app made with Flutter.

The main screen shows a clock. 
Meanwhile, the app fetches a random number from an api every 10 seconds. 
In case the number is prime, the app notifies the user by showing the number and the time elapsed since the last prime number seen. 
If the app is closed and then reopened, it should still calculate the correct time elapsed since the last prime number seen.

## Info

- Built with Flutter version: 3.29.3
- Minimum required Dart version: 3.7.2
- Development device: iPhone 15 Simulator with iOS 17

## App Preview

https://github.com/user-attachments/assets/7d747715-d892-431a-b7d5-d9153d5b7995


when the very first prime number is shown, a message indicates that this is the first prime number because there is no previous one to compare with. This is one of my assumptions, please read more in the [Assumptions Made](#assumptions-made) section.

![Simulator Screenshot - iPhone 15 - 2025-05-17 at 10 50 09](https://github.com/user-attachments/assets/df6f7c89-90ef-41ff-b21b-c9e9acc392c9)

## Pattern and packages

### Clean code architecure

The project has been implemented following the [clean code architecture described by uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), structured into three main layers within each feature:

- `presentation/` – UI widgets and state management (e.g., BLoC/Cubit)
- `domain/` – Business logic, use cases, and abstract repository interfaces
- `data/` – Models, data sources (e.g., APIs, local storage), and repository implementations

The reason is because this architecture promotes clear separation of concerns, scalability, and testability.

Additionally, there is a `core/` folder used for:

- Shared logic and utilities
- Common base classes, interfaces, and helper functions used across features

### Packages

- **`dartz`** – Functional programming tools for Dart, `Either`.
- **`equatable`** – Simplifies value comparisons by overriding equality and hashCode automatically.
- **`flutter_bloc`** – State management library that integrates the BLoC pattern into Flutter apps.
- **`flutter_test`** – Provides testing utilities for Flutter widgets and integration with the Flutter testing framework
- **`bloc_test`** – Utilities for testing BLoC and Cubit logic in Flutter.
- **`get_it`** – A simple service locator for dependency injection in Dart and Flutter.
- **`http`** – Lightweight HTTP client for making network requests in Dart.
- **`injectable`** – Code generator for dependency injection setup using annotations with `get_it`.
- **`intl`** – Provides internationalization and localization utilities, including date/number formatting.
- **`mockito`** – Mocking framework for unit tests in Dart.
- **`shared_preferences`** – Persistent key-value storage for simple app data like settings and flags.

## Assumptions Made

 - I assumed that the app should persist the timestamp of the last prime number locally, so it can correctly display the elapsed time even after being closed and reopened. To achieve this, I used the `shared_preferences` package to store the timestamp on the device.
 - I designed the logic for reacting to a received prime number as a singleton service because this functionality might be needed beyond the clock screen. By implementing it as a singleton, the service lives throughout the app's lifecycle and continues fetching data periodically. This ensures a single source of truth that can be listened to or injected into multiple screens, making the architecture scalable and consistent as new features are added.
 - I interpreted "time elapsed since the last prime number" as the time elapsed since the last prime number received by the app. Therefore, when the very first prime number is shown, a message indicates that this is the first prime number because there is no previous one to compare with.


