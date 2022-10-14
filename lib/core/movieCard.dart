import 'package:flutter/material.dart';
import 'package:test/model/movie.dart';
import 'package:test/providers/favoriteProvider.dart';
import 'package:test/utils/routes.dart';
import 'package:test/utils/utils.dart';

class MovieCard extends StatefulWidget {
  Movie movie;
  MovieCard(this.movie);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Utils.mainNavigator.currentState!
            .pushNamed(routeMovieDetail, arguments: widget.movie)
            .then((value) {});
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  image: Utils.getPosterImage(widget.movie.image))),
          margin: const EdgeInsets.all(5),
          width: screenWidth,
          height: screenHeight * 0.25,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.5),
                  Colors.black.withOpacity(.1),
                ])),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Wrap(
                alignment: WrapAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.movie.title,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
