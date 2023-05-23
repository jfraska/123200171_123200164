import 'package:hive/hive.dart';
part 'pengguna.g.dart';

@HiveType(typeId: 0)
class Pengguna extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;

  Pengguna({
    this.username,
    this.password,
  });
}
