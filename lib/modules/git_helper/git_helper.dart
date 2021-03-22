import 'package:intl/intl.dart';
import 'package:yo/shared/helper/exec/exec.dart';

class GitHelper {
  static String userName = "";
  static String userEmail = "";

  static simplePush() {
    var dateString = DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now());
    var res = exec('git add . && git commit -m "." && git push');
    print(res);
    print(dateString);
  }

  // its > git remote add origin <url>
  static add(String fullArgumentString) async {
    var githubUrl = fullArgumentString.split(" ")[1];
    githubUrl = convertToSshUrl(githubUrl);
    execr('git init');
    execr('git remote remove origin');
    execr('git remote add origin $githubUrl');
    execr('git config user.name "$userName"');
    execr('git config user.email "$userEmail"');
    execr('git add .');
    execr('git commit -m "."');
    execr('git push --set-upstream origin master --force');
  }

  static convertToSshUrl(String url) {
    /*
    from:  https://github.com/codekaze/yocommerce.git
    to:    git@github.com:codekaze/yocommerce.git
    */

    if (!url.endsWith(".git")) {
      url = url + ".git";
    }

    url = url.replaceAll("https://github.com/", "git@github.com:");

    var arr = url.split(":");
    var username = arr[1].split("/")[0];

    /*
    from: git@github.com:codekaze/yocommerce.git
    to:   git@work:codekaze/yocommerce.git
          git@personal:codekaze/yocommerce.git
    */

    if (username == "codekaze") {
      url = url.replaceAll("github.com", "personal");
      userName = "codekaze";
      userEmail = "codekaze.id@gmail.com";
    } else {
      url = url.replaceAll("github.com", "work");
      userName = "flutterlabz";
      userEmail = "flutterlabz@gmail.com";
    }

    print("username: $username");
    print("url: $url");
    print("userName: $userName");
    print("email: $userEmail");
    return url;
  }
}
