import 'package:yo/shared/helper/exec/exec.dart';

class GitHelper {
  static simplePush() {
    exec('git add . && git commit -m "." && git push');
  }
}
