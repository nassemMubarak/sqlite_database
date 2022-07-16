class Contact{
  late int id;
  late String name;
  late String mobile;
  late int blocked;
  Contact();
  static const tableName = 'contacts';
  Contact.fromMap(Map<String,dynamic> rowMap){
    id = rowMap['id'];
    name = rowMap['name'];
    mobile = rowMap['mobile'];
    blocked = rowMap['blocked'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
    map['name'] = name;
    map['mobile'] = mobile;
    map['blocked'] = blocked;
    return map;
  }
}