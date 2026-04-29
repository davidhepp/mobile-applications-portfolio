import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: movie.poster.isNotEmpty
                  ? Image.network(
                      movie.poster,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.movie, size: 120);
                      },
                    )
                  : const Icon(Icons.movie, size: 120),
            ),

            const SizedBox(height: 24),

            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  movie.imdbRating.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              'Genre',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(movie.genre),

            const SizedBox(height: 16),

            Text(
              'Actors',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(movie.actors),

            const SizedBox(height: 16),

            Text(
              'Plot',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(movie.plot),
          ],
        ),
      ),
    );
  }
}