import "dart:io";

class GdriveCheck {
  static run() async {
    Directory dir = Directory(
        "G:\\.shortcut-targets-by-id\\17SywrFvvouStFB5OBRKD8vt8zbS72Y4H\\UI8");
    var count = 0;
    await dir.list(recursive: true).forEach((f) async {
      if (f is File) {
        if (f.path.endsWith(".ini")) return;
        if (f.path.endsWith(".gdoc")) return;
        var shortPath = f.path.split("\\UI8\\")[1];
        var myPath = "G:\\Shared drives\\MY SHARED DRIVE HHH\\" + shortPath;

        myPath = myPath.replaceAll("/", "\\");
        if (!File(myPath).existsSync()) {
          print("This File not Exists: $myPath");
          count++;

          Directory dir = Directory(myPath.split('\\').last);
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
}
