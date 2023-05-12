import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:songs_link/request.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Search extends StatefulWidget {
  bool isAnimationStarted;
  bool isOpacityAnimationStarted;
  Search({
    Key? key,
    required this.isAnimationStarted,
    required this.isOpacityAnimationStarted,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textController = TextEditingController();
  bool isKeyboardVisible = false;
  late List result;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    result = [];
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        widget.isOpacityAnimationStarted = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        widget.isAnimationStarted = true;
      });
    });
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  Widget PostIt(Map content) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: content['id']['videoId'],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      )
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Container(
        width: 400,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.yellow[200],
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    Center(
                      child: YoutubePlayer(
                        controller: controller,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Image.asset(
                            'assets/pin.png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      content['snippet']['title'],
                      style: const TextStyle(
                          fontSize: 27,
                          fontFamily: 'Pencil_font',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: widget.isOpacityAnimationStarted ? 1 : 0,
          child: const Text(
            '노래 찾기',
            style: TextStyle(fontSize: 60, fontFamily: 'Pencil_font'),
          ),
        ),
        result.isNotEmpty ? const SizedBox(height: 30) : const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: widget.isAnimationStarted
                ? (result.isNotEmpty && !isKeyboardVisible ? 600 : 65)
                : 0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: textController,
                    onFieldSubmitted: (keyword) async {
                      result = await search(keyword);
                      setState(() {});
                    },
                    style: const TextStyle(fontSize: 19.0, color: Colors.black45),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.8),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      hintText: '찾고 싶은 노래를 검색하세요',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 17,
                      ),
                      prefixIcon: widget.isAnimationStarted
                          ? IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () async {
                                result = await search(textController.text);
                                setState(() {});
                              },
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  !isKeyboardVisible && result.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(height: 43),
                            SizedBox(
                              height: 600,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  children:
                                      result.map((e) => PostIt(e)).toList(),
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
