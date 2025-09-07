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
- `app/app_state.dart`: Holds app data like `counter`, `currentQuote`, and TMDB movie list.
- `services/quote_service.dart`: Small HTTP client for a random quote.
- `services/tmdb_config.dart`: TMDB base URL and Dio client with auth handling.
- `services/tmdb_image_url.dart`: Helpers to build full TMDB image URLs.
- `src/domain/movies`: Movie model and repository interface.
- `src/infrastructure/movies`: TMDB implementation of the repository.
- `screens/home_screen.dart`: Main UI with buttons, movies carousel, and messages.

### How to run
1) Install Flutter: follow the official docs.
2) In a terminal, go to the project folder.
3) Run: `flutter pub get`
4) Start with your TMDB credentials (either v3 API key or v4 token):

```
flutter run --dart-define=TMDB_API_KEY=YOUR_KEY
```

or

```
flutter run --dart-define=TMDB_BEARER_TOKEN=YOUR_TOKEN
```

### Notes for presentation
- Explain how `AppState` notifies the UI using `notifyListeners()`.
- Walk through the quote button: it sets loading, calls the service, and handles errors in plain English.
- Point to comments in each file to show your understanding.
- Show the TMDB section fetching Popular Movies and how images are built.

### TMDB Endpoints Used
- Base URL: `https://api.themoviedb.org/3`
- GET `/movie/popular`
- GET `/movie/{id}`
- GET `/search/movie`
- GET `/trending/{media_type}/{time_window}`

### Dependencies used
- `provider`: easy state management for beginners.
- `http`: simple HTTP calls.

Made with care to be readable and friendly for students, professors, and non-experts.
