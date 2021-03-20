import 'package:yo/shared/helper/exec/exec.dart';

class GitHelper {
  static simplePush() {
    var res = exec('git add . && git commit -m "." && git push');
    print(res);
  }
}
