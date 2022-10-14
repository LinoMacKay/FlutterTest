import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/auth/login.dart';
import 'package:test/core/movieDetail.dart';
import 'package:test/core/movieList.dart';
import 'package:test/providers/favoriteProvider.dart';
import 'package:test/providers/movieProvider.dart';
import 'package:test/utils/routes.dart';
import 'package:test/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
  initializeFirebase();
}

initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => FavoriteProvider()),
          ChangeNotifierProvider(create: (ctx) => MovieProvider()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            navigatorKey: Utils.mainNavigator,
            onGenerateRoute: (settings) {
              Widget page;
              if (settings.name == routeMovieDetail) {
                page = MovieDetail();
              } else if (settings.name == routeMovieFavor) {
                page = Favorites();
              } else if (settings.name == routeLoginView) {
                page = Login();
              } else {
                throw Exception('Unknown route: ${settings.name}');
              }
              return MaterialPageRoute<dynamic>(
                builder: (context) {
                  return page;
                },
                settings: settings,
              );
            },
            home: Login()));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TestingProvider>(
//         builder: (ctx, test, child) => Scaffold(
//               appBar: AppBar(
//                 title: Text(widget.title),
//               ),
//               body: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text(
//                       'You have pushed the button this many times:',
//                     ),
//                     Text(
//                       test.initValue.toString(),
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                   ],
//                 ),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   test.add();
//                 },
//                 tooltip: 'Increment',
//                 child: const Icon(Icons.add),
//               ), // This trailing comma makes auto-formatting nicer for build methods.
//             ));
//   }
// }
