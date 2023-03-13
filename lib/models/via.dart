import 'package:hive/hive.dart';

part 'via.g.dart';

@HiveType(typeId: 1)
class Via {
  @HiveField(0)
  late final String name;

  @HiveField(1)
  late final String autor;

  @HiveField(2)
  late final int dificultad;

  @HiveField(3)
  late final String comentario;

  @HiveField(4)
  late final List<String> presas;

  @HiveField(5)
  late final String isbloque;

  @HiveField(6)
  late final int quepared;

  Via(
      {required this.name,
      required this.autor,
      required this.dificultad,
      required this.comentario,
      required this.presas,
      required this.isbloque,
      required this.quepared});

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'autor': this.autor,
        'dificultad': this.dificultad,
        'comentario': this.comentario,
        'presas': this.presas,
        'isbloque': this.isbloque,
        'quepared': this.quepared,
      };

  fromJson(String key, Map<String, dynamic> json) {
    name = json['name'];
    autor = json['autor'];
    dificultad = json['dificultad'];
    comentario = json['comentario'];
    presas = json['presas'].cast<String>();
    isbloque = json['isbloque'];
  }
}
