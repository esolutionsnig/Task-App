
import 'dart:convert';

import 'package:http/http.dart';

class WorldTime {

  String location;
  String seconds;
  String time;
  String date;
  String flag;
  String url;

  WorldTime({ this.location, this.seconds, this.time, this.flag, this.url });

  Future<void> getTime() async {
    // make the request
    Response response =
        await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    // Get properties from data
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    // Create a DateTime object
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));

    // Set time property
    // seconds = now.toString().substring(17, 19);
    time = now.toString().substring(11, 16);
    // Set date property
    date = now.toString().substring(0, 10);
  }
  
}
