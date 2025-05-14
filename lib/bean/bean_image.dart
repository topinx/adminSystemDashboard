import 'package:flutter/foundation.dart';

class XMLImage {
  String name;

  Uint8List bytes;

  XMLImage(this.name, this.bytes);
}

class BeanImage {
  String imgLink = "";

  XMLImage? imgData;

  BeanImage(this.imgLink, this.imgData);
}
