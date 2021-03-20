import 'package:devx/shared/helper/dir/dir.dart';
import 'package:devx/shared/helper/exec/exec.dart';

class WifeClean {
  static void run() {
    var test = exec("flutter analyze").toString().trim();
    var arr = test.split("\n");

    for (var i = 0; i < arr.length; i++) {
      var line = arr[i];
      if (line.indexOf("Unused import:") != -1) {
        var str = line;
        str = str.replaceAll("info - Unused import: ", "");
        str = str.replaceAll(" - unused_import", "");
        str = str.replaceAll("'", "");
        str = str.trim();

        var packageString = str.split(" - ")[0];
        var path = str.split(" - ")[1].split(":")[0];
        var file = dir(path);
        var content = file.readAsStringSync();
        content = content.replaceAll("import '${packageString}';", "");

        file.writeAsStringSync(content);

        print("Remove unused import @ ${file.path}");
      }
    }
  }
}
