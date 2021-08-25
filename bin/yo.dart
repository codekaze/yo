import "dart:io";
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

  var cmdS =
      "curl -o c:/yo/autocrop.exe https://github.com/codekaze/yo/raw/master/python-script/autocrop.exe";

  exec(cmdS);
  exec('SETX PATH "%PATH%;c:/yo"');

  if (args.isEmpty) return;

  var fullArgumentString = args.join(" ");
  var command = args[0];

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
