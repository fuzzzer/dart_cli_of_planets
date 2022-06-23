import 'package:args/command_runner.dart';
import '../logic/actions/moon_party_logic.dart';
import '../logic/filter_named_logic.dart';
import '../models/classes.dart';
import 'common_subcommands_for_all_main_command.dart';

class MoonCommand extends Command {
  @override
  final name = "moon";
  @override
  final description = "operations on moons";

  List<Moon> moons;

  MoonCommand({required this.moons}) {
    addSubcommand(ListCommand(toShow: moons));
    addSubcommand(ExportCommand(toSave: moons));
    addSubcommand(MoonPartyCommand(moons: moons));
  }
}

class MoonPartyCommand extends Command {
  @override
  final name = "party";
  @override
  final description = "dancing moons";

  List<Moon> moons;

  MoonPartyCommand({required this.moons}) {
    argParser.addMultiOption(
      "filter",
      abbr: "f",
      help: "add moon names",
    );

    argParser.addOption(
      "lines",
      abbr: "l",
      help: "enter lines as an area of dancing (integer value)",
    );

    argParser.addOption(
      "density",
      abbr: "d",
      help: "enter density of packed dancers (integer value)",
    );
  }

  @override
  void run() {
    moons = filterNamed(moons, argResults?["filter"]).cast<Moon>();

    moonsHavingParty(
      moons: moons,
      lines: int.parse(argResults?["lines"]),
      danceArea: int.parse(
        argResults?["density"],
      ),
    );
  }
}
