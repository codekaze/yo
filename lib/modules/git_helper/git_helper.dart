import 'package:intl/intl.dart';
import 'package:yo/shared/helper/exec/exec.dart';

class GitHelper {
  static simplePush() {
    var dateString = DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now());
    var res = exec('git add . && git commit -m "${dateString}" && git push');
    print(res);
    print(dateString);
  }
}
 