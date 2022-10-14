import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/movie.dart';
import 'package:test/providers/favoriteProvider.dart';
import 'package:test/utils/utils.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool isFavorite = false;
  FavoriteProvider favorites = FavoriteProvider();

  @override
  void initState() {
    print(favorites.database);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    Widget movieDataTitle(text, double fontsize) {
      return Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontsize,
            overflow: TextOverflow.ellipsis),
      );
    }

    Widget moviePic() {
      return Container(
        width: screenWidth,
        height: screenHeight * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Utils.getPosterImage(movie.image), fit: BoxFit.cover),
        ),
      );
    }

    Widget movieDataText(text) {
      return Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          overflow: TextOverflow.visible,
          fontSize: 18,
        ),
      );
    }

    Widget movieBody(FavoriteProvider provider) {
      favorites.find(movie.id).then((value) {
        if (value != null) {
          setState(() {
            isFavorite = true;
          });
        }
      });

      return Material(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44), topRight: Radius.circular(44)),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(20),
          width: screenWidth,
          height: screenHeight * 0.62,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: screenWidth * 0.75,
                        child: movieDataTitle(movie.title.toUpperCase(), 30)),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            if (!isFavorite) {
                              favorites.insert(movie).then((value) {
                                setState(() {
                                  isFavorite = true;
                                });
                              });
                            } else {
                              favorites.delete(movie.id).then((value) {
                                setState(() {
                                  isFavorite = false;
                                });
                              });
                            }
                          });
                        },
                        icon: isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: movieDataTitle("Rating", 20)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: movieDataText(movie.rating)),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: movieDataTitle("Fecha de lanzamiento", 20)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: movieDataText(movie.release)),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: movieDataTitle("Descripcion", 20)),
                movieDataText(movie.description)
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(44), topRight: Radius.circular(44)),
              color: Colors.white),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: Consumer<FavoriteProvider>(
          builder: (ctx, provider, child) => SafeArea(
              child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                moviePic(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: movieBody(provider)),
              ],
            ),
          )),
        ));
  }
}
