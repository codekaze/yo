import "dart:io";

import 'package:uuid/uuid.dart';
import 'package:yo/core.dart';
import 'package:yo/shared/helper/exec/exec.dart';
import 'package:yo/shared/helper/name_parser/name_parser.dart';
import 'package:yo/shared/helper/template/template.dart';

class ArchiveGenerator {
  static run() async {
    var currentDirectory = execr(
      "echo %cd%",
    ).toString().trim();


    var arr = currentDirectory.split("\\");
    var directoryName = arr.last;

    execLines([
      "flutter clean",
    ]);

    execLines([
      "rmdir /s /q \"$currentDirectory\\test\"",
    ]);

    var uuid = Uuid();
    var tempDirName = uuid.v4();

    execLines([
      "xcopy /S /I /Q /Y /F \"$currentDirectory\" c:\\yo_temp\\$tempDirName\\source\\",
    ]);

    var f = File("c:\\yo_temp\\$tempDirName\\documentation.html");
    f.writeAsStringSync(
        '<script>window.location.href = "https://codekaze.medium.com/documentation-v1-0-365ecec4b2e0";</script>');

    var programFilesDir = execr(
      "echo %ProgramFiles%",
    ).toString().trim();

    execLines([
      '"$programFilesDir\\WinRAR\\Rar.exe" a -ep1 -idq -r -y "c:\\yo_temp\\source_and_docs_$directoryName.zip" "c:\\yo_temp\\$tempDirName\\*"',
      "xcopy /S /I /Q /Y /F \"c:\\yo_temp\\source_and_docs_$directoryName.zip\" \"G:\\My Drive\\Codecanyon\\$directoryName\"",
    ]);

    execLines([
      'rmdir /s /q "c:\\yo_temp\\$tempDirName\\"',
      'del "c:\\yo_temp\\source_and_docs_$directoryName.zip"',
    ]);
  }
}
