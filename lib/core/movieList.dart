import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/core/movieCard.dart';
import 'package:test/model/movie.dart';
import 'package:test/providers/favoriteProvider.dart';
import 'package:test/providers/movieProvider.dart';
import 'package:test/utils/routes.dart';
import 'package:test/utils/utils.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var movies;
  var _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
    _widgetOptions = [Home(), Favorites()];
    movies = Provider.of<MovieProvider>(context, listen: false);
    movies.getAllMovies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movies"),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Utils.mainNavigator.currentState!
                      .pushReplacementNamed(routeLoginView);
                },
                child: Icon(Icons.logout),
              ),
            )
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: _onItemTapped,
        //   currentIndex: _selectedIndex,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.home), title: Text("Inicio")),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.favorite), title: Text("Favoritos"))
        //   ],
        // ),

        body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)));
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    return Consumer<MovieProvider>(builder: (ctx, movieProvider, child) {
      return Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            movieProvider.movies.length > 0
                ? ListView.builder(
                    itemCount: movieProvider.movies.length,
                    itemBuilder: (ctx, indx) =>
                        MovieCard(movieProvider.movies[indx]))
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Utils.mainNavigator.currentState!
                        .pushNamed(routeMovieFavor)
                        .then((value) {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.favorite),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.red),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class Favorites extends StatefulWidget {
  Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // FavoriteProvider favorites = FavoriteProvider();

  // List<Movie> movies = [];
  // @override
  // void initState() {
  //   // favorites.getMovies().then((value) {
  //   //   setState(() {
  //   //     favorites.movies = value;
  //   //   });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    favoriteProvider.getMovies();
    return Scaffold(
        appBar: AppBar(
          title: Text("Favoritos"),
        ),
        body: favoriteProvider.movies.isNotEmpty
            ? ListView.builder(
                itemCount: favoriteProvider.movies.length,
                itemBuilder: (ctx, indx) =>
                    MovieCard(favoriteProvider.movies[indx]))
            : const Center(
                child: Text("Sin peliculas favoritas"),
              ));
  }
}
