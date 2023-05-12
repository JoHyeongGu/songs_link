import 'package:flutter/material.dart';
import 'package:songs_link/playlist.dart';
import 'package:songs_link/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isAnimationStarted;
  late bool isOpacityAnimationStarted;
  @override
  void initState() {
    super.initState();
    isAnimationStarted = false;
    isOpacityAnimationStarted = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: PageView(
                children: [
                  Search(isAnimationStarted: isAnimationStarted, isOpacityAnimationStarted: isOpacityAnimationStarted,),
                  const Playlist(items: [Text('text')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
