import 'dart:convert';
import 'dart:io';

import 'package:process_run/shell.dart';

dynamic execr(
  String cmd, {
  String workingDirectory: null,
}) {
  print("#: $cmd");
  var res = exec(
    cmd,
    displayResult: true,
    workingDirectory: workingDirectory,
  );
  print(res);
  return res;
}

dynamic exec(
  String cmd, {
  bool displayResult = false,
  String workingDirectory: null,
}) {
  if (cmd.startsWith("cd ")) {
    writeSeparator();
    writeSeparator();
    print("change directory is not supported yet, please use execLines");
    writeSeparator();
    writeSeparator();
  }

  var res = Process.runSync(
    "$cmd",
    [],
    workingDirectory: null,
    runInShell: true,
  );
  return res.stdout;
}

dynamic execLines(
  List<String> commandList, {
  String workingDirectory,
}) {
  writeSeparator();
  print("ExecLines CommandList:");
  print(commandList);
  writeSeparator();

  var tempFilePath = "c:/yo_temp/temp_file_win.bat";
  Directory("c:/yo_temp/").createSync();
  File ff = File(tempFilePath);
  ff.writeAsStringSync(commandList.join("\n"));
  var res = execr(
    tempFilePath,
    workingDirectory: workingDirectory,
  );
  ff.deleteSync();
  return res;
}

dynamic changeDirectory(String dirName) async {
  var shell = Shell();
  await shell.run('ls');
// Go into test
  shell = shell.cd('zen');
  await shell.run('ls');
// Go up
  // shell = shell.cd('..');
  // await shell.run('ls');
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
