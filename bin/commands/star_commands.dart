import 'package:args/command_runner.dart';
import '../models/classes.dart';
import 'common_subcommands_for_all_main_command.dart';

class StarCommand extends Command {
  @override
  final name = "star";
  @override
  final description = "operations on stars";

  List<Star> stars;

  StarCommand({required this.stars}) {
    addSubcommand(ListCommand(toShow: stars));
    addSubcommand(ExportCommand(toSave: stars));
  }
}
