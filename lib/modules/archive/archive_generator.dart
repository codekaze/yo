import "dart:io";
import 'package:uuid/uuid.dart';
import 'package:yox/data/config.dart';
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
      "xcopy /S /I /Q /Y /F \"$currentDirectory\" ${tempDir}\\$tempDirName\\source\\",
    ]);

    var f = File("${tempDir}\\$tempDirName\\documentation.html");
    f.writeAsStringSync(
        '<script>window.location.href = "http://18.219.180.235/docs/";</script>');

    String zipFileName = "${directoryName}_source_and_docs.zip";
    String zipPath = "${tempDir}\\$zipFileName";
    String zipGoogleDrivePath = "${mainGdrivePath}\\$directoryName\\";

    execLines([
      //WIN RAR
      // '"$programFilesDir\\WinRAR\\Rar.exe" a -ep1 -idq -r -y "$zipPath" "${tempDir}\\$tempDirName\\*"',
      // 7Zip
      [
        '7z a "$zipPath" "${tempDir}\\$tempDirName\\*"',
        'xcopy /S /I /Q /Y /F "$zipPath" "$zipGoogleDrivePath"',
      ].join(" && "),
    ]);

    execLines([
      'rmdir /s /q "${tempDir}\\$tempDirName\\"',
      'del "$zipPath"',
    ]);
  }
}
