import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:yox/data/config.dart';

import '../../shared/helper/exec/exec.dart';

class BuildGenerator {
  static List registeredProjects = [
    "${generatedProjectPath}\\generated\\barber_app",
    "${generatedProjectPath}\\generated\\car_rental_app",
    "${generatedProjectPath}\\generated\\doctor_appointment_app",
    "${generatedProjectPath}\\codekaze_pos"
  ];

  static run() {
    for (var i = 0; i < registeredProjects.length; i++) {
      var target = registeredProjects[i];

      String source =
          target + r"\build\app\outputs\flutter-apk\app-release.apk";
      String gdriveFileName =
          target.toString().split(r"\").last.replaceAll("_", "-") +
              "-release.apk";
      String gdrivePath = "${mainGdrivePath}\\${gdriveFileName}";

      List commands = [
        'cd "$target"'.trim(),
        "flutter build apk --release".trim(),
        'xcopy "$source" "$gdrivePath"* /Y'.trim(),
      ];

      var query = commands.join(" && ").trim();

      print("=====================================");
      print("Query::");
      print("=====================================");
      print("$query");
      print("=====================================");

      execLines([
        query,
      ], workingDirectory: target);
    }
  }

  static archiveAll() {
    for (var i = 0; i < registeredProjects.length; i++) {
      var target = registeredProjects[i];

      String dirName = target.toString().split(r"\").last.replaceAll("_", "-");

      var uuid = Uuid();
      var tempDirName = uuid.v4();

      List commands = [
        'cd "$target"'.trim(),
        'flutter clean',
        "xcopy /S /I /Q /Y /F \"$target\" ${tempDir}\\$tempDirName\\source\\",
      ];

      var query = commands.join(" && ").trim();
      execLines([
        query,
      ], workingDirectory: target);

      var f = File("${tempDir}\\$tempDirName\\documentation.html");
      if (f.existsSync() == false) {
        f.createSync();
      }
      f.writeAsStringSync(
          '<script>window.location.href = "http://18.219.180.235/docs/";</script>');

      String zipFileName = "${dirName}_source_and_docs.zip";
      String zipPath = "${tempDir}\\$zipFileName";
      String zipGoogleDrivePath = "${mainGdrivePath}\\$dirName\\";

      execLines([
        //WIN RAR
        // '"$programFilesDir\\WinRAR\\Rar.exe" a -ep1 -idq -r -y "$zipPath" "${tempDir}\\$tempDirName\\*"',
        // 7Zip
        [
          '7z a "$zipPath" "${tempDir}\\$tempDirName\\*"',
          'xcopy /S /I /Q /Y /F "$zipPath" "$zipGoogleDrivePath"',
        ].join(" && "),
      ]);

      // execLines([
      //   'rmdir /s /q "${tempDir}\\$tempDirName\\"',
      //   'del "$zipPath"',
      // ]);
    }
  }
}
