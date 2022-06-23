import 'package:args/command_runner.dart';
import '../models/classes.dart';
import 'common_subcommands_for_all_main_command.dart';

class PlanetCommand extends Command {
  @override
  final name = "planet";
  @override
  final description = "operations on planets";

  List<Planet> planets;

  PlanetCommand({required this.planets}) {
    addSubcommand(ListCommand(toShow: planets));
    addSubcommand(ExportCommand(toSave: planets));
  }
}
