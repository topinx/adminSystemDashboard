import 'dart:convert';
import 'dart:typed_data';

import 'package:top_back/bean/bean_note_detail.dart';

class BeanDraft {
  int noteId = 0;

  int noteType = 1;

  String title = "";

  String textContent = "";

  DraftMaterial cover = DraftMaterial();

  List<DraftMaterial> materialList = [];

  int status = 1;

  int tendency = 3;

  int createBy = 0;

  String createByNickname = "";

  List<String> topicList = [];

  String extra = "";

  bool updateMaterial = false;

  bool updateTopic = false;

  int? classifyId;

  BeanDraft();

  factory BeanDraft.fromNoteDetail(BeanNoteDetail detail) {
    List<String> topics = detail.topicList.isEmpty
        ? []
        : json.decode(detail.topicList).toList().cast<String>();

    String content = detail.textContent;
    for (var t in topics) {
      content = content.replaceAll("$t^", "");
    }

    return BeanDraft()
      ..noteId = detail.noteId
      ..noteType = detail.noteType
      ..title = detail.title
      ..textContent = content
      ..materialList = detail.materialList
          .map((x) => DraftMaterial()
            ..imgThumb = x.thumb
            ..imgLink = x.url
            ..type = x.type)
          .toList()
          .cast<DraftMaterial>()
      ..status = detail.status
      ..tendency = detail.tendency
      ..createBy = detail.createBy
      ..createByNickname = detail.createByNickname
      ..topicList = topics
      ..extra = detail.extra
      ..updateMaterial = false
      ..updateTopic = false
      ..classifyId = detail.classifyId;
  }
}

/// 如果本地选择的资源 赋值imgData
/// imgData不为空先渲染imgData
class DraftMaterial {
  String imgThumb = "";

  String imgLink = "";

  String imgName = "";

  Uint8List? imgData;

  Uint8List? thumbData;

  int type = 1;

  DraftMaterial();
}
