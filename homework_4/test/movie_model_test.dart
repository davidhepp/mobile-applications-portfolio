import 'package:flutter_test/flutter_test.dart';
import 'package:http_demo/movie.dart';

void main() {
  group('Movie JSON', () {
    test('Movie.fromJson parses fields', () {
      final json = {
        'imdbID': 'tt0499549',
        'Title': 'Avatar',
        'Plot': 'A marine on Pandora.',
        'Genre': 'Action, Adventure, Fantasy',
        'Actors': 'Sam Worthington, Zoe Saldana',
        'Poster': 'https://example.com/avatar.jpg',
        'imdbRating': '7.9',
      };

      final movie = Movie.fromJson(json);

      expect(movie.imdbId, 'tt0499549');
      expect(movie.title, 'Avatar');
      expect(movie.plot, 'A marine on Pandora.');
      expect(movie.genre, 'Action, Adventure, Fantasy');
      expect(movie.actors, 'Sam Worthington, Zoe Saldana');
      expect(movie.poster, 'https://example.com/avatar.jpg');
      expect(movie.imdbRating, 7.9);
    });

    test('Movie.toJson serializes fields', () {
      final movie = Movie(
        imdbId: 'tt0499549',
        title: 'Avatar',
        plot: 'A marine on Pandora.',
        genre: 'Action, Adventure, Fantasy',
        actors: 'Sam Worthington, Zoe Saldana',
        poster: 'https://example.com/avatar.jpg',
        imdbRating: 7.9,
      );

      final json = movie.toJson();

      expect(json['imdbID'], 'tt0499549');
      expect(json['Title'], 'Avatar');
      expect(json['Plot'], 'A marine on Pandora.');
      expect(json['Genre'], 'Action, Adventure, Fantasy');
      expect(json['Actors'], 'Sam Worthington, Zoe Saldana');
      expect(json['Poster'], 'https://example.com/avatar.jpg');
      expect(json['imdbRating'], '7.9');
    });
  });
}
