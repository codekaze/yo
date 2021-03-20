import 'package:intl/intl.dart';
import 'package:yo/shared/helper/exec/exec.dart';

class GitHelper {
  static simplePush() {
    var dateString = DateFormat("d, M").format(DateTime.now());
    var res = exec('git add . && git commit -m "." && git push');
    print(res);
  }
}
