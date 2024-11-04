import 'package:isar/isar.dart';

part 'currency.g.dart';

@Collection()
class Currency {
  Id? id;
  @Index(unique: true)
  late String currency;
  late double rate;
}
