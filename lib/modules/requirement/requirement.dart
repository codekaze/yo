import 'dart:io';

import 'package:yo/shared/helper/exec/exec.dart';

class Requirement {
  static Future<bool> isValid() {
    List<bool> validations = [];
    validations.addAll([
      File('C:\\flutter\\.pub-cache\\bin\\cider.bat').existsSync(),
      File('C:\\flutter\\.pub-cache\\bin\\rename.bat').existsSync(),
    ]);

    if (validations.contains(false)) {
      print("Install required packages ...");
      execLines([
        "flutter pub global activate cider",
      ]);
      execLines([
        "flutter pub global activate rename",
      ]);
      print("Done! Please run this command again!");
      return Future.value(false);
    }
    ;

    return Future.value(true);
  }
}
