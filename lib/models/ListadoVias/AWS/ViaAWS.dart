import 'dart:convert';

ViaAWS ViasMainFromJson(String str) => ViaAWS.fromJson(json.decode(str));
String ViasMainToJson(ViaAWS data) => json.encode(data.toJson());

class ViaAWS {
  String? status;
  List<Vias>? vias;

  ViaAWS({this.status, this.vias});

  ViaAWS.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['vias'] != null) {
      vias = <Vias>[];
      json['vias'].forEach((v) {
        vias!.add(new Vias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.vias != null) {
      data['vias'] = this.vias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vias {
  String? sId;
  String? name;
  String? autor;
  dynamic dificultad;
  late String comentario;
  late List<String> presas;
  int? quepared;
  String? isbloque;
  int? iV;

  Vias(
      {this.sId,
      this.name,
      this.autor,
      this.dificultad,
      required this.comentario,
      required this.presas,
      this.quepared,
      this.isbloque,
      this.iV});

  Vias.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    autor = json['autor'];
    dificultad = json['dificultad'];
    comentario = json['comentario'];
    presas = json['presas'].cast<String>();
    quepared = json['quepared'];
    isbloque = json['isbloque'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['autor'] = this.autor;
    data['dificultad'] = this.dificultad;
    data['comentario'] = this.comentario;
    data['presas'] = this.presas;
    data['quepared'] = this.quepared;
    data['isbloque'] = this.isbloque;
    data['__v'] = this.iV;
    return data;
  }
}
