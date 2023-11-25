import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};


class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);
  final String storagePath;
  final Uint8List bytes;
}


Future<SelectedMedia> selectMedia({
  required double maxWidth,
  required double maxHeight,
  bool isVideo = false,
  bool fromCamera = false, mediaSource,
}) async {
  final picker = ImagePicker();
  final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage(
      maxWidth: maxWidth, maxHeight: maxHeight, source: source);
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
  }
  String? email="";
  final path = storagePath(email, pickedMedia!.path, isVideo);
  return SelectedMedia(path, mediaBytes!);
}

String storagePath(String uid, String filePath, bool isVideo) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  return 'users/$uid/uploads/$timestamp.$ext';
}

bool validateFileFormat(String filePath, BuildContext context) {
  print(filePath);
  print(allowedFormats);
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return true;
}

Future<String?> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  final result = await storageRef.putData(data, metadata);
  return result.state == TaskState.success ? result.ref.getDownloadURL() : null;
}

