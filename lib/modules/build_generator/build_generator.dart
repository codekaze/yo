import 'dart:io';

import 'package:uuid/uuid.dart';

import '../../shared/helper/exec/exec.dart';

class BuildGenerator {
  static List registeredProjects = [
    r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\generated\barber_app",
    r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\generated\car_rental_app",
    r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\generated\doctor_appointment_app",
    r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\codekaze_pos"
  ];

  static run() {
    for (var i = 0; i < registeredProjects.length; i++) {
      var target = registeredProjects[i];

      String source =
          target + r"\build\app\outputs\flutter-apk\app-release.apk";
      String gdriveFileName =
          target.toString().split(r"\").last.replaceAll("_", "-") +
              "-release.apk";
      String gdrivePath = "G:\\My Drive\\Codecanyon\\${gdriveFileName}";

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

      String source =
          target + r"\build\app\outputs\flutter-apk\app-release.apk";
      String dirName = target.toString().split(r"\").last.replaceAll("_", "-");
      String gdriveFileName = dirName + "-release.apk";
      String gdrivePath = "G:\\My Drive\\Codecanyon\\${gdriveFileName}";

      var uuid = Uuid();
      var tempDirName = uuid.v4();

      List commands = [
        'cd "$target"'.trim(),
        'flutter clean',
        "xcopy /S /I /Q /Y /F \"$target\" c:\\yo_temp\\$tempDirName\\source\\",
      ];

      var query = commands.join(" && ").trim();
      execLines([
        query,
      ], workingDirectory: target);

      var f = File("c:\\yo_temp\\$tempDirName\\documentation.html");
      f.writeAsStringSync(
          '<script>window.location.href = "https://codekaze.com/docs";</script>');

      var programFilesDir = execr(
        "echo %ProgramFiles%",
      ).toString().trim();

      String zipFileName = "${dirName}_source_and_docs.zip";
      String zipPath = "c:\\yo_temp\\$zipFileName";
      String zipGoogleDrivePath = "G:\\My Drive\\Codecanyon\\$dirName\\";

      execLines([
        //WIN RAR
        // '"$programFilesDir\\WinRAR\\Rar.exe" a -ep1 -idq -r -y "$zipPath" "c:\\yo_temp\\$tempDirName\\*"',
        // 7Zip
        [
          '7z a "$zipPath" "c:\\yo_temp\\$tempDirName\\*"',
          'xcopy /S /I /Q /Y /F "$zipPath" "$zipGoogleDrivePath"',
        ].join(" && "),
      ]);

      // execLines([
      //   'rmdir /s /q "c:\\yo_temp\\$tempDirName\\"',
      //   'del "$zipPath"',
      // ]);
    }
  }
}
