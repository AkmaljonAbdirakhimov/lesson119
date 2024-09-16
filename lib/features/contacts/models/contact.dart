import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String fullname;
  @HiveField(2)
  final String phone;

  Contact({
    required this.id,
    required this.fullname,
    required this.phone,
  });
}
