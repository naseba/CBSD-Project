class Medicine{
  
  int id;
  int userid;
  String name;
  int dosage;
  String units;
  int numOfTimes;//How many times a day
  String time;//when to alart
  String setAlarm;//0 = no // 1= yes
  String startDate;
  String endDate;
  int numOfPills;
  int pillsLeft;
  int refill;//0 = no // 1= yes
  int state;//1=Missed //2=not Yet //3=Taken

  //Medicine(this.userid,this.name,this.dosage,this.units,this.state,[this.numOfTimes],
    //      [this.time],[this.setAlarm],[this.startDate],[this.endDate],[this.numOfPills],
    //      [this.pillsLeft],[this.refill]);

  Medicine(this.userid,this.name,this.dosage,this.units,this.numOfTimes,
          this.time,this.setAlarm,this.startDate,this.endDate,this.numOfPills,
          this.pillsLeft,this.refill,this.state);

  Medicine.withID(this.id,this.userid,this.name,this.dosage,this.units,this.numOfTimes,
          this.time,this.setAlarm,this.startDate,this.endDate,this.numOfPills,
          this.pillsLeft,this.refill,this.state);


  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    if(id!=null)
    map['ID']=id;
    map['userid']=userid;
    map['name']=name;
    map['dosage']=dosage;
    map['units']=units;
    map['numOfTimes']=numOfTimes;
    map['time']=time;
    map['startDate']=startDate;
    map['endDate']=endDate;
    map['NumOfPills']=numOfPills;
    map['pillsLeft']=pillsLeft;
    map['refill']=refill;
    map['state']=state; 
     return map;
  }

  Medicine.fromMApToObject(Map<String,dynamic> map){
    id=map['ID'];
    userid=map['userid'];
    name=map['name'];
    dosage=map['dosage'];
    units=map['units'];
    numOfTimes=map['numOfTimes'];
    time=map['time'];
    startDate=map['startDate'];
    endDate=map['endDate'];
    numOfPills=map['NumOfPills']; 
    pillsLeft=map['pillsLeft'];
    refill=map['refill'];
    state=map['state']; 

  }
  }