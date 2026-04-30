import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_demo/db/movie_database.dart';
import 'package:http_demo/main.dart';
import 'package:http_demo/movie.dart';
import 'package:http_demo/movie_detail_screen.dart';

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
  Finder _verticalScrollable() => find.byWidgetPredicate(
        (widget) => widget is Scrollable &&
            widget.axisDirection == AxisDirection.down,
      );

  testWidgets('loads movies from the repository', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(repository: FakeMovieRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Movies'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Action, Adventure, Fantasy'),
      300,
      scrollable: _verticalScrollable(),
    );
    expect(find.text('Avatar'), findsWidgets);
    expect(find.text('Action, Adventure, Fantasy'), findsOneWidget);
  });

  testWidgets('navigates to detail screen on tap', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(repository: FakeMovieRepository()));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Action, Adventure, Fantasy'),
      300,
      scrollable: _verticalScrollable(),
    );
    await tester.tap(find.text('Avatar').last);
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailScreen), findsOneWidget);
    expect(find.text('Plot'), findsOneWidget);
    expect(find.text('A marine on Pandora.'), findsOneWidget);
    expect(find.text('Genre'), findsOneWidget);
    expect(find.text('Action, Adventure, Fantasy'), findsWidgets);
    expect(find.text('Actors'), findsOneWidget);
    expect(find.text('Sam Worthington, Zoe Saldana'), findsOneWidget);
  });
}
