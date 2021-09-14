import "dart:io";

import 'package:yo/shared/helper/exec/exec.dart';
import 'package:yo/shared/helper/template/template.dart';

class SpitGenerator {
  static run() async {
    var dir = Directory(
        "C:\\Users\\User\\Documents\\FLUTTER_PROJECT\\codekaze_ui_kit_project");

    var module = Directory(dir.path + "\\lib\\module");
    List moduleDirs = [];
    await module.list(recursive: false).forEach((f) async {
      if (f is Directory) {
        var dirName = f.path.split("\\").last;
        print(dirName);
        moduleDirs.add(dirName);
      }
    });

    print(">>>");
    print(moduleDirs);

    execLines(["rmdir /s /q \"${dir.path}\\build\""]);

    moduleDirs.forEach((dirName) {
      if (dirName == "main_dashboard") return;
      var target =
          "C:\\Users\\User\\Documents\\FLUTTER_PROJECT\\ui_kit_project\\$dirName";
      execLines([
        "xcopy \"${dir.path}\" \"$target\" /E/H/C/I",
        "rmdir /s /q \"$target\\.git\"",
      ]);

      //Remove Unused Modules
      moduleDirs.forEach((subMDirs) {
        if (subMDirs != dirName) {
          execLines([
            "rmdir /s /q \"$target\\lib\\module\\$subMDirs\"",
          ]);
        }
      });

      //Update main.dart
      var configDartFile =
          File(dir.path + "\\lib\\module\\$dirName\\config.dart");
      var lines = configDartFile.readAsLinesSync();
      var importString = lines[0];
      var mainNavigationClass =
          lines[2].split("home = ").last.replaceAll(";", "");

      print(dirName);
      print(configDartFile.path);
      print(lines[2]);
      print(mainNavigationClass);

      var mainDartFile = File(target + "\\lib\\main.dart");

      mainDartFile.writeAsStringSync("""
            import 'package:codekaze_free_ui_kit/main_setup.dart';
            import 'package:flutter/material.dart';

            import 'global/theme/traveL_theme.dart';
            $importString

            void main() async {
              await MainSetup.setup();

              runApp(MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: travelTheme,
                home: $mainNavigationClass,
              ));
            }
          """);

      Template.format(mainDartFile.path);

      //===================

      //format code
      execLines([
        "cd \"$target\"",
        "flutter pub global run yo core",
        "flutter clean",
        "flutter pub get",
      ], workingDirectory: target);
    });
  }
}
