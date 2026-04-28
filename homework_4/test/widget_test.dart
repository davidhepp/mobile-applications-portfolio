import 'package:flutter_test/flutter_test.dart';
import 'package:http_demo/db/movie_database.dart';
import 'package:http_demo/main.dart';
import 'package:http_demo/movie.dart';

class FakeMovieRepository implements MovieRepository {
  @override
  Future<void> initialize() async {}

  @override
  Future<List<Movie>> getAllMovies() async {
    return [
      Movie(
        imdbId: 'tt0499549',
        title: 'Avatar',
        plot: 'A marine on Pandora.',
        genre: 'Action, Adventure, Fantasy',
        actors: 'Sam Worthington, Zoe Saldana',
        poster: 'https://example.com/avatar.jpg',
        imdbRating: 7.9,
      ),
    ];
  }

  @override
  Future<List<Movie>> searchMoviesByTitle(String query) async {
    return getAllMovies();
  }
}

void main() {
  testWidgets('loads movies from the repository', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(repository: FakeMovieRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('Avatar'), findsOneWidget);
    expect(find.text('Action, Adventure, Fantasy'), findsOneWidget);
  });
}
