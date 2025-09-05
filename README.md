## Student Learning App (Flutter)

This is a small Flutter app designed for a third-year CS student. The goal is to be easy to read, easy to explain in class, and solid enough for final submission.

### What the app does
- Shows a simple counter you can increase.
- Gets a random motivational quote from the internet and displays it.
- Uses friendly language and clear error messages.

### Why this is student-friendly
- Uses Provider with ChangeNotifier for state (simple and popular).
- Uses plain Dart and small files with clear comments.
- Avoids complex patterns (no Bloc, no DI frameworks, no channels).

### Project structure (lib/)
- `main.dart`: App entry, sets up Provider and theme.
- `app/app_state.dart`: Holds app data like `counter` and `currentQuote`.
- `services/quote_service.dart`: Small HTTP client for a random quote.
- `screens/home_screen.dart`: Main UI with buttons and messages.

### How to run
1) Install Flutter: follow the official docs.
2) In a terminal, go to the project folder.
3) Run: `flutter pub get`
4) Start: `flutter run`

### Notes for presentation
- Explain how `AppState` notifies the UI using `notifyListeners()`.
- Walk through the quote button: it sets loading, calls the service, and handles errors in plain English.
- Point to comments in each file to show your understanding.

### Dependencies used
- `provider`: easy state management for beginners.
- `http`: simple HTTP calls.

Made with care to be readable and friendly for students, professors, and non-experts.
