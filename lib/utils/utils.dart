import 'package:flutter/material.dart';

class Utils {
  static GlobalKey<NavigatorState> mainNavigator = GlobalKey<NavigatorState>();
  static const googleKey = 'AIzaSyDbeG8wm-MWYdzhDUxZpJw5xI8C8yFM36U';
  static ImageProvider getPosterImage(String posterPath) {
    if (posterPath.contains(RegExp(r'http', caseSensitive: false))) {
      return NetworkImage(posterPath);
    } else {
      return const NetworkImage(
          "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg");
    }
  }
}
