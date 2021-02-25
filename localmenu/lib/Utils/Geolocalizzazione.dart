import 'package:geolocator/geolocator.dart';
import 'package:localmenu/Utils/exceptions.dart';

class Geolocalizzazione{
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw new GeoException("Attiva il GPS per visualizzare i locali vicini");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw new GeoException("Non è possibile visualizzare i locali vicini siccome è stato negato l'accesso al GPS");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw new GeoException("Non è possibile visualizzare i locali vicini siccome è stato negato l'accesso al GPS");
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}