import 'package:animechanproject/model/anime_datamodel.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key, required this.anime}) : super(key: key);

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
  final AnimeData anime;
}

class _QuoteScreenState extends State<QuoteScreen> {

  takeScreenShot() async{
    RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    File imgFile = File('$directory/screenshot+${widget.anime.anime}+${widget.anime.character}+${widget.anime.quote}.png');
    imgFile.writeAsBytes(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: takeScreenShot(),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
