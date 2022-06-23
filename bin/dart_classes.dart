import 'package:args/command_runner.dart';
import 'commands/galaxy_commands.dart';
import 'commands/moon_commands.dart';
import 'commands/planet_commands.dart';
import 'commands/star_commands.dart';
import 'commands/star_system_commands.dart';
import 'data/get_data.dart';
import 'logic/initialization_of_named_logic.dart';

void main(List<String> args) async {
  final galaxies = await readAndInitializeGalaxy();

  CommandRunner("stellarium", "Celestial object relations")
    ..addCommand(GalaxyCommand(galaxies: galaxies))
    ..addCommand(StarSystemCommand(
        starSystems: initializeStarSystems(galaxies: galaxies)))
    ..addCommand(StarCommand(stars: initializeStars(galaxies: galaxies)))
    ..addCommand(PlanetCommand(planets: initializePlanets(galaxies: galaxies)))
    ..addCommand(MoonCommand(moons: initializeMoons(galaxies: galaxies)))
    ..run(args);
}
