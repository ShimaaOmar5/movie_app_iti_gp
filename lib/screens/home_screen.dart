import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_state.dart';

/// HomeScreen is the main page students will show in demos.
/// It has:
/// - A counter with a + button
/// - A button to fetch a random quote from the internet
/// - Friendly messages and simple loading/error states
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We listen to AppState so the UI updates when values change.
    final AppState appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Movie App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello! This is a small learning app.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Try increasing the number, and fetch a quote. The code uses Provider and a simple HTTP call so it is beginner-friendly.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // COUNTER SECTION
            Row(
              children: <Widget>[
                Text(
                  'Counter: ${appState.counter}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: appState.incrementCounter,
                  child: const Text('Add 1'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // QUOTE SECTION
            Text(
              'Random Quote',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (appState.isLoadingQuote)
              const Row(
                children: <Widget>[
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Getting a quote for you...'),
                ],
              )
            else if (appState.lastErrorMessage != null)
              Text(
                appState.lastErrorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (appState.currentQuote != null)
              Text('"${appState.currentQuote!.content}" — ${appState.currentQuote!.author}')
            else
              const Text('Press the button to get a motivational quote.'),

            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: appState.isLoadingQuote ? null : appState.loadRandomQuote,
              child: const Text('Get Random Quote'),
            ),

            const Spacer(),
            Text(
              'Tip: Read the comments in the code to learn how things work.',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

