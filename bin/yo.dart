import 'dart:developer';
import "dart:io";
import 'package:yo/core.dart';
import 'package:yo/modules/core_generator/core_generator.dart';
import 'package:yo/modules/deploy/deploy.dart';
import 'package:yo/modules/git_helper/git_helper.dart';
import 'package:yo/modules/icon_generator/icon_generator.dart';
import 'package:yo/modules/module_generator/module_generator.dart';
import 'package:yo/modules/project_generator/project_generator.dart';
import 'package:yo/modules/devx_build/devx_build.dart';
import 'package:yo/modules/devx_clean/devx_clean.dart';
import 'package:yo/resources/session/package_info.dart';
import 'package:yo/shared/helper/exec/exec.dart';

void main(List<String> args) async {
  var pubSpecFile = await File("./pubspec.yaml");
  bool hasPubspec = false;
  if (pubSpecFile.existsSync()) {
    await getPackageName();
    hasPubspec = true;
  }

  // await generateDefinedTemplate();
  // await createImport();

  var dir = Directory("c:/yo");
  if (!dir.existsSync()) {
    dir.createSync();
  }

  // if (!File("c:/yo/autocrop.exe").existsSync()) {
  //   print("Generate autocrop.exe");
  //   var cmdS =
  //       'curl -S -H "Authorization: token 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" -o c:/yo/autocrop.exe "https://raw.githubusercontent.com/codekaze/yo/master/python-script/autocrop.exe"';

  //   var f = File("c:/yo/script.bat");
  //   f.writeAsStringSync(cmdS);

  //   exec("c:/yo/script.bat");
  //   exec('SETX PATH "%PATH%;c:\yo"');

  //   print("Generate autocrop.exe DONE");
  //   f.deleteSync();
  // }

  List mustRegisteredPath = [
    "C:\\yo",
    "C:\\flutter\\bin",
    "C:\\flutter\\.pub-cache\\bin",
    "C:\\flutter\\bin\\cache\\dart-sdk\\bin",
    "C:\\flutter\\bin\\cache\\dart-sdk\\bin\\cache\\dart-sdk\\bin",
    "C:\\Program Files\\Android\\Android Studio\\jre",
    //PHP & MYSQL
    "C:\\xampp\\mysql\\bin",
    "C:\\xampp\\php",
  ];

  var fullPath = "";
  mustRegisteredPath.forEach((path) {
    fullPath += ";$path";
  });

  var currentPath = exec("echo %PATH%");
  fullPath = currentPath + fullPath;
  fullPath = fullPath.replaceAll(";;", ";");
  fullPath = fullPath.replaceAll("//", "/");
  fullPath = fullPath.replaceAll("\n", "");
  var arr = fullPath.split(";");

  arr = arr.toSet().toList();
  fullPath = arr.join(";").trim();

  execLines([
    'SETX PATH "$fullPath"',
  ]);

  execLines([
    'SETX JAVA_HOME "C:\\Program Files\\Android\\Android Studio\\jre"',
  ]);

  var fullArgumentString = args.join(" ");
  var command = args.isEmpty ? "" : args[0];

  if (command == "module") {
    if (hasPubspec) {
      await getPackageName();

      if (fullArgumentString.contains("module create")) {
        var moduleName = fullArgumentString.split("module create ")[1];
        print("--------------");
        print("Create Module");
        print("Module Name: $moduleName");
        print("--------------");
        ModuleGenerator.create(moduleName);
      }
    } else {
      print("This command only works on flutter projects directory");
    }
  } else if (command == "init") {
    print("--------------");
    print("DevxInit");
    print("This command will create a project with yo app templates");
    print("--------------");
    ProjectGenerator.create();
  } else if (command == "generate_icon") {
    print("--------------");
    print("Update Icon");
    print("This command will use icon on assets/icon/icon.png");
    print("--------------");
    IconGenerator.create();
  } else if (command == "build") {
    print("--------------");
    print("DevxBuild");
    print("This command will build apk and upload to Google Drive");
    print("--------------");
    WifeBuild.run();
  } else if (command == "clean") {
    print("--------------");
    print("DevxClean");
    print("This command will remove unused imports");
    print("--------------");
    WifeClean.run();
  }
  //Under Development Feature
  else if (command == "core") {
    print("--------------");
    print("This command will generate core file");
    print("--------------");
    CoreGenerator.run();
  } else if (command == "push") {
    print("--------------");
    print("This command will do a simple push with your git");
    print("--------------");
    GitHelper.simplePush();
  } else if (command == "config") {
    print("--------------");
    print("This command will show your current config");
    print("--------------");
    GitHelper.config();
  } else if (command == "add") {
    print("--------------");
    print("This command will do a simple push with your git");
    print("--------------");
    GitHelper.add(fullArgumentString);
  } else if (command == "clone") {
    print("--------------");
    print("This command will do a simple clone with your git");
    print("--------------");
    GitHelper.clone(fullArgumentString);
  } else if (command == "deploy") {
    print("--------------");
    print("This command will do a deploy to website");
    print("--------------");
    Deploy.run(fullArgumentString);
  } else if (command == "check") {
    print("--------------");
    print("This command will Check Google Drive");
    print("--------------");
    // Deploy.run(fullArgumentString);

    Directory dir = Directory(
        "G:\\.shortcut-targets-by-id\\17SywrFvvouStFB5OBRKD8vt8zbS72Y4H\\UI8");
    var count = 0;
    await dir.list(recursive: true).forEach((f) async {
      if (f is File) {
        if (f.path.endsWith(".ini")) return;
        var shortPath = f.path.split("\\UI8\\")[1];
        var myPath = "G:\\Shared drives\\MY SHARED DRIVE HHH\\" + shortPath;

        myPath = myPath.replaceAll("/", "\\");
        if (!File(myPath).existsSync()) {
          print("This File not Exists: $myPath");
          count++;

          var dir = Directory(myPath.split('\\').last);
          if (!dir.existsSync()) {
            dir.createSync(recursive: true);
          }

          File(f.path).copySync(myPath);
          return;
          // await Future.delayed(Duration(seconds: 1000));
        }
        // G:\.shortcut-targets-by-id\17SywrFvvouStFB5OBRKD8vt8zbS72Y4H\UI8\UI8
        // G:\Shared drives\MY SHARED DRIVE HHH\UI8 Files(2018)
      }
    });

    print("Count $count");
  }
  //
  else {
    print("--------------");
    print("Yo");
    print("by Codekaze");
    print("--------------");
    print("Init Project");
    print("code: yo init");
    print("--------------");
    print("Create Module");
    print("code: yo module create [module_name]");
    print("example: yo module create product_list");
    print("example: yo module create product/product_list");
    print("--------------");
    print("Generate Icon");
    print("1. Update icon files in assets/icon/icon.png");
    print("2. Run > yo generate_icon");
    print("--------------");
    print("Remove Unused Import");
    print("1. Run > yo clean");
    print("--------------");
    print("Import all files to core.dart");
    print("1. Run > yo core");
    print("--------------");
  }
}
