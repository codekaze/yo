import "dart:io";
import 'package:devx/modules/core_generator/core_generator.dart';
import 'package:devx/modules/icon_generator/icon_generator.dart';
import 'package:devx/modules/module_generator/module_generator.dart';
import 'package:devx/modules/project_generator/project_generator.dart';
import 'package:devx/modules/wife_build/wife_build.dart';
import 'package:devx/modules/wife_clean/wife_clean.dart';
import 'package:devx/resources/session/package_info.dart';

void main(List<String> args) async {
  var pubSpecFile = await File("./pubspec.yaml");
  bool hasPubspec = false;
  if (pubSpecFile.existsSync()) {
    await getPackageName();
    hasPubspec = true;
  }

  // await generateDefinedTemplate();
  // await createImport();

  var fullArgumentString = args.join(" ");

  if (fullArgumentString.contains("module create")) {
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
  } else if (fullArgumentString.contains("init")) {
    print("--------------");
    print("Wife Init");
    print("This command will create a project with wife app templates");
    print("--------------");
    ProjectGenerator.create();
  } else if (fullArgumentString.contains("generate_icon")) {
    print("--------------");
    print("Update Icon");
    print("This command will use icon on assets/icon/icon.png");
    print("--------------");
    IconGenerator.create();
  } else if (fullArgumentString.contains("build")) {
    print("--------------");
    print("Wife Build");
    print("This command will build apk and upload to Google Drive");
    print("--------------");
    WifeBuild.run();
  } else if (fullArgumentString.contains("clean")) {
    print("--------------");
    print("Wife Clean");
    print("This command will remove unused imports");
    print("--------------");
    WifeClean.run();
  }
  //Under Development Feature
  else if (fullArgumentString.contains("core")) {
    print("--------------");
    print("Wife Core");
    print("This command will generate core file");
    print("--------------");
    CoreGenerator.run();
  }
  //
  else {
    print("--------------");
    print("Wife Beta");
    print("by Codekaze");
    print("--------------");
    print("Init Project");
    print("code: wife init");
    print("--------------");
    print("Create Module");
    print("code: wife module create [module_name]");
    print("example: wife module create product_list");
    print("example: wife module create product/product_list");
    print("--------------");
    print("Generate Icon");
    print("1. Update icon files in assets/icon/icon.png");
    print("2. Run > wife generate_icon");
    print("--------------");
    print("Remove Unused Import");
    print("1. Run > wife clean");
    print("--------------");
  }
}
