import 'package:hive/hive.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class Studentmodel {

  @HiveField(0)
   int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String mobile;

  @HiveField(5)
  final String image;

  Studentmodel(
      {required this.name,
      required this.age,
      required this.address,
      required this.mobile,
      required this.image,
      this.id
      }
    );
}