import '../models/classes.dart';

List<Named> filterNamed(List<Named> listOfNamed, List<String> filters) {
  List<Named> result = [];

  if (filters.isNotEmpty) {
    result.addAll(listOfNamed.where(
      (named) {
        return filters.any(
          (filter) => named.name.contains(filter),
        );
      },
    ).toList());
  } else {
    result = listOfNamed;
  }

  return result;
}
