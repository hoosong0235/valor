import 'dart:io';

String processQuotation(String string) {
  if (string.contains('\'')) {
    return '${string.substring(0, string.indexOf('\''))}\\${string.substring(string.indexOf('\''))}';
  } else {
    return string;
  }
}

main() async {
  List<String> symbList = [];
  List<String> nameList = [];

  File file = File('nasdaq_screener.csv');
  List<String> lines = await file.readAsLines();

  for (String line in lines) {
    List<String> list = line.split(',');
    String symb = '\'${list[0]}\'';
    String name = '\'${processQuotation(list[1])}\'';

    symbList.add(symb);
    nameList.add(name);
  }

  // print(symbList);
  // print(nameList);
}
