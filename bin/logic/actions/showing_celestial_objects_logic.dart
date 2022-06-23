import '../../models/classes.dart';

void showNamed(List<Named> listOfNamed, {List<String>? filters}) {
  if (filters != null && filters.isNotEmpty) {
    print(
      listOfNamed
          .where(
            (named) {
              return filters.any(
                (filter) => named.name.contains(filter),
              );
            },
          )
          .map((named) => named.toJson())
          .toList(),
    );
  } else {
    print(
      listOfNamed.map((celestial) => celestial.toJson()).toList(),
    );
  }
}

void showNamedDry(List<Named> listOfCeletials, {List<String>? filters}) {
  if (filters != null && filters.isNotEmpty) {
    for (var celestial in listOfCeletials) {
      if (filters.any((filter) => celestial.name.contains(filter))) {
        print(celestial.name);
      }
    }
  } else {
    for (var celestial in listOfCeletials) {
      print(celestial.name);
    }
  }
}
