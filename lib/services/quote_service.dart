import 'dart:convert';

import 'package:http/http.dart' as http;

/// Quote holds a short text and the person who said it.
class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});

  /// Builds a Quote from a JSON map. We keep it simple and clear.
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: (json['content'] as String?)?.trim().isNotEmpty == true
          ? json['content'] as String
          : 'No quote text found.',
      author: (json['author'] as String?)?.trim().isNotEmpty == true
          ? json['author'] as String
          : 'Unknown',
    );
  }
}

/// QuoteService makes a very basic HTTP GET request to a free API.
/// We use `https://api.quotable.io/random` which returns a random quote as JSON.
class QuoteService {
  final http.Client _client;

  QuoteService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches a random quote. Throws an error if the server returns a bad status.
  Future<Quote> fetchRandomQuote() async {
    final Uri url = Uri.parse('https://api.quotable.io/random');
    final http.Response response = await _client.get(url);

    if (response.statusCode != 200) {
      throw Exception('Bad response: ${response.statusCode}');
    }

    final Map<String, dynamic> jsonBody =
        json.decode(response.body) as Map<String, dynamic>;
    return Quote.fromJson(jsonBody);
  }
}

