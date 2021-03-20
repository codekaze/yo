import 'dart:io';

import 'package:wife/resources/session/package_info.dart';
import 'package:wife/shared/helper/exec/exec.dart';

class WifeBuild {
  static run() async {
    await getPackageName();
    Directory current = Directory.current;

    var res;

    print("Build APK");
    res = exec("flutter build apk --release");
    print(res);

    var source =
        current.path + r"\build\app\outputs\flutter-apk\app-release.apk";
    var target = Platform.environment['UserProfile'] +
        r"\Google Drive\" +
        packageName +
        ".apk";

    print("Copy File");
    await File(source).copy(target);
  }
}
