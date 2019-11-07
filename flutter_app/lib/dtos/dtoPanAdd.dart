class PanDto {
  final int QtCmd;
  final int IdProd;
  final double totale;

  PanDto({this.QtCmd, this.IdProd, this.totale});

  factory PanDto.fromJson(Map<String, dynamic> json) {
    return PanDto(
      QtCmd: json['QtCmd'],
      IdProd: json['IdProd'],
      totale: json['totale']
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["QtCmd"] = QtCmd.toString();
    map["IdProd"] = IdProd.toString();
    map["totale"] = totale.toString();

    return map;
  }
}