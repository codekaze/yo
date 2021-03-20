import 'package:yo/shared/helper/name_parser/name_parser.dart';

class ModuleViewTemplate {
  static get(ParsedName m) {
    var template = '''
    import 'package:flutter/material.dart';
    ${m.controllerImportScript}
    import 'package:get/get.dart';

    class ExampleView extends StatelessWidget {
      final controller = Get.put(ExampleController());
      
      @override
      Widget build(BuildContext context) {
        controller.view = this;
        
        return GetBuilder<ExampleController>(
          builder: (_) {
            return Scaffold(
              appBar: AppBar(
                title: Text("ModuleTitle"),
              ),
            );
          },
        );
      }
    }
    ''';

    template = template.replaceAll("Example", m.className);
    template = template.replaceAll("example", m.fileName);
    template = template.replaceAll("ModuleTitle", m.title);

    return template;
  }
}
