import 'package:flutter_test/flutter_test.dart';

// Mock Movie class for testing
class TestMovie {
  final String title;
  TestMovie(this.title);
}

void main() {
  group('Search Functionality Tests', () {
    final movies = [
      TestMovie('Avatar'),
      TestMovie('300'),
      TestMovie('The Avengers'),
      TestMovie('Interstellar'),
      TestMovie('The Wolf of Wall Street'),
      TestMovie('Breaking Bad'),
    ];

    // This is the exact same search logic used in your app
    List<TestMovie> searchMovies(String query) {
      if (query.trim().isEmpty) return movies;
      final lowerQuery = query.toLowerCase().trim();
      return movies.where((movie) => 
        movie.title.toLowerCase().contains(lowerQuery)
      ).toList();
    }

    test('Search for "Avatar" returns 1 movie', () {
      final results = searchMovies('Avatar');
      expect(results.length, 1);
      expect(results[0].title, 'Avatar');
    });

    test('Search for "the" returns 2 movies', () {
      final results = searchMovies('the');
      expect(results.length, 2);
      expect(results[0].title, 'The Avengers');
      expect(results[1].title, 'The Wolf of Wall Street');
    });

    test('Search for "300" returns 1 movie', () {
      final results = searchMovies('300');
      expect(results.length, 1);
      expect(results[0].title, '300');
    });

    test('Empty search returns all movies', () {
      final results = searchMovies('');
      expect(results.length, 6);
    });

    test('Case insensitive search works', () {
      final results = searchMovies('avatar');
      expect(results.length, 1);
      expect(results[0].title, 'Avatar');
    });

    test('No matches returns empty list', () {
      final results = searchMovies('xyz123');
      expect(results.length, 0);
    });
  });
}
