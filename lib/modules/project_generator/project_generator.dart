import 'dart:io';
import 'package:devx/shared/helper/exec/exec.dart';

class ProjectGenerator {
  static create() async {
    var dir = Directory.current;
    if (dir.listSync().isNotEmpty) {
      print("Current directory is not empty");
      print("If you continue, the contents of this directory will be deleted.");
      writeSeparator();
      var confirm = getInput(
        message: "Continue? (Y/N)",
      );

      if (confirm.toLowerCase() == "n") {
        return;
      }
    }

    writeSeparator();
    var applicationName = getInput(
      message: "1. Application Name:",
    );

    var packageName = getInput(
      message: "2. Package Name:",
    );

    writeSpace();
    writeSeparator();
    writeSeparator();
    print("Confirm:");
    print("Applicaton Name : ${applicationName}");
    print("Package Name : ${packageName}");
    writeSeparator();
    writeSeparator();
    print("Create DevxProject? (Y/N)");
    var confirm = getInput();

    if (confirm.toString().toLowerCase() == "n") {
      return;
    }

    // dir.deleteSync(
    //   recursive: true,
    // );

    List items = dir.listSync();
    for (var item in items) {
      if (item is File) {
        File file = item;
        file.deleteSync();
      } else if (item is Directory) {
        Directory dir = item;
        dir.deleteSync(
          recursive: true,
        );
      }
    }

    // exec('del /s /q /f .git');
    // exec('del /s /q /f .git');
    // exec('del /s /q /f *');
    exec('git clone https://github.com/codekaze/codekaze_app .');

    // print(res);
    // exec('del /s /q /f .git');

    // var dir = Directory.current;

    // var filePath = "$dir/pubspec.yaml";

    // filePath = filePath.replaceAll("'", "");
    // filePath = filePath.replaceAll("\\", "/");
    // print(filePath);

    await updatePackageName(packageName);
    await updateApplicationName(applicationName);

    var p = File("./pubspec.yaml");
    print(p.existsSync());
    // // print(p.readAsStringSync());

    exec("git remote remove origin");

    writeSeparator();
    print("DevxProject Created!");
    writeSeparator();
  }

  static updatePackageName(packageName) async {
    List files = [
      "android/app/build.gradle",
      "android/app/src/debug/AndroidManifest.xml",
      "android/app/src/main/AndroidManifest.xml",
      "android/app/src/main/kotlin/com/example/demo_app/MainActivity.kt",
      "android/app/src/main/kotlin/com/example/demo_app/MainActivity.kt",
      "android/app/src/profile/AndroidManifest.xml",
    ];

    files.forEach((filePath) {
      File file = File(filePath);
      var content = file.readAsStringSync();
      content = content.replaceAll("com.example.codekaze_app", packageName);
      file.writeAsStringSync(content);
    });
  }

  static updateApplicationName(applicationName) async {
    List files = [
      "android/app/src/main/AndroidManifest.xml",
    ];

    files.forEach((filePath) {
      File file = File(filePath);
      var content = file.readAsStringSync();
      content = content.replaceAll("Codekaze App", applicationName);
      file.writeAsStringSync(content);
    });
  }
}
