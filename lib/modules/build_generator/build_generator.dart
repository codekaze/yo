import 'dart:io';

import '../../shared/helper/exec/exec.dart';

class BuildGenerator {
  static run() {
    List registeredProjects = [
      r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\generated\barber_app",
      r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\generated\car_rental_app",
      r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\generated\doctor_appointment_app",
      r"C:\Users\Thinkpad\Documents\FLUTTER_PROJECT\codekaze_pos"
    ];

    print(registeredProjects);
    for (var i = 0; i < registeredProjects.length; i++) {
      var target = registeredProjects[i];

      String source =
          target + r"\build\app\outputs\flutter-apk\app-release.apk";
      String gdriveFileName =
          target.toString().split(r"\").last.replaceAll("_", "-") +
              "-release.apk";
      String gdrivePath = "G:\\My Drive\\Codecanyon\\${gdriveFileName}";

      List commands = [
        'cd "$target"'.trim(),
        "flutter build apk --release".trim(),
        'xcopy "$source" "$gdrivePath"* /Y'.trim(),
      ];

      var query = commands.join(" && ").trim();

      print("=====================================");
      print("Query::");
      print("=====================================");
      print("$query");
      print("=====================================");

      execLines([
        query,
      ], workingDirectory: target);
    }
  }
}
