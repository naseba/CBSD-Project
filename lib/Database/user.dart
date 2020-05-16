class User{

  int id;
  String firstName;
  String lastName;
  String gender;
  String palce;
  int active;

  User(this.firstName,this.lastName,this.gender,this.palce,this.active);
  User.withID(this.id,this.firstName,this.lastName,this.gender,this.palce,this.active);

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    if(id!=null)
    map['ID']=id;
    map['FirstName']=firstName;
    map['LastName']=lastName;
    map['Gender']=gender;
    map['Place']=palce;
    map['Active']=active;

    return map;
  }

  User.fromMApToObject(Map<String,dynamic> map){
    id=map['ID'];
    firstName=map['FirstName'];
    lastName=map['LastName'];
    gender=map['Gender'];
    palce=map['Place'];
    active=map['Active'];
  }
}