import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(title: 'Avengers: Endgame', year: 2019, genres: ['Action', 'Sci-Fi'], posterUrl: 'https://image.tmdb.org/t/p/w200/or06FN3Dka5tukK1e9sl16pB3iy.jpg', rating: 8.4),
  Movie(title: 'The Matrix', year: 1999, genres: ['Action', 'Sci-Fi'], posterUrl: 'https://image.tmdb.org/t/p/w200/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg', rating: 8.7),
  Movie(title: 'Titanic', year: 1997, genres: ['Drama', 'Romance'], posterUrl: 'https://image.tmdb.org/t/p/w200/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg', rating: 7.9),
  Movie(title: 'The Godfather', year: 1972, genres: ['Crime', 'Drama'], posterUrl: 'https://image.tmdb.org/t/p/w200/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', rating: 9.2),
  Movie(title: 'Inception', year: 2010, genres: ['Action', 'Sci-Fi', 'Thriller'], posterUrl: 'https://image.tmdb.org/t/p/w200/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg', rating: 8.8),
  Movie(title: 'Toy Story', year: 1995, genres: ['Animation', 'Comedy'], posterUrl: 'https://image.tmdb.org/t/p/w200/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg', rating: 8.3),
];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find a Movie',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';

  final List<String> genres = ['Action', 'Sci-Fi', 'Drama', 'Romance', 'Crime', 'Thriller', 'Animation', 'Comedy'];
  final List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  @override
  Widget build(BuildContext context) {
    List<Movie> visibleMovies = allMovies.where((m) {
      final matchesSearch = m.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenres.isEmpty || selectedGenres.any((g) => m.genres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    visibleMovies.sort((a, b) {
      if (selectedSort == 'A-Z') return a.title.compareTo(b.title);
      if (selectedSort == 'Z-A') return b.title.compareTo(a.title);
      if (selectedSort == 'Year') return b.year.compareTo(a.year);
      if (selectedSort == 'Rating') return b.rating.compareTo(a.rating);
      return 0;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Find a Movie')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search movie...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (val) => setState(() => searchQuery = val),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: genres.map((g) {
                  final isSelected = selectedGenres.contains(g);
                  return FilterChip(
                    label: Text(g),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(g);
                        } else {
                          selectedGenres.remove(g);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: selectedSort,
                items: sortOptions.map((s) => DropdownMenuItem(value: s, child: Text('Sort by: $s'))).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedSort = val);
                  }
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          final m = visibleMovies[index];
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                m.posterUrl, 
                                width: 50, 
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => const Icon(Icons.movie),
                              ),
                              title: Text(m.title),
                              subtitle: Text('${m.year} • Rating: ${m.rating}'),
                            ),
                          );
                        },
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          final m = visibleMovies[index];
                          return Card(
                            child: Row(
                              children: [
                                Image.network(
                                  m.posterUrl, 
                                  width: 80, 
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) => const Icon(Icons.movie, size: 80),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(m.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text('${m.year} • Rating: ${m.rating}'),
                                      Text(m.genres.join(', ')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
