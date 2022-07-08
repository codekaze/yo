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

  static archive(source, destination) {
    execLines(
      [
        'cd "C:\\Program Files\\WinRAR" && rar a -r -ep1 "$source" "$destination"',
      ],
    );
  }

  static delete(source) {
    execLines([
      'rmdir /s /q "$source"',
      'del "$source"',
    ]);
  }
}
