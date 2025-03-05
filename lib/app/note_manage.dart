import 'package:get/get.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:top_back/app/pages/home/controller/home_controller.dart';
import 'package:top_back/bean/bean_draft.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class NoteManage with RequestMixin {
  static final NoteManage _instance = NoteManage._();
  NoteManage._();
  factory NoteManage() => _instance;

  bool isLoading = false;

  List<BeanDraft> draftList = [];

  final HomeController homeCtr = Get.find<HomeController>();

  Future<void> publishNote(BeanDraft draft) async {
    draftList.insert(0, draft);
    if (isLoading) return;
    startPublish();
  }

  Future<void> startPublish() async {
    if (draftList.isEmpty) return;

    isLoading = true;
    BeanDraft draft = draftList.removeLast();
    homeCtr.updatePub(true, draft.noteId == 0);

    for (var material in draft.materialList) {
      if (material.imgLink.isNotEmpty) continue;
      if (material.imgData == null) {
        showToast("资源不能为空");
        isLoading = false;
        homeCtr.updatePub(false, draft.noteId == 0);
        startPublish();
        return;
      }

      if (material.type == 1) {
        String name = getName(draft.createBy, material.imgName);
        String url = await upload(material.imgData!, name);
        material.imgLink = url;
        if (url.isEmpty) {
          showToast("上传资源失败");
          isLoading = false;
          homeCtr.updatePub(false, draft.noteId == 0);
          startPublish();
          return;
        }
      } else {
        String name = getName(draft.createBy, material.imgName);
        String url = await uploadVideo(material.imgData!, name);
        material.imgLink = url;
        if (url.isEmpty) {
          showToast("上传资源失败");
          isLoading = false;
          homeCtr.updatePub(false, draft.noteId == 0);
          startPublish();
          return;
        }

        if (material.thumbData != null) {
          String thumbName =
              getName(draft.createBy, material.imgName, s: ".jpg");
          String thumbUrl = await upload(material.thumbData!, thumbName);
          material.imgThumb = thumbUrl;
        }
      }
    }

    if (draft.cover.imgLink.isEmpty) {
      if (draft.cover.imgData != null) {
        String name = getName(draft.createBy, draft.cover.imgName);
        String url = await upload(draft.cover.imgData!, name);

        if (url.isEmpty) {
          showToast("上传资源失败");
          isLoading = false;
          homeCtr.updatePub(false, draft.noteId == 0);
          startPublish();
          return;
        }

        draft.cover.imgLink = url;
      } else {
        draft.cover.imgLink = draft.materialList.first.imgThumb;
      }
    }

    Map<String, dynamic> extra = {};
    if (draft.materialList.first.type == 1) {
      if (draft.materialList.first.imgData != null) {
        var input = MemoryInput(draft.materialList.first.imgData!);
        final result = ImageSizeGetter.getSizeResult(input);
        extra["frame_w"] = result.size.width;
        extra["frame_h"] = result.size.height;
      }
    } else {
      if (draft.materialList.first.thumbData != null) {
        var input = MemoryInput(draft.materialList.first.thumbData!);
        final result = ImageSizeGetter.getSizeResult(input);
        extra["frame_w"] = result.size.width;
        extra["frame_h"] = result.size.height;
        extra["frame_s"] = 0;
      }
    }

    if (draft.noteId == 0) {
      await requestPub(draft);
    } else {
      await requestModify(draft);
    }
    isLoading = false;
    homeCtr.updatePub(false, draft.noteId == 0);
    startPublish();
  }

  String getName(int user, String path, {String? s}) {
    int dot = path.lastIndexOf(".");
    String suffix = s ?? path.substring(dot);
    return "note/$user/${DateTime.now().microsecondsSinceEpoch}$suffix";
  }

  Future<void> requestPub(BeanDraft draft) async {
    await post(
      HttpConstants.publish,
      param: {
        "cover": draft.cover.imgLink,
        "title": draft.title,
        "textContent": draft.textContent,
        "extra": draft.extra,
        "materialList": draft.materialList
            .map((x) => {"thumb": x.imgThumb, "url": x.imgLink, "type": x.type})
            .toList(),
        "noteType": draft.noteType,
        "tendency": draft.tendency,
        "status": draft.status,
        "topicList": draft.topicList,
        "createBy": draft.createBy
      },
      success: (_) => showToast("发布成功"),
    );
  }

  Future<void> requestModify(BeanDraft draft) async {
    await post(
      HttpConstants.updateNote,
      param: {
        "noteId": draft.noteId,
        "cover": draft.cover.imgLink,
        "title": draft.title,
        "textContent": draft.textContent,
        "extra": draft.extra,
        "materialList": draft.materialList
            .map((x) => {"thumb": x.imgThumb, "url": x.imgLink, "type": x.type})
            .toList(),
        "noteType": draft.noteType,
        "tendency": draft.tendency,
        "status": draft.status,
        "updateMaterial": draft.updateMaterial,
        "updateTopic": draft.updateTopic,
        "topicList": draft.topicList
      },
      success: (_) => showToast("修改成功"),
    );
  }
}
