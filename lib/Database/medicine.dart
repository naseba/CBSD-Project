class Medicine{
  
  int id;
  int userid;
  String name;
  int dosage;
  String units;
  int numOfTimes;//How many times a day
  String time;//when to alart
  String startDate;
  String endDate;
  int numOfPills;
  int pillsLeft;
  int refill;//0 = no // 1= yes
  int state;//1=Missed //2=not Yet //3=Taken

  

  Medicine(this.userid,this.name,this.dosage,this.units,this.numOfTimes,
          this.time,/*this.setAlarm,*/this.startDate,this.endDate,this.numOfPills,
          this.pillsLeft,this.refill,this.state);

  Medicine.withID(this.id,this.userid,this.name,this.dosage,this.units,this.numOfTimes,
          this.time,/*this.setAlarm,*/this.startDate,this.endDate,this.numOfPills,
          this.pillsLeft,this.refill,this.state);

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    if(id!=null)
    map['ID']=id;
    map['Userid']=userid;
    map['Name']=name;
    map['Dosage']=dosage;
    map['Units']=units;
    map['NumOfTimes']=numOfTimes;
    map['Time']=time;
    map['StartDate']=startDate;
    map['EndDate']=endDate;
    map['NumOfPills']=numOfPills;
    map['PillsLeft']=pillsLeft;
    map['Refill']=refill;
    map['state']=state; 
     return map;
  }

  Medicine.fromMApToObject(Map<String,dynamic> map){
    id=map['ID'];
    userid=map['Userid'];
    name=map['Name'];
    dosage=map['Dosage'];
    units=map['Units'];
    numOfTimes=map['NumOfTimes'];
    time=map['Time'];
    startDate=map['StartDate'];
    endDate=map['EndDate'];
    numOfPills=map['NumOfPills']; 
    pillsLeft=map['PillsLeft'];
    refill=map['Refill'];
    state=map['State']; 

  }
  }