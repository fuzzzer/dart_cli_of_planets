import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import '../../models/classes.dart';
import '../../models/object_intervals.dart';

void meteorShowerSimulation(Galaxy galaxy, int meteorsQuantity) async {
  print("computation needs time: ");
  int timeOfComputation = 0;

  final ReceivePort receivePort = ReceivePort();
  final Isolate isolate = await Isolate.spawn(
    processMeteorSimulationInTheBackground,
    [receivePort.sendPort, galaxy, meteorsQuantity],
  );

  var timer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) => print(++timeOfComputation),
  );

  receivePort.listen((answer) {
    timer.cancel();
    if (answer is Exception) {
      print(answer);
    } else {
      print("time of computation was: $timeOfComputation");

      if (answer.isNotEmpty) {
        print("destroyed celestial objects are:");
        answer.forEach((celestialObject) {
          print(celestialObject.name);
        });
      } else {
        print("meteor shower has not destroyed anything");
      }
    }

    receivePort.close();
    isolate.kill();
  });
}

void processMeteorSimulationInTheBackground(List args) async {
  SendPort sendPort = args[0];
  Galaxy galaxy = args[1];
  int meteorsQuantity = args[2];

  try {
    List<CelestialObject> destoriedCelestialObjects =
        destroyedCelestialObjects(galaxy, meteorsQuantity);
    sendPort.send(destoriedCelestialObjects);
  } on Error {
    sendPort.send(Exception("some error"));
  }
}

List<CelestialObject> destroyedCelestialObjects(
  Galaxy galaxy,
  int meteorsQuantity,
) {
  final List<CelestialObject> destroidCelestialObjects = [];

  final double totalGalaxyArea = 3.14 * galaxy.radius * galaxy.radius;
  List<CelestialObject> maybeDestroied = whatCanBeDestroyed(galaxy);
  List<ObjectIntervals> intervals = mapIntervals(maybeDestroied);

  for (int i = 0; i < meteorsQuantity; i++) {
    double destroyedLocation = Random().nextDouble() * totalGalaxyArea;

    if (intervals.isNotEmpty) {
      CelestialObject? destoryed = whatWillMeteorDestroy(
        0,
        intervals.length - 1,
        intervals,
        destroyedLocation,
      ); // this might return null meaning that meteor has not destroyed anything

      if (destoryed != null) {
        destroidCelestialObjects.add(destoryed);
      }
    } else {
      break;
    }
  }

  return destroidCelestialObjects;
}

CelestialObject? whatWillMeteorDestroy(
  int start,
  int end,
  List<ObjectIntervals> intervals,
  double destroyedLocation,
) {
  int currentIndex = start + (end - start) ~/ 2;
  ObjectIntervals currentToCheck = intervals[currentIndex];

  if (currentToCheck.upperBound > destroyedLocation) {
    if (destroyedLocation >= currentToCheck.lowerBound) {
      intervals.remove(currentToCheck);
      return currentToCheck.celestialObject;
    }

    if ((end - start) == 0) return null;
    end = currentIndex;
  } else {
    if ((end - start) == 0) return null;
    start = currentIndex + 1;
  }

  return whatWillMeteorDestroy(start, end, intervals, destroyedLocation);
}

List<ObjectIntervals> mapIntervals(List<CelestialObject> maybeDestroied) {
  List<ObjectIntervals> result = [];
  double lastbound = 0;

  for (int i = 0; i < maybeDestroied.length; i++) {
    double currentBound = lastbound + 3.14 * pow(maybeDestroied[i].radius, 2);

    result.add(ObjectIntervals(
        celestialObject: maybeDestroied[i],
        lowerBound: lastbound,
        upperBound: currentBound));

    lastbound = currentBound;
  }

  return result;
}

List<CelestialObject> whatCanBeDestroyed(Galaxy galaxy) {
  // I m not using celestial_object_initialization_logic to find all destroyable objects to save time
  List<CelestialObject> result = [];

  List<Planet> planets = [];

  for (StarSystem starSystem in galaxy.starSystems) {
    result.add(starSystem.star);
  }

  for (StarSystem starSystem in galaxy.starSystems) {
    planets.addAll(starSystem.planets);
  }

  for (Planet planet in planets) {
    result.addAll(planet.moons);
  }

  result = [...result, ...planets];

  return result;
}







// this method was slower because it needed to copy intervals

// CelestialObject? whatWillMeteorDestroy(List<ObjectIntervals> realIntervals,
//     List<ObjectIntervals> intervals, double destroyedLocation) {
//   int currentIndex = intervals.length ~/ 2;
//   ObjectIntervals currentToCheck = intervals[currentIndex];

//   if (currentToCheck.upperBound > destroyedLocation) {
//     if (destroyedLocation >= currentToCheck.lowerBound) {
//       realIntervals.remove(currentToCheck);
//       return currentToCheck.celestialObject;
//     }
//     intervals.removeRange(currentIndex, intervals.length);
//   } else {
//     intervals.removeRange(0, currentIndex);
//   }

//   if (currentIndex == 0) return null;

//   return whatWillMeteorDestroy(realIntervals, intervals, destroyedLocation);
// }
