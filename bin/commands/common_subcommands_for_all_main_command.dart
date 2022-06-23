import 'package:args/command_runner.dart';
import '../logic/actions/showing_celestial_objects_logic.dart';
import '../logic/actions/storing_logic.dart';
import '../logic/filter_named_logic.dart';
import '../models/classes.dart';

class ListCommand extends Command {
  @override
  final name = "list";
  @override
  final description = "shows you Celestial objects";

  List<Named> toShow;

  ListCommand({required this.toShow}) {
    argParser.addFlag("dry", abbr: "d", defaultsTo: false);
    argParser.addMultiOption("filter", abbr: "f");
  }

  @override
  void run() {
    if (argResults?["dry"]) {
      showNamedDry(toShow, filters: argResults?["filter"]);
    } else {
      showNamed(toShow, filters: argResults?["filter"]);
    }
  }
}

class ExportCommand extends Command {
  @override
  final name = "export";
  @override
  final description = "saves and exports Celestial objects on location ";

  List<Named> toSave;

  ExportCommand({required this.toSave}) {
    argParser.addOption("as");
    argParser.addOption("path", abbr: "p");
    argParser.addMultiOption("filter", abbr: "f");
  }

  @override
  void run() {
    toSave = filterNamed(
        toSave,
        argResults?[
            "filter"]); // if filter is not used argResults?["filter"] return empty list

    if (toSave.isEmpty) {
      print("no object found with filters you entered");
    } else {
      if (argResults?["as"] == null) {
        print("enter name as \"<List to export> export --as <name>\" ");
      } else {
        createFile(argResults?["as"], toSave.toList(),
            path: argResults?["path"] ?? "");
      }
    }
  }
}
