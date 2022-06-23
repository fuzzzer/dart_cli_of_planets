import 'dart:async';
import 'dart:math';
import '../../models/classes.dart';

void moonsHavingParty(
    {required List<Moon> moons,
    required int lines,
    required int danceArea,
    int decorationLevel = 3}) async {
  print("starting party");

  int count = 0;
  Timer.periodic(Duration(seconds: 1), (timer) {
    print(++count);
    if (count == 3) timer.cancel();
  });

  Future.delayed(
    Duration(seconds: 3),
    () => Future.delayed(
      Duration(milliseconds: 500),
      () => dance(
        moons,
        lines,
        danceArea,
        decorationLevel,
      ),
    ),
  );

  Future.delayed(Duration(seconds: 3), () => print("music on"));
}

void dance(
  List<Moon> moons,
  int lines,
  int danceArea,
  int decorationLevel,
) async {
  for (int i = 0; i < lines; i++) {
    String randomDancer = moons[Random().nextInt(moons.length)].name;
    int randomDanceLocation = Random().nextInt(danceArea + 1);
    int freeSpace = danceArea - randomDancer.length;

    String decor1 = "*";
    String decor2 = "^";
    String danceArrangement = "";

    for (int i = 0; i < freeSpace; i++) {
      if (i == randomDanceLocation) {
        danceArrangement += randomDancer;
        continue;
      }

      if (randomBool(decorationLevel / danceArea)) {
        danceArrangement += decor1;
        continue;
      }

      if (randomBool(decorationLevel / danceArea)) {
        danceArrangement += decor2;
        continue;
      }

      danceArrangement += " ";
    }

    print(danceArrangement);
    await Future.delayed(Duration(milliseconds: 200));
  }
}

bool randomBool(double probability) {
  if (probability >= 0 && probability <= 1) {
    if (Random().nextDouble() <= probability) {
      return true;
    } else {
      return false;
    }
  } else {
    throw Exception("probability arguments is not in the range");
  }
}
