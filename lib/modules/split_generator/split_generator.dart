import "dart:io";

import 'package:yo/shared/helper/exec/exec.dart';
import 'package:yo/shared/helper/name_parser/name_parser.dart';
import 'package:yo/shared/helper/template/template.dart';

class SpitGenerator {
  static run() async {
    var userPath = execr(
      "echo %USERPROFILE%",
    ).toString().trim();

    var dir = Directory(
        "$userPath\\Documents\\FLUTTER_PROJECT\\codekaze_ui_kit_project");

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
          "$userPath\\Documents\\FLUTTER_PROJECT\\ui_kit_project\\$dirName";

      var copyTheme =
          "xcopy \"${dir.path}\\lib\\module\\$dirName\\theme.dart\" \"$target\\lib\\module\\$dirName\\theme.dart\" /F";
      var themeVariableName = NameParser.getVariableName(dirName) + "Theme";
      print("CopyTheme: $copyTheme");

      execLines([
        "rmdir /s /q \"$target\"",
        "xcopy \"${dir.path}\" \"$target\" /E/H/C/I",
        "rmdir /s /q \"$target\\.git\"",
        copyTheme,
      ]);

      //Remove Unused Modules
      moduleDirs.forEach((subMDirs) {
        if (subMDirs != dirName) {
          execLines([
            "rmdir /s /q \"$target\\lib\\module\\$subMDirs\"",
            "del \"$target\\lib\\generated_plugin_registrant.dart",
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
            import 'package:bitsdojo_window/bitsdojo_window.dart';
            import 'package:codekaze_free_ui_kit/main_setup.dart';
            import 'package:flutter/material.dart';

            import 'module/$dirName/theme.dart';
            $importString

            void main() async {
              await MainSetup.setup();

              runApp(MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: $themeVariableName,
                home: $mainNavigationClass,
              ));

              doWhenWindowReady(() {
                final initialSize = Size(420, 860);
                appWindow.minSize = initialSize;
                appWindow.size = initialSize;
                appWindow.alignment = Alignment.centerRight;
                appWindow.show();
              });              
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
