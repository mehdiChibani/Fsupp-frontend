class DtoCmd {
  final DateTime  date;
  final String etat;
  final double totale;

  DtoCmd({this.date, this.etat, this.totale});

  factory DtoCmd.fromJson(Map<String, dynamic> json) {
    return DtoCmd(
        date: json['date'],
        etat: json['etat'],
        totale: json['totale']
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = date.toString();
    map["etat"] = etat.toString();
    map["totale"] = totale.toString();

    return map;
  }
}