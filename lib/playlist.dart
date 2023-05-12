import 'package:flutter/material.dart';

class Playlist extends StatefulWidget {
  final List<Widget> items;
  const Playlist({Key? key, required this.items}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      itemExtent: 200,
      diameterRatio: 3.0,
      children: [
        const Center(
          child: Text(
            'PLAYLIST',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        Container(),
        Container(),
        ...widget.items
      ],
    );
  }
}
