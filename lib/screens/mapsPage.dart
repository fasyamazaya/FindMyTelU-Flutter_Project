import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

void main() {
  runApp(const Maps());
}

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      home: MapsView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapsView extends StatelessWidget {
  MapsView({Key? key}) : super(key: key);
  // This widget is the root of your application.

  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-6.9729839088327115, 107.63053861975284),
          zoom: 16.5,
          interactiveFlags: InteractiveFlag.all,
          onTap: (_, __) => _popupLayerController.hideAllPopups(),
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              markers: <Marker>[
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Bangkit',
                    imagePath:
                    'https://tse3.mm.bing.net/th/id/OIP.S1DLKAVn2ZdRl0q_2wVJGgHaEK?pid=ImgDet&rs=1',
                    lat: -6.973854280244929,
                    long: 107.63037803944003,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Graha Wiyata Cacuk Sudarijanto-A',
                    imagePath:
                    'https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/04/gedung-graha-cacuk-telkom-university-1-scaled.jpeg',
                    lat: -6.974389181980906,
                    long: 107.63109027251603,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Green Lounge Telkom University',
                    imagePath:
                    'https://telkomuniversity.ac.id/wp-content/uploads/2021/01/green-lounge.jpg',
                    lat: -6.974086667840784,
                    long: 107.63021043653322,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Language Center Telkom University',
                    imagePath:
                    'https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/13382750-A333-484C-866D-6587605F7428-225x300.jpeg',
                    lat: -6.974310909896639,
                    long: 107.63144853455097,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Telkom University Landmark Tower',
                    imagePath:
                    'https://www.balebandung.com/wp-content/uploads/2021/09/tel-u.jpg',
                    lat: -6.968943038201687,
                    long: 107.62807218976796,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Masjid Syamsul Ulum Telkom University',
                    imagePath:
                    'https://fastly.4sqi.net/img/general/600x600/1637912_QQG2m0GgZEJbPypTIRy28SVEr-pJaajA_t8yiHw5diI.jpg',
                    lat: -6.975528853281067,
                    long: 107.63228715063087,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Tokong Nanas',
                    imagePath:
                    'https://baa.telkomuniversity.ac.id/tofocep/2021/01/edit-5-scaled-1-1-1.jpg',
                    lat: -6.972787023447546,
                    long: 107.62969663051702,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Karang',
                    imagePath:
                    'https://sie.telkomuniversity.ac.id/batemaq/2021/08/Halaman-Depan-FRI.jpg',
                    lat: -6.975540383746578,
                    long: 107.63130129500276,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Grha Wiyata Cacuk Sudarijanto-B',
                    imagePath:
                    'https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg',
                    lat: -6.974864926229921,
                    long: 107.63107943520143,
                  ),
                ),MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Panambulai',
                    imagePath:
                    'https://fra1.digitaloceanspaces.com/places/uploads/place/image/file/11624769/2018-08-10.jpg',
                    lat: -6.975824640374241,
                    long: 107.63055996000993,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'TelU Coffee',
                    imagePath:
                    'https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/04/cafe-dalam-kampus-ini-dia-tel-u-coffe-1.jpeg',
                    lat: -6.973085817939898,
                    long: 107.62939001899099,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Open Library Telkom University',
                    imagePath:
                    'https://kanalbekasi.com/wp-content/uploads/2022/06/IMG-20220621-WA0032.jpg',
                    lat: -6.971726718740034,
                    long: 107.63241714587393,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Fakultas Ilmu Terapan',
                    imagePath:
                    'https://fit.labs.telkomuniversity.ac.id/wp-content/uploads/sites/37/2016/06/DSC_0021.jpg',
                    lat: -6.9732223143354055,
                    long: 107.63253973988182,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'ATM Center Gate 2',
                    imagePath:
                    'https://www.cakaplah.com/assets/news/29082017/cakaplah_pezmu_10024.jpg',
                    lat: -6.972845739262763,
                    long: 107.63324427089648,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Danau Galau',
                    imagePath:
                    'https://awsimages.detik.net.id/community/media/visual/2022/08/15/danau-galau_169.jpeg?w=650&q=80',
                    lat: -6.973039495053113,
                    long: 107.63151275392327,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Klinik Telkomedika',
                    imagePath:
                    'https://lh5.googleusercontent.com/p/AF1QipO-hOnNmMo4tNJFmgq5drdeRX8r60bBhT9YUcFB=w408-h257-k-no',
                    lat: -6.977317504288408,
                    long: 107.63039363313504,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Gedung Serba Guna',
                    imagePath:
                    'https://kbi2015.idbigdata.com/wp-content/uploads/2015/11/GSG.jpg',
                    lat: -6.976616376576964,
                    long: 107.63039894557332,
                  ),
                ),
                MonumentMarker(
                  monument: Monument(
                    name: 'Area Parkir FIT & FEB',
                    imagePath:
                    'https://bemfkbtelu.files.wordpress.com/2017/10/1507031332338.jpg',
                    lat: -6.9719012155500035,
                    long: 107.63175115007225,
                  ),
                ),

              ],


              popupController: _popupLayerController,
              popupDisplayOptions: PopupDisplayOptions(
                builder: (_, Marker marker) {
                  if (marker is MonumentMarker) {
                    return MonumentMarkerPopup(monument: marker.monument);
                  }
                  return const Card(child: Text('Not a monument'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Monument {
  static const double size = 25;

  Monument({
    required this.name,
    required this.imagePath,
    required this.lat,
    required this.long,
  });

  final String name;
  final String imagePath;
  final double lat;
  final double long;
}

class MonumentMarker extends Marker {
  MonumentMarker({required this.monument})
      : super(
    anchorPos: AnchorPos.align(AnchorAlign.top),
    height: Monument.size,
    width: Monument.size,
    point: LatLng(monument.lat, monument.long),
    builder: (BuildContext ctx) => const Icon(Icons.place_rounded, size: 30),
  );

  final Monument monument;
}

class MonumentMarkerPopup extends StatelessWidget {
  const MonumentMarkerPopup({Key? key, required this.monument})
      : super(key: key);
  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(monument.imagePath, width: 200),
            Text(monument.name),
            Text('${monument.lat}-${monument.long}'),
          ],
        ),
      ),
    );
  }
}
