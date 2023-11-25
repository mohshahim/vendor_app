

import 'package:flutter/material.dart';
import '../theme/color.dart';

class Imageview extends StatefulWidget {
  var image;

  Imageview({Key? key, this.image}) : super(key: key);

  @override
  State<Imageview> createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
      ),
      body: InteractiveViewer(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(widget.image),
        ),
      ),
    );
  }
}
