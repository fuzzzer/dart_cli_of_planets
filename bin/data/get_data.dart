import 'dart:convert';
import 'dart:io';

import '../models/classes.dart';

Future<List<Galaxy>> readAndInitializeGalaxy() async {
  final file = File(
      "C:/FUZZZER/programming/dart/Vs/projects/various problems/dart_classes/local_database/data.json");
  final String contents = await file.readAsString();
  final List jsonResponse = jsonDecode(contents);

  return jsonResponse.map((rawGalaxy) => Galaxy.fromJson(rawGalaxy)).toList();
}


// Future<List<Galaxy>> readAndInitializeGalaxy() async {
//   List<Galaxy> galaxies = [];

//   final moon = Moon(
//     radius: 5,
//     name: "Moon",
//     mass: 1,
//   );

//   final enceladus = Moon(
//     radius: 7,
//     name: "Enceladus",
//     mass: 1.5,
//   );

//   final solarSystemPlanets = [
//     Planet(
//       radius: 10,
//       isPopulated: true,
//       moons: [moon],
//       name: "Earth",
//       mass: 2,
//     ),
//     Planet(
//       radius: 40,
//       isPopulated: false,
//       moons: [enceladus],
//       name: "Saturn",
//       mass: 3,
//     ),
//   ];

//   final sun = Star(
//     radius: 10,
//     luminescence: 131.53,
//     name: "Sun",
//     mass: 4,
//   );

//   final solarSystem = StarSystem(
//     name: "Solar System",
//     star: sun,
//     planets: solarSystemPlanets,
//   );
//   final moon1 = Moon(mass: 112, radius: 5, name: "moonosavr");
//   final star1 =
//       Star(name: "ocean star", mass: 12, radius: 1123, luminescence: 231);
//   final massivePlanet1 = Planet(
//     name: "massive Planet",
//     mass: 1334,
//     radius: 987,
//     isPopulated: false,
//     moons: [moon1],
//   );

//   final starSystem1 =
//       StarSystem(name: "starSystem1", star: star1, planets: [massivePlanet1]);

//   galaxies.add(
//     Galaxy(
//       radius: 100000,
//       color: "Black",
//       starSystems: [solarSystem, starSystem1],
//       mass: 9.3,
//       name: "Milky Way",
//     ),
//   );

//   galaxies.add(
//     Galaxy(
//       radius: 200000,
//       color: "Black",
//       starSystems: [solarSystem],
//       mass: 9.3,
//       name: "Andromeda",
//     ),
//   );

//   return galaxies;
// }
