class User{

  int id;
  String firstName;
  String lastName;
  String gender;
  String birthDate;

  User(this.firstName,this.lastName,this.gender,this.birthDate);
  User.withID(this.id,this.firstName,this.lastName,this.gender,this.birthDate);

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    if(id!=null)
    map['ID']=id;
    map['firstName']=firstName;
    map['lastName']=lastName;
    map['gender']=gender;
    map['birthDate']=birthDate;

    return map;
  }

  User.fromMApToObject(Map<String,dynamic> map){
    id=map['ID'];
    firstName=map['firstName'];
    lastName=map['lastName'];
    gender=map['gender'];
    birthDate=map['birthDate'];
  }
}