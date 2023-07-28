import 'appointmentdata.dart';

class Data
{

  static List<AppointmentData> allData = [];
  static List<AppointmentData> hrdData = [];
  static List<AppointmentData> techData = [];
  static List<AppointmentData> followupData = [];



  static createData(){
    print("createData");

    AppointmentData appointmentData1 = new AppointmentData(
      "1","Balram Naidu","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData2 = new AppointmentData(
        "1","Rakesh Nair","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData3 = new AppointmentData(
        "1","Venkat Sing","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData4 = new AppointmentData(
        "1","Aastha Luthra","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData5 = new AppointmentData(
        "1","Baldev Mishra","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData6 = new AppointmentData(
        "2","Alka Krishna","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData7 = new AppointmentData(
        "2","Anjana Gala","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData8 = new AppointmentData(
        "2","Samir Kaur","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData9 = new AppointmentData(
        "2","Ananya Jawahar","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData10 = new AppointmentData(
        "2","Nupur Chada","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData11 = new AppointmentData(
        "2","Chinmay Prasad","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData12 = new AppointmentData(
        "3","Afreen Persaud","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData13 = new AppointmentData(
        "3","Omar Bhandari","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","High Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData14 = new AppointmentData(
        "3","Mona Aarif","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );
    AppointmentData appointmentData15 = new AppointmentData(
        "3","Pranab Minhas","LOREM123456354","\u20B9X,XX,XXX"
        ,"\u20B9X,XX,XXX","Medium Priority","05 Jun 23","10","23"
        ,"8879865565"
    );


      allData.clear();

      allData.add(appointmentData1);
      allData.add(appointmentData2);
      allData.add(appointmentData3);
      allData.add(appointmentData4);
      allData.add(appointmentData5);
      allData.add(appointmentData6);
      allData.add(appointmentData7);
      allData.add(appointmentData8);
      allData.add(appointmentData9);
      allData.add(appointmentData10);
      allData.add(appointmentData11);
      allData.add(appointmentData12);
      allData.add(appointmentData13);
      allData.add(appointmentData14);
      allData.add(appointmentData15);
      dataByType();


  }
  static dataByType(){
    print("dataByType");
    print("allData.length ${allData.length}");

    for( var i = 0 ; i < allData.length; i++ ) {
      print("inforloop");
      print("$i and type = ${allData[i].type}");
      if(allData[i].type == "1"){
        hrdData.add(allData[i]);
      }else if(allData[i].type == "2"){
        techData.add(allData[i]);
      }else{
        followupData.add(allData[i]);
      }
    }
  }
}