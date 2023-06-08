import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/database/places.dart';
import 'package:project1/screens/mapsPage.dart';

void main() {
  runApp(const Place());
}

class Place extends StatelessWidget {
  const Place({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Place',
      theme: ThemeData(),
      home: const PlaceList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  String selectedCategory = 'All';
  String searchKeyword = '';

  List<Places> getFilteredArticles() {
    if (selectedCategory == 'All') {
      return _places
          .where((places) => places.title.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    } else {
      return _places
          .where((places) =>
      places.category == selectedCategory &&
          places.title.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchKeyword = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Text('Filter by Category:'),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'All',
                      child: Text('All'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Gedung Perkantoran',
                      child: Text('Gedung Perkantoran'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Gedung Perkuliahan',
                      child: Text('Gedung Perkuliahan'),
                    ),
                    /*DropdownMenuItem<String>(
                      value: 'Kantin',
                      child: Text('Kantin'),
                    ),*/
                    DropdownMenuItem<String>(
                      value: 'Cafe',
                      child: Text('Cafe'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Area Parkir',
                      child: Text('Area Parkir'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Tempat Ibadah',
                      child: Text('Tempat Ibadah'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ATM',
                      child: Text('ATM'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Pusat Bahasa',
                      child: Text('Pusat Bahasa'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Perpustakaan',
                      child: Text('Perpustakaan'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Taman',
                      child: Text('Taman'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Klinik',
                      child: Text('Klinik'),
                    ),


                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredArticles().length,
              itemBuilder: (BuildContext context, int index) {
                final item = getFilteredArticles()[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlacesDetailPage(places: item),
                      ),
                    );
                  },
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${item.category}",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${item.description}",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.imageUrl[0]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Places {
  final String title;
  final List<String> imageUrl;
  final String category;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final List<Review> reviews;

  Places({
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.reviews, // Ubah tipe data menjadi List<Review?>
  });
}

class Review {
  final String comment;
  final String? imageUrl; // Tambahkan tanda tanya (?) pada tipe data
  Review({
    required this.comment,
    this.imageUrl, // Jadikan atribut imageUrl menjadi opsional
  });
}

class PlacesDetailPage extends StatefulWidget {
  final Places places;

  const PlacesDetailPage({required this.places});

  @override
  _PlacesDetailPageState createState() => _PlacesDetailPageState();
}

class _PlacesDetailPageState extends State<PlacesDetailPage> {
  int _currentSegment = 0;

  Map<int, Widget> _segmentWidgets() {
    return {
      0: Text(
        'About',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      1: Text(
        'Photos',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      2: Text(
        'Map',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      3: Text(
        'Review',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    };
  }

  Widget _currentWidget() {
    switch (_currentSegment) {
      case 0:
        return Text(
          'Address: ${widget.places.address}\n\n'
              'Description: ${widget.places.description}',
          style: TextStyle(fontSize: 16),
        );
      case 1:
        return Column(
          children: widget.places.imageUrl.map((url) => Image.network(url)).toList(),
        );
      case 2:
        return Container(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(widget.places.latitude, widget.places.longitude),
                        zoom: 18,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        if (LatLng != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(widget.places.latitude, widget.places.longitude),
                                builder: (ctx) => const Icon(Icons.place_rounded, size: 30),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
        );
      case 3:
        return Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ...widget.places.reviews.map((review) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.comment,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          if (review.imageUrl != null)
                            Image.network(
                              review.imageUrl!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Comment',
                        ),
                        onChanged: (value) {
                          // TODO: Handle comment input
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Handle submit button
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: widget.places.imageUrl.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.places.title),
        toolbarHeight: 50,
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            ///crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSlider(),
              SizedBox(height: 20),
              Text(
                'Category: ${widget.places.category}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SegmentedControl<int>(
                children: _segmentWidgets(),
                groupValue: _currentSegment,
                onValueChanged: (value) {
                  setState(() {
                    _currentSegment = value!;
                  });
                },
              ),
              SizedBox(height: 15),
              _currentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SegmentedControl<T> extends StatefulWidget {
  final Map<T, Widget> children;
  final T groupValue;
  final ValueChanged<T>? onValueChanged;

  SegmentedControl({
    required this.children,
    required this.groupValue,
    this.onValueChanged,
  });

  @override
  _SegmentedControlState<T> createState() => _SegmentedControlState<T>();
}

class _SegmentedControlState<T> extends State<SegmentedControl<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.children.entries.map((entry) {
          final value = entry.key;
          final child = entry.value;

          return GestureDetector(
            onTap: () {
              if (widget.onValueChanged != null) {
                widget.onValueChanged!(value);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: widget.groupValue == value ? Colors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: child,
            ),
          );
        }).toList(),
      ),
    );
  }
}

final List<Places> _places = [
  Places(
    title: "Gedung Bangkit",
    category: "Gedung Perkantoran",
    imageUrl: ["https://telkomradio.id/wp-content/uploads/2021/07/telkom-university-1024x576.jpg",
      "https://konstruksimedia.com/wp-content/uploads/2022/07/Telkom-University.jpg"],
    description: "Gedung Bangkit atau Gedung Rektorat merupakan kantor rektorat kampus di Kota Bandung.",
    address: "Jl. Telekomunikasi Terusan Buah Batu, Dayeuhkolot, Sukapura, Kec. Dayeuhkolot, Bandung, Jawa Barat 40257, Indonesia",
    latitude: -6.973951100000001,
    longitude: 107.63046689999999,
    reviews: [
      Review(
        comment: "AC tidak berfungsi dengan baik",
        imageUrl: "https://www.salisma.com/wp-content/uploads/2022/10/Telkom-1.jpg",
      ),
      Review(
        comment: "Proyektor tidak dapat dinyalakan",
      ),
    ],
  ),
  Places(
    title: "Gedung Graha Wiyata Cacuk Sudarijanto - A",
    category: "Gedung Perkuliahan",
    imageUrl: ["https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/04/gedung-graha-cacuk-telkom-university-1-scaled.jpeg",
      "https://telkomradio.id/wp-content/uploads/2021/07/telkom-university-1024x576.jpg"],
    description: "Gedung kuliah ini memiliki 16 ruang kelas dengan kapasistas 80 orang dan 78 ruang kelas dengan kapasitas 40.",
    address: "Jl. Telekomunikasi Terusan Buah Batu, Dayeuhkolot, Sukapura, Kec. Dayeuhkolot, Bandung, Jawa Barat 40257, Indonesia",
    latitude: -6.973951100000001,
    longitude: 107.63046689999999,
    reviews: [
      Review(
        comment: "AC tidak berfungsi dengan baik",
      ),
      Review(
        comment: "Proyektor tidak dapat dinyalakan",
        imageUrl: "https://photos.wikimapia.org/p/00/03/66/40/75_big.jpg",
      ),
    ],
  ),
  Places(
    title: "Green Lounge Telkom University",
    category: "Taman",
    imageUrl: ["https://telkomuniversity.ac.id/wp-content/uploads/2021/01/green-lounge.jpg",
      "https://telkomradio.id/wp-content/uploads/2021/07/telkom-university-1024x576.jpg"],
    description: "Merupakan sebuah taman yang terletak di belakang Gedung Bangkit (Rektorat)",
    address: "Jl. Telekomunikasi Terusan Buah Batu, Dayeuhkolot, Sukapura, Kec. Dayeuhkolot, Bandung, Jawa Barat 40257, Indonesia",
    latitude: -6.973951100000001,
    longitude: 107.63046689999999,
    reviews: [
      Review(
        comment: "AC tidak berfungsi dengan baik",
        imageUrl: "https://www.salisma.com/wp-content/uploads/2022/10/Telkom-1.jpg",
      ),
      Review(
        comment: "Proyektor tidak dapat dinyalakan",
        imageUrl: "https://photos.wikimapia.org/p/00/03/66/40/75_big.jpg",
      ),
    ],
  ),
  Places(
    title: "Language Center Telkom University",
    imageUrl: ["https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/13382750-A333-484C-866D-6587605F7428-225x300.jpeg",
      "https://lac.telkomuniversity.ac.id/wp-content/uploads/2020/08/EPRT-prep.jpg",
      ],
    category: "Pusat Bahasa",
    description: "Language Center merupakan tempat pusat bahasa di Telkom University, berlokasi di Gedung Cacuk A",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.974310909896639,
    longitude: 107.63144853455097,
    reviews: [
      Review(
        comment: "Gedung ini kekurangan kucing",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Telkom University Landmark Tower",
    imageUrl: ["https://www.balebandung.com/wp-content/uploads/2021/09/tel-u.jpg",
      "https://konstruksimedia.com/wp-content/uploads/2021/09/IMG-20210908-WA0071-1.jpg"],
    category: "Gedung Perkuliahan", ///"TULT.XXYY",
    description: "TULT berada di Kawasan Pendidikan Telkom Bandung yang memiliki luas 50 Ha dengan 19 lantai.",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.968948016570766,
    longitude: 107.62871574062561,
    reviews: [
      Review(
        comment: "AC tidak berfungsi dengan baik",
        imageUrl: "https://www.salisma.com/wp-content/uploads/2022/10/Telkom-1.jpg",
      ),
      Review(
        comment: "Proyektor tidak dapat dinyalakan",
        imageUrl: "https://photos.wikimapia.org/p/00/03/66/40/75_big.jpg",
      ),
    ],
  ),
  Places(
    title: "Masjid Syamsul Ulum Telkom University",
    imageUrl: ["https://fastly.4sqi.net/img/general/600x600/1637912_QQG2m0GgZEJbPypTIRy28SVEr-pJaajA_t8yiHw5diI.jpg",
    "https://photos.wikimapia.org/p/00/03/66/40/83_big.jpg"],
    category: "Tempat Ibadah",
    description: "Masjid Syamsul ‘Ulum didirikan pada tanggal 28 September 1994, berdiri di atas area timur "
        "kampus dengan luas bangunan 1128,96 m2 dengan daya tampung 2000 orang jamaah.",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.975528853281067,
    longitude: 107.63228715063087,
    reviews: [
      Review(
        comment: "AC tidak berfungsi dengan baik",
        imageUrl: "https://pentazenium.files.wordpress.com/2013/03/img_20130320_1100361.jpg?w=650",
      ),
      Review(
        comment: "Masjid besar dan bersih",
        imageUrl: "https://fastly.4sqi.net/img/general/600x600/1867918_QdwbvDhhdvmPe6yZZaPKhzwtk-nJl6FpkDTUebBiKyw.jpg",
      ),
    ],
  ),
  Places(
    title: "Gedung Tokong Nanas",
    imageUrl: ["https://baa.telkomuniversity.ac.id/tofocep/2021/01/edit-5-scaled-1-1-1.jpg",
    "https://i.pinimg.com/736x/a7/53/17/a753178618349600f7963100c32d84e3--bandung-java.jpg",
    "https://cpad.ask.fm/835/779/894/-109996988-1t9emhm-4rat1lpdac166o5/original/avatar.jpg"],
    category: "Gedung Perkuliahan", ///"KU3.XX.YY",
    description: "Nama Gedung Tokong Nanas yang di ambil dari salah satu laut di nata, pulau terluar di Indonesia yang terletak di Riau dan berbatasan dengan Malaysia",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.972787023447546,
    longitude: 107.62969663051702,
    reviews: [
      Review(
        comment: "Gedung ini kekurangan kucing",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Gedung Karang",
    imageUrl: [
      "https://sie.telkomuniversity.ac.id/batemaq/2021/08/Halaman-Depan-FRI.jpg",
      "https://it.telkomuniversity.ac.id/bemucil/2021/10/Gedung-Teknik-Industri-Telkom-University.jpg"
    ],
    category: "Gedung Perkuliahan",
    description: "Gedung Karang adalah gedung milik Fakultas Rekayasa Industri dengan total luas 4,848.72 m2",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.975540383746578,
    longitude: 107.63130129500276,
    reviews: [
      Review(
        comment: "Udara segar",
        imageUrl: "https://lh5.googleusercontent.com/p/AF1QipMlg9FNvOXOLNQiWDezhFdb8ciylq4hHXFCXMXH=w426-h240-k-no",
      ),
    ],
  ),
  Places(
    title: "Gedung Grha Wiyata Cacuk Sudarijanto-B",
    imageUrl: [
      "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ""
    ],
    category: "Gedung Perkuliahan",
    description: "Gedung Grha Wiyata Cacuk Sudarijanto-B adalah gedung milik Fakultas Rekayasa Industri dengan total luas 5,676.48 m2",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.974864926229921,
    longitude: 107.63107943520143,
    reviews: [
      Review(
        comment: "Gedung ini kekurangan kucing",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Gedung Panambulai",
    imageUrl: [
      "https://fra1.digitaloceanspaces.com/places/uploads/place/image/file/11624769/2018-08-10.jpg",
      "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/WhatsApp-Image-2023-05-29-at-11.48.33.jpeg"
    ],
    category: "Gedung Perkuliahan",
    description: "Gedung Panambulai merupakan gedung milik Fakultas Informatika (FIF) dengan total luas 2,663.28 m2",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.975824640374241,
    longitude: 107.63055996000993,
    reviews: [
      Review(
        comment: "Keren",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/371E830B-6DAA-49D2-9017-8CBC1B3BD0FA-225x300.jpeg",
      ),
    ],
  ),
  Places(
    title: "TelU Coffee",
    imageUrl: [
      "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/04/cafe-dalam-kampus-ini-dia-tel-u-coffe-1.jpeg",
      "https://img.restaurantguru.com/r6a7-Tel-U-Coffee-facade.jpg"
    ],
    category: "Cafe",
    description: "Tel U Coffee adalah gagasan dari direktorat career alumni endowment untuk menciptakan tempat kopi di dalam kampus "
        "Telkom University. Tel U Coffee berfokus pada menciptakan “tempat ketiga” dan “pengalaman” unik bagi para mahasiswa & staff yang "
        "menggabungkan padatnya jadwal kuliah atau mengajar. Adanya “suasana” berbeda dalam Tel-U Coffee harapan nya dapat "
        "menciptakan memori suasana Dulu,sekarang, dan Nanti.",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.973085817939898,
    longitude: 107.62939001899099,
    reviews: [
      Review(
        comment: "Tempat asik buat reunian",
        imageUrl: "https://www.fast.or.id/wp-content/uploads/2020/08/72776471_780561492382676_6011987148976256172_n.jpg",
      ),
    ],
  ),
  Places(
    title: "Open Library Telkom University",
    imageUrl: [
      "https://kanalbekasi.com/wp-content/uploads/2022/06/IMG-20220621-WA0032.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/8/84/Open_Library_Telkom_University.jpg"
    ],
    category: "Perpustakaan",
    description: "Open Library merupakan perpustakaan digital Telkom University. Disini tersedia informasi seluruh koleksi pustaka yang dimiliki Telkom University. Berdiri pada tanggal 3 Juni 2022",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.971726718740034,
    longitude: 107.63241714587393,
    reviews: [
      Review(
        comment: "Tempatnya comfy banget",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Gedung Fakultas Ilmu Terapan",
    imageUrl: [
      "https://fit.labs.telkomuniversity.ac.id/wp-content/uploads/sites/37/2016/06/DSC_0021.jpg",
      "https://dho.telkomuniversity.ac.id/pevavin/uploads/2016/04/Fakultas-Ilmu-Terapan-FIT-Telkom-University.jpg"
    ],
    category: "Gedung Perkuliahan",
    description: "Merupakan gedung yang dimiliki oleh Fakultas Ilmu Terapan",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.9732223143354055,
    longitude: 107.63253973988182,
    reviews: [
      Review(
        comment: "Banyak kucing",
        imageUrl: "https://sas.telkomuniversity.ac.id/wp-content/uploads/2016/12/cropped-FIT-inside-940x310-574x164.jpg",
      ),
    ],
  ),
  Places(
    title: "ATM Center Gate 2",
    imageUrl: [
      "https://www.cakaplah.com/assets/news/29082017/cakaplah_pezmu_10024.jpg",
      ""
    ],
    category: "ATM",
    description: "ATM Mandiri dan ATM Bersama",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.972845739262763,
    longitude: 107.63324427089648,
    reviews: [
      Review(
        comment: "Panas namun bersih",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Danau Galau",
    imageUrl: [
      "https://awsimages.detik.net.id/community/media/visual/2022/08/15/danau-galau_169.jpeg?w=650&q=80",
      ""
    ],
    category: "Taman",
    description: "Danau Galau bisa dibilang salah satu titik di Telkom university yang sangat iconic",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.973039495053113,
    longitude: 107.63151275392327,
    reviews: [
      Review(
        comment: "Banyak soang",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/04/penjaga-danau-galau-telkom-university.jpeg",
      ),
    ],
  ),
  Places(
    title: "Klinik Telkomedika",
    imageUrl: [
      "https://lh5.googleusercontent.com/p/AF1QipO-hOnNmMo4tNJFmgq5drdeRX8r60bBhT9YUcFB=w408-h257-k-no",
      "https://fra1.digitaloceanspaces.com/places/uploads/place/image/file/11640717/WhatsApp_Image_2020-06-23_at_3.48.49_PM.jpeg"
    ],
    category: "Klinik",
    description: "Klinik Telkomedika berlokasi di sebelah selatan Telkom University",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.977317504288408,
    longitude: 107.63039363313504,
    reviews: [
      Review(
        comment: "Gedung ini kekurangan kucing",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Gedung Serba Guna",
    imageUrl: [
      "https://kbi2015.idbigdata.com/wp-content/uploads/2015/11/GSG.jpg",
      "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/WhatsApp-Image-2023-05-29-at-15.35.29.jpeg"
    ],
    category: "Gedung Perkuliahan",
    description: "Gedung Serba Guna (GSG) atau sering disebut juga Gedung H",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.976616376576964,
    longitude: 107.63039894557332,
    reviews: [
      Review(
        comment: "Gedung ini kekurangan kucing",
        imageUrl: "https://campuslife.telkomuniversity.ac.id/wp-content/uploads/2023/05/IMG-20230519-WA0044.jpg",
      ),
    ],
  ),
  Places(
    title: "Area Parkir FIT & FEB",
    imageUrl: [
      "https://bemfkbtelu.files.wordpress.com/2017/10/1507031332338.jpg",
      ""
    ],
    category: "Area Parkir",
    description: "Membutuhkan kartu tanda mahasiswa (KTM)",
    address: "Jl. Telekomunikasi No.1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257",
    latitude: -6.9719012155500035,
    longitude: 107.63175115007225,
    reviews: [
      Review(
        comment: "Penuh sekali",
        imageUrl: "https://bemfkbtelu.files.wordpress.com/2017/10/1507031346278.jpg",
      ),
    ],
  ),
];
