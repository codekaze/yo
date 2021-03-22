import 'dart:convert';
import 'dart:io';

dynamic execr(String cmd) {
  print("#: $cmd");
  var res = exec(cmd, displayResult: true);
  print(res);
}

dynamic exec(
  String cmd, {
  bool displayResult = false,
}) {
  var res = Process.runSync(
    "$cmd",
    [],
    runInShell: true,
  );
  return res.stdout;
}

String getInput({
  String message,
}) {
  if (message != null) {
    print(message);
  }
  return stdin.readLineSync(
    encoding: Encoding.getByName('utf-8'),
  );
}

writeSeparator() {
  print("--------------");
}

writeSpace() {
  print("");
  print("");
  print("");
}
