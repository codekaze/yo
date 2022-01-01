import "dart:io";

import 'package:yox/core.dart';
import 'package:yox/shared/helper/exec/exec.dart';
import 'package:yox/shared/helper/name_parser/name_parser.dart';
import 'package:yox/shared/helper/template/template.dart';

extension StringExtension on String {
  String get fileName {
    var str = this;
    str = str.replaceAll("/", "\\");
    return str.split("\\").last;
  }

  String get fixFormat {
    var str = this;
    str = str.replaceAll("/", "\\");
    return str;
  }
}

class BookingCoreSpitGenerator {
  static run() async {
    Directory currentDir = Directory.current;
    print("Current DIR: ${currentDir.path}");

    var dirs = [];
    Directory("${currentDir.path}/lib/config")
        .listSync(
      recursive: false,
    )
        .forEach((element) {
      if (element is Directory) {
        dirs.add(element.path);
      }
    });

    execLines([
      'rmdir /s /q "${currentDir.path}/build"',
    ]);

    for (var i = 0; i < dirs.length; i++) {
      var appName = dirs[i].toString().fileName;
      var target = '${currentDir.path}/../generated/$appName';

      execLines([
        'rmdir /s /q "$target"',
        'xcopy "${currentDir.path}" "$target" /E/H/C/I',
        'xcopy "${currentDir.path}\\config\\$appName\\assets" "$target\\assets" /E/H/C/I',
        'rmdir /s /q "$target/lib/config/"',
        'rmdir /s /q "$target/lib/config_backup/"',
      ]);

      var dummyApiClassName = "${NameParser.getClassName(appName)}DummyApi";
      var dummyApiFileName =
          "${NameParser.getFileName(appName)}_dummy_api.dart";
      print(dummyApiFileName);

      var f = File('${currentDir.path}/lib/config/$appName/$dummyApiFileName');
      var content = f.readAsStringSync();

      content = content.replaceAll(dummyApiClassName, "MainDummyApi");

      Directory('$target/lib/config/').createSync();
      var tf = File('$target/lib/config/main_dummy_api.dart');
      tf.writeAsStringSync(content);

      //Change Icon
      var appAssetDir =
          '${currentDir.path}/lib/config/$appName/assets/'.fixFormat;
      var projectAssetDir = '${currentDir.path}/assets/'.fixFormat;

      execLines([
        'xcopy "$appAssetDir" "$projectAssetDir" /E/H/C/I/Y/S',
        'flutter pub run flutter_launcher_icons:main',
      ]);

      var androidPackageName = "com.codekaze.$appName";
      print("Rename to $androidPackageName");
      //---------------------
      //!TODO:
      var fileList = Directory("$target")
          .listSync(
            recursive: true,
          )
          .toList();

      for (var x = 0; x < fileList.length; x++) {
        var f = fileList[x];
        if (f is File) {
          if (f.path.endsWith(".dart") ||
              f.path.endsWith(".gradle") ||
              f.path.endsWith(".xml") ||
              f.path.endsWith(".yaml") ||
              f.path.endsWith(".kt")) {
            var content = f.readAsStringSync();
            content = content.replaceAll("booking_core_api", "$appName");

            f.writeAsStringSync(content);
          }
        }
      }
      //---------------------
      execLines([
        "cd \"$target\"",
        "flutter pub global run yoxdev core",
        "flutter pub global run yoxdev generate_icon",
        // "rename --bundleId $androidPackageName",
        "rename --appname \"${NameParser.getTitle(appName)}\"",
        "flutter clean",
        "flutter pub get",
      ], workingDirectory: target);
    }

    return;
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
      var moduleTitleName = NameParser.getTitle(dirName);
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

              runApp(GetMaterialApp(
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

      execLines([
        "cd \"$target\"",
        "rmdir /s /q \"$target\\windows\"",
        "flutter create .",
      ], workingDirectory: target);

      //update main.cpp
      var mainCppFile = File("$target\\windows\\runner\\main.cpp");
      List cppContents = mainCppFile.readAsLinesSync();

      cppContents = [
        "#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>",
        "auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);",
        ...cppContents,
      ];

      mainCppFile.writeAsStringSync(cppContents.join("\r\n"));

      //format code
      execLines([
        "cd \"$target\"",
        "flutter pub global run yox core",
        "rename --bundleId com.codekaze.$dirName",
        "rename --appname \"$moduleTitleName\"",
        "flutter clean",
        "flutter pub get",
      ], workingDirectory: target);

      execLines([
        "rmdir /s /q \"$target\\test\"",
      ], workingDirectory: target);
    });
  }
}
