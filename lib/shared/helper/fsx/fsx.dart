import 'dart:io';

import 'package:yox/shared/helper/exec/exec.dart';

class Fsx {
  static copy(source, destination) {
    execLines(
      [
        'xcopy /S /I /Q /Y /F "$source" "$destination"',
      ],
    );
  }

  static copyFile(source, destination) {
    execLines(
      [
        'copy /Y "$source" "$destination"',
      ],
    );
  }

  static archive(source, destination) {
    var command =
        'cd "C:\\Program Files\\WinRAR" && winrar a -ep1 -r -y -afzip "$source" "$destination"';

    print("--------------------------------------");
    print("--------------------------------------");
    print(command);
    print("--------------------------------------");
    print("--------------------------------------");

    execLines(
      [
        // 'cd "C:\\Program Files\\WinRAR" && rar a -r -ep1 "$source" "$destination"',
        command,
      ],
    );
  }

  static delete(source) {
    execLines([
      'rmdir /s /q "$source"',
      'del "$source"',
    ]);
  }

  static createFile({
    String target,
    String content,
  }) {
    var f = File(target);
    if (f.existsSync() == false) {
      f.createSync(
        recursive: true,
      );
    }
    f.writeAsStringSync(content);
  }
}
