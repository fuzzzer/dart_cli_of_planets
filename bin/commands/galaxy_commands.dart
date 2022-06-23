import 'package:args/command_runner.dart';
import '../logic/actions/meteor_shower_simulation.dart';
import '../models/classes.dart';
import 'common_subcommands_for_all_main_command.dart';

class GalaxyCommand extends Command {
  @override
  final name = "galaxy";
  @override
  final description = "operations on galaxies";

  final List<Galaxy> galaxies;

  GalaxyCommand({required final this.galaxies}) {
    addSubcommand(ListCommand(toShow: galaxies));
    addSubcommand(MeteorShowersCommand(galaxies: galaxies));
    addSubcommand(ExportCommand(toSave: galaxies));
  }
}

class MeteorShowersCommand extends Command {
  @override
  final name = "meteor-shower";
  @override
  final description =
      "creates 100M meteor showers in a galaxy that will destroy stars, planet and moons based on a probability realative to whole galaxy size";

  List<Galaxy> galaxies;
  int meteorsQuantity = 100000000;

  MeteorShowersCommand({required this.galaxies}) {
    argParser.addOption("in");
  }

  @override
  void run() {
    bool galaxyFound = false;

    for (Galaxy galaxy in galaxies) {
      if (galaxy.name == argResults?["in"]) {
        print("destroing ${argResults?["in"]} ");
        meteorShowerSimulation(
          galaxy,
          meteorsQuantity,
        );
        galaxyFound = true;
        break;
      }
    }

    if (!galaxyFound) {
      print(
          "Galaxy with the name you entered doesn't exist  \n please enter \"meteor-shower --in <galaxy name> \" \n to obtain names of existent galaxies please enter \"galaxy list --dry\"");
    }
  }
}
