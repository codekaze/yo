import "dart:io";
import 'package:uuid/uuid.dart';
import 'package:yox/shared/helper/exec/exec.dart';

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
        '<script>window.location.href = "https://codekaze.medium.com/docs";</script>');

    var programFilesDir = execr(
      "echo %ProgramFiles%",
    ).toString().trim();

    String zipFileName = "${directoryName}_source_and_docs.zip";
    String zipPath = "c:\\yo_temp\\$zipFileName";
    String zipGoogleDrivePath = "G:\\My Drive\\Codecanyon\\$directoryName\\";

    execLines([
      //WIN RAR
      // '"$programFilesDir\\WinRAR\\Rar.exe" a -ep1 -idq -r -y "$zipPath" "c:\\yo_temp\\$tempDirName\\*"',
      // 7Zip
      [
        '7z a "$zipPath" "c:\\yo_temp\\$tempDirName\\*"',
        'xcopy /S /I /Q /Y /F "$zipPath" "$zipGoogleDrivePath"',
      ].join(" && "),
    ]);

    execLines([
      'rmdir /s /q "c:\\yo_temp\\$tempDirName\\"',
      'del "$zipPath"',
    ]);
  }
}
