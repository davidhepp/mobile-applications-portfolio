import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'movie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 34,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 6),
                      Text(
                        movie.imdbRatingText,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${movie.imdbVotesText} votes',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildInfoChip(movie.year),
                      _buildInfoChip(movie.runtime),
                      _buildInfoChip(movie.rated),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Genre'),
                  Text(movie.genre),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Plot'),
                  Text(movie.plot),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Actors'),
                  Text(movie.actors),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Director'),
                  Text(movie.director),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Awards'),
                  Text(movie.awards),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Languages'),
                  Text(movie.language),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Countries'),
                  Text(movie.country),
                  if (movie.images.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _buildSectionTitle(context, 'Gallery'),
                    const SizedBox(height: 8),
                    _buildGallery(context, movie.images),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _networkImage(movie.heroImageUrl),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xCC000000),
                  Color(0x22000000),
                  Color(0xDD000000),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: -36,
          child: Hero(
            tag: movie.posterHeroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _networkImage(
                movie.poster,
                width: 120,
                height: 180,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.bebasNeue(
        fontSize: 20,
        letterSpacing: 1.0,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        label.isNotEmpty ? label : 'N/A',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildGallery(BuildContext context, List<String> images) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _networkImage(
              images[index],
              width: 180,
              height: 120,
            ),
          );
        },
      ),
    );
  }

  Widget _networkImage(
    String url, {
    double? width,
    double? height,
  }) {
    if (url.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.black12,
        child: const Icon(Icons.movie, size: 40),
      );
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.black12,
          child: const Icon(Icons.movie, size: 40),
        );
      },
    );
  }
}