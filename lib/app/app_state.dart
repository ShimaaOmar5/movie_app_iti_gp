import 'package:flutter/foundation.dart';

import '../services/quote_service.dart';

/// AppState is a very small class that holds the main data for our app.
///
/// We use ChangeNotifier + Provider because it is simple and popular for
/// beginners. When data changes, we call notifyListeners() to update the UI.
class AppState extends ChangeNotifier {
  /// A simple number the user can increase. Great for practicing state basics.
  int counter = 0;

  /// The latest quote we fetched from the internet, or null if none yet.
  Quote? currentQuote;

  /// True while we are waiting for the quote API. Used to show a loading spinner.
  bool isLoadingQuote = false;

  /// If something went wrong, we store a human-friendly message here.
  String? lastErrorMessage;

  /// This service does the actual HTTP call. It is separated for clarity.
  final QuoteService quoteService;

  AppState({QuoteService? quoteService})
      : quoteService = quoteService ?? QuoteService();

  /// Increases the counter by 1 and updates the UI.
  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  /// Asks the QuoteService for a new random quote.
  /// Shows loading, handles errors, and updates the UI.
  Future<void> loadRandomQuote() async {
    isLoadingQuote = true;
    lastErrorMessage = null; // clear any previous error message
    notifyListeners();

    try {
      final Quote quote = await quoteService.fetchRandomQuote();
      currentQuote = quote;
    } catch (error) {
      // We keep the message plain and friendly so anyone can understand it.
      lastErrorMessage =
          'Sorry, we could not get a quote right now. Please try again.';
    } finally {
      isLoadingQuote = false;
      notifyListeners();
    }
  }
}

