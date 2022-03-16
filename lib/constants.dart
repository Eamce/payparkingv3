class Constants{

  static const String dlReport = 'Daily Report';
  static const String rgReport = 'Range Report';
  static const String dbSync = 'Database Sync';
  static const String blkList = 'Block Lists';
  static const String about ='About';

  // //LIVE DATABASE(ALTA CITTA)...
  // static String dbSource = "http://172.16.174.201:81";

  //LOCAL DATABASE(MARCELA)...
  // static String dbSource = "http://172.16.43.7:8080";
  //localhosts
 //  static String dbSource = "http://172.16.43.168";
  //Live DATABASE MARCELA
  static String dbSource = "http://172.16.176.20";
  //my local
  //static String dbSource = "http://172.16.46.130";
  static const List<String> choices = <String>[
//    dlReport,'
//    rgReport,
    dbSync,
    about
  ];
}