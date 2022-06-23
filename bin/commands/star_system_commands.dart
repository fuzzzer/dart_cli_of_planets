import 'package:args/command_runner.dart';
import '../models/classes.dart';
import 'common_subcommands_for_all_main_command.dart';

class StarSystemCommand extends Command {
  @override
  final name = "star-system";
  @override
  final description = "operations on star systems";

  List<StarSystem> starSystems;

  StarSystemCommand({required this.starSystems}) {
    addSubcommand(ListCommand(toShow: starSystems));
    addSubcommand(ExportCommand(toSave: starSystems));
  }
}
