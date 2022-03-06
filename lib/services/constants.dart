class Constants {

  static String loginUrl = 'https://studium.uni-muenster.de/qisserver/rds?state=user&type=1&category=auth.login&startpage=portal.vm&breadCrumbSource=portal';
  static String homeUrl = 'https://studium.uni-muenster.de/qisserver/rds?state=user&type=0';
  static String performanceOverviewUrl(String asi){
    return 'https://studium.uni-muenster.de/qisserver/rds?state=notenspiegelStudent&next=list.vm&createInfos=Y&nodeID=auswahlBaum%7Cabschluss%3Aabschl%3D82%2Cstgnr%3D1&asi=$asi';
  }

}