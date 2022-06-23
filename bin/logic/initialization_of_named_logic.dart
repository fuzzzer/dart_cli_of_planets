import '../models/classes.dart';

List<StarSystem> initializeStarSystems({
  required List<Galaxy> galaxies,
  List<String>? filters,
}) {
  List<StarSystem> result = [];

  if (filters != null && filters.isNotEmpty) {
    for (var galaxy in galaxies) {
      if (filters.any((filter) => galaxy.name.contains(filter))) {
        result.addAll(galaxy.starSystems);
      }
    }
  } else {
    for (Galaxy galaxy in galaxies) {
      result.addAll(galaxy.starSystems);
    }
  }

  return result;
}

List<Star> initializeStars({
  required List<Galaxy> galaxies,
  List<String>? filter,
}) {
  List<StarSystem> starSystems = initializeStarSystems(galaxies: galaxies);
  List<Star> result = [];

  for (StarSystem starSystem in starSystems) {
    result.add(starSystem.star);
  }

  return result;
}

List<Planet> initializePlanets({required List<Galaxy> galaxies}) {
  List<StarSystem> starSystems = initializeStarSystems(galaxies: galaxies);
  List<Planet> result = [];

  for (StarSystem starSystem in starSystems) {
    result.addAll(starSystem.planets);
  }
  return result;
}

List<Moon> initializeMoons({required List<Galaxy> galaxies}) {
  List<Planet> planets = initializePlanets(galaxies: galaxies);
  List<Moon> result = [];

  for (Planet planet in planets) {
    result.addAll(planet.moons);
  }

  return result;
}












// I couldnot make it work, 

// initialization in main:
//   List<StarSystem> starSystems = initializeChildsList(parents: galaxies) as List<StarSystem>;
//   List<Star> stars = initilizeStarsFromGalaxies(galaxies: galaxies);
//   List<Planet> planets = initializeChildsList(parents: starSystems) as List<Planet>;
//   List<Moon> moons = initializeChildsList(parents: planets) as List<Moon>;


// //Unhandled exception:
// type '_CompactLinkedHashList<Named>' is not a subtype of type 'List<StarSystem>' in type cast
// #0      main (file:///C:/FUZZZER/programming/dart/Vs/projects/various%20problems/dart_classes/bin/dart_classes.dart:14:46)
// #1      _delayEntrypointInvocation.<anonymous closure> (dart:isolate-patch/isolate_patch.dart:295:32)
// #2      _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:192:12)

// List<Named> initializeChildsList({
//   required List<Named> parents,
// }) {
//   List<Named> result = {};
//   for (Named parent in parents) {
//     result.addAll(parent.getChildsList());
//   }

//   return result;
// }

// List<Star> initilizeStarsFromGalaxies({required List<Galaxy> galaxies}) {
//   List<StarSystem> starSystems =
//       initializeChildsList(parents: galaxies) as List<StarSystem>;
//   List<Star> result = {};

//   for (StarSystem starSystem in starSystems) {
//     result.add(starSystem.star);
//   }

//   return result;
// }















// initialize all together and save time

// void initializeCelestialObjectsList({
//   required List<Galaxy> galaxies,
//   required List<StarSystem> starSystems,
//   required List<Star> stars,
//   required List<Planet> planets,
//   required List<Moon> moons,
// }) {
//   for (Galaxy galaxy in galaxies) {
//     starSystems.addAll(galaxy.starSystems);
//   }

//   for (StarSystem starSystem in starSystems) {
//     stars.add(starSystem.star);
//     planets.addAll(starSystem.planets);
//   }

//   for (Planet planet in planets) {
//     moons.addAll(planet.moons);
//   }
// }