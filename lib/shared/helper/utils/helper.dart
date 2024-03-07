import 'dart:developer';
// import 'dart:io' as io;
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:getitgodriver/shared/helper/di.dart';

import 'package:path_provider/path_provider.dart';

import '../../constants/color.dart';
import '../../constants/font_family.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  final ImagePicker picker = ImagePicker();
  List<XFile> pickedFile = [];
  static showLoading(String? message) {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.whiteColor),
            padding: const EdgeInsets.all(16),
            width: Get.width,
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  message ?? 'Loading, please wait'.tr,
                  style: kManrope.copyWith(
                      color: AppColors.blackColor,
                      fontSize: kFont14,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}

class UploadHelper {
  late final FirebaseRemoteConfig remoteConfig;
  late final String imagePath;
  UploadHelper() {
    remoteConfig = Get.find<FirebaseRemoteConfig>();
    imagePath =
        remoteConfig.getString('${DependencyInject.buildMode}_images_path');
  }

  Future<XFile> downloadFile(String url) async {
    try {
      Reference ref = _getRefFromUrl(url);
      final fileData = await ref.getData();
      if (fileData == null) {
        throw 'Something went wrong';
      }
      final appDir = await getApplicationDocumentsDirectory();
      final String path = '${appDir.path}/image.jpg';
      final file = File(path);
      await file.writeAsBytes(fileData);
      return XFile(path);
    } on Exception catch (e) {
      e.printError();
      rethrow;
    }
  }

  Future<String?> createThumbnail(String url) async {
    try {
      XFile thumbnail = await downloadFile(url);
      return await uploadFile(thumbnail, quality: 10);
    } on Exception catch (e) {
      e.printError();
      rethrow;
    }
  }

  Reference _getRefFromUrl(String url) {
    final Uri fileUri = Uri.parse(url);
    final List<String> pathFragments = fileUri.path.split('/');
    return FirebaseStorage.instance.ref().child(imagePath).child(
        '/${pathFragments[pathFragments.length - 1].replaceFirst('$imagePath%2F', '')}');
  }

  Future<String?> uploadFile(XFile rawFile, {int? quality}) async {
    try {
      final XFile file = await testCompressAndGetFile(
          rawFile,
          rawFile.path.replaceAll(rawFile.name,
              DateTime.now().millisecondsSinceEpoch.toString() + rawFile.name),
          quality: quality);
      TaskSnapshot uploadTask;

      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(imagePath)
          .child('/${file.name}');
      log(ref.toString());

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path},
      );

      if (kIsWeb) {
        uploadTask = await ref.putData(await file.readAsBytes(), metadata);
      } else {
        uploadTask = await ref.putFile(File(file.path), metadata);
        log(uploadTask.totalBytes.toString());
      }
      return uploadTask.ref.getDownloadURL();
    } on Exception catch (e) {
      print(e.toString());
      e.printError();
      rethrow;
    }
  }

  static Future<XFile> testCompressAndGetFile(XFile file, String targetPath,
      {int? quality}) async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        quality: quality ?? 50,
      ).catchError((e) {
        throw 'Error while compressing, please try again.';
      });
      if (result == null) {
        throw 'Error while compressing, please try again.';
      }
      return result;
    } on Exception catch (e) {
      e.printError();
      throw 'Error while compressing, please try again.';
    }
  }

  Future<void> deleteFile(String url) async {
    try {
      return await _getRefFromUrl(url).delete();
    } on Exception catch (e) {
      e.printError();
      rethrow;
    }
  }
}
