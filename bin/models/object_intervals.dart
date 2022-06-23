import 'classes.dart';

class ObjectIntervals {
  final CelestialObject celestialObject;
  final double lowerBound;
  final double upperBound;
  const ObjectIntervals(
      {required final this.celestialObject,
      required final this.lowerBound,
      required final this.upperBound});

  ObjectIntervals copy() {
    return ObjectIntervals(
      celestialObject: celestialObject,
      lowerBound: lowerBound,
      upperBound: upperBound,
    );
  }
}
