import 'package:isar/isar.dart';

part 'currency.g.dart';

@Collection()
class Currency {
  Id? id;
  late String currency;
  late double rate;
}
