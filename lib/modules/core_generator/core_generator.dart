import 'dart:io';
import 'package:yo/core.dart';
import 'common_package_exporter.dart';

class CoreGenerator {
  /*
  A serious problem that occurs when we are activated: A package, can have the same class as other packages. So that an error occurs because the same class is recognized as more than 1.
  For now, it is highly recommended not to use it.
  */
  static bool appendExternalImportToCore = false;
  static List externalImportList = [];

  static run() async {
    externalImportList = [];
    List importStringList = [];

    Directory dir = Directory('./lib');
    await dir.list(recursive: true).forEach((f) {
      if (!f.path.endsWith(".dart")) return;
      if (f.path.contains("generated_plugin_registrant.dart")) return;

      var fileName = cleanFileName(f.path);
      var importString = getImportString(fileName);

      importStringList.add(importString);
      cleanImportScript(f.path);
    });

    generateCoreFile(importStringList);

    if (appendExternalImportToCore) {
      appendCoreFileWithExternalImport();
    }

    CommonPackageExporter.run();

    print("CommonPackageExporter:run()");
  }

  static cleanFileName(String fileName) {
    fileName = fileName.replaceAll("./", "");
    fileName = fileName.replaceAll("\\", "/");
    return fileName;
  }

  static getImportString(String fileName) {
    fileName = fileName.substring(4);
    return 'package:$packageName/$fileName';
  }

  static generateCoreFile(List importStringList) {
    // var sorting = ["module", "api", "shared"];
    var content = "";

    importStringList.forEach((importString) {
      content += "export '$importString';\n";
    });

    var file = File("./lib/core.dart");
    file.writeAsStringSync(content);
  }

  static appendCoreFileWithExternalImport() {
    var file = File("./lib/core.dart");
    var content = file.readAsStringSync();

    //Remove Duplicates
    externalImportList = externalImportList.toSet().toList();

    //Remove Common Package
    externalImportList.where((line) =>
        CommonPackageExporter.commonExternalImportList.contains(line));

    content += "\n" + externalImportList.join("\n");

    file.writeAsStringSync(content);
  }

  static cleanImportScript(filePath) {
    if (filePath.toString().contains("core.dart")) return;

    var file = File(filePath);
    var content = file.readAsStringSync();

    List lines = content.split("\n");

    var packageImportInLines = lines
        .where((line) => line.toString().indexOf("package:$packageName") > -1)
        .toList();

    var needImportCore = false;
    if (packageImportInLines.isNotEmpty) {
      var coreImportInlines = lines
          .where((line) => line.toString().indexOf("core.dart") > -1)
          .toList();

      if (coreImportInlines.isEmpty) needImportCore = true;
    }

    lines.removeWhere((line) =>
        line.toString().indexOf("package:$packageName") > -1 &&
        line.toString().indexOf("core.dart") == -1);

    var externalPackageImportLines = lines
        .where(
          (line) =>
              line.toString().startsWith("import") &&
              line.toString().indexOf("package:$packageName") == -1 &&
              line.toString().indexOf("as ") == -1 &&
              line.toString().contains("package:flutter") == false &&
              line.toString().contains("dart:") == false,
        )
        .toList();

    if (appendExternalImportToCore) {
      externalPackageImportLines.removeWhere(
        (line) =>
            line.toString().contains("package:") == false &&
            line.toString().contains("dart:") == false,
      );

      //!important : Its must be removed before change the import String to Export
      lines.removeWhere((line) => externalPackageImportLines.contains(line));

      for (var i = 0; i < externalPackageImportLines.length; i++) {
        externalPackageImportLines[i] = externalPackageImportLines[i]
            .toString()
            .replaceFirst("import", "export");
      }

      externalImportList.addAll(externalPackageImportLines);
    }

    if (needImportCore) {
      var coreImportScript = "import 'package:$packageName/core.dart';";
      lines.insert(0, coreImportScript);
    }

    file.writeAsStringSync(lines.join("\n"));
  }
}
