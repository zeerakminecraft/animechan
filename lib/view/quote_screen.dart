import 'package:animechanproject/model/anime_datamodel.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:animechanproject/controller/screenshot.dart';


class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key, required this.anime}) : super(key: key);

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
  final AnimeData anime;
}

class _QuoteScreenState extends State<QuoteScreen> {

  ScreenshotController screenshotController = ScreenshotController();

  // static GlobalKey previewContainer = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      Text(
                        widget.anime.quote,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        '~ ${widget.anime.character}\n\n${widget.anime.anime}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final image = screenshotController.capture();
                  // final result = await ImageGallerySaver.saveImage(image);
                  screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    ShowCapturedWidget(context, capturedImage!);
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
