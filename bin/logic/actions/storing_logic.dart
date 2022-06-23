import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import '../../models/classes.dart';

void createFile(String name, List<JsonConvertable> toSave,
    {String path = ""}) async {
  final fileName = '/$name.json';

  path == ""
      ? path =
          "C:/FUZZZER/programming/dart/Vs/projects/various problems/dart_classes/exported"
      : null; // this is default location

  if (await Directory(path).exists()) {
    bool check = await createFileOnLocation("$path$fileName", toSave);
    check ? print("file is saved at location \"$path$fileName\"") : null;
  } else {
    print("the path doesnot exist");
  }
}

Future<bool> createFileOnLocation(
    String locationAndName, List<JsonConvertable> toSave) async {
  // createFileOnLocation returns true or false based on the result of writing
  bool fileExists = await File(locationAndName).exists();
  if (!fileExists) {
    print('saving...');

    var timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => print("..."),
    );

    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(
      writeOnIsolate,
      [receivePort.sendPort, locationAndName, toSave],
    );

    Future<bool> result = Future<bool>(() async {
      late bool portSentResult;
      await for (bool answer in receivePort) {
        if (answer) {
          timer.cancel();
          receivePort.close();
          isolate.kill();
          portSentResult = answer; //isolate sends true when its done
        }
      }
      return portSentResult;
    });

    return result;
  } else {
    print("file with that name already exists");
    return false;
  }
}

void writeOnIsolate(List args) async {
  SendPort sendPort = args[0];
  String locationAndName = args[1];
  List<JsonConvertable> toSave = args[2];

  await Future.delayed(Duration(seconds: 5), () {
    File(locationAndName).writeAsString(jsonEncode(toSave));
  });

  sendPort.send(true);
}

void updateDataBase(List<JsonConvertable> toSave) async {
  await File(
          "C:/FUZZZER/programming/dart/Vs/projects/various problems/dart_classes/local_database/data.json")
      .writeAsString(jsonEncode(toSave));
}
















// this is same method without spawining isolate

// void createFile(String name, List<JsonConvertable> toSave,
//     {String path = ""}) async {
//   final fileName = '$name.json';

//   if (path != "") {
//     if (await Directory(path).exists()) {
      
//       bool check = await createFileOnLocation("$path/$fileName", toSave);
//       check ? print("file is saved at location /"$path/$fileName/"") : null;
//     } else {
//       print("path you entered doesnot exist");
//     }
//   } else {
//     bool check = await createFileOnLocation(
//         "C:/FUZZZER/programming/dart/Vs/projects/various problems/dart_classes/exported/$fileName",
//         toSave);
//     check
//         ? print(
//             "file is saved at location /"C:/FUZZZER/programming/dart/Vs/projects/various problems/dart_classes/exported/$fileName/" ")
//         : null;
//   }
// }

// Future<bool> createFileOnLocation(
//     String locationAndName, List<JsonConvertable> toSave) async {
//   // createFileOnLocation returns true or false based on the result of writing
//   bool fileExists = await File(locationAndName).exists();
//   if (!fileExists) {
//     await File(locationAndName).writeAsString(jsonEncode(toSave));
//     return true;
//   } else {
//     print("file with that name already exists");
//     return false;
//   }
// }

