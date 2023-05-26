import 'package:flutter/material.dart';

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
      home: PlaceList(),
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
                    height: 136,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
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
                                "${item.postedOn}",
                                style: Theme.of(context).textTheme.caption,
                              ),
                              const SizedBox(height: 8),
                            ],
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
                              image: NetworkImage(item.imageUrl),
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
  final String imageUrl;
  final String category;
  final String postedOn;

  Places(
      {required this.title,
        required this.imageUrl,
        required this.category,
        required this.postedOn});
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
        'Title',
        style: TextStyle(fontSize: 16),
      ),
      1: Text(
        'Category',
        style: TextStyle(fontSize: 16),
      ),
      2: Text(
        'Posted On',
        style: TextStyle(fontSize: 16),
      ),
    };
  }

  Widget _currentWidget() {
    switch (_currentSegment) {
      case 0:
        return Text(
          widget.places.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      case 1:
        return Text(
          'Category: ${widget.places.category}',
          style: TextStyle(fontSize: 16),
        );
      case 2:
        return Text(
          'Posted On: ${widget.places.postedOn}',
          style: TextStyle(fontSize: 16),
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.places.title),
        toolbarHeight: 30,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.places.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            SegmentedControl<int>(
              children: _segmentWidgets(),
              groupValue: _currentSegment,
              onValueChanged: (value) {
                setState(() {
                  _currentSegment = value!;
                });
              },
            ),
            SizedBox(height: 8.0),
            _currentWidget(),
          ],
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
    imageUrl: "https://tse3.mm.bing.net/th/id/OIP.S1DLKAVn2ZdRl0q_2wVJGgHaEK?pid=ImgDet&rs=1",
    postedOn: "Gedung Bangkit atau Gedung Rektorat merupakan ...............................................",
  ),
  Places(
    title: "Gedung Bangkit",
    category: "Gedung Perkantoran",
    imageUrl: "https://tse3.mm.bing.net/th/id/OIP.S1DLKAVn2ZdRl0q_2wVJGgHaEK?pid=ImgDet&rs=1",
    postedOn: "Gedung Bangkit atau Gedung Rektorat merupakan ...............................................",
  ),
  Places(
    title: "Gedung Bangkit",
    category: "Gedung Perkantoran",
    imageUrl: "https://tse3.mm.bing.net/th/id/OIP.S1DLKAVn2ZdRl0q_2wVJGgHaEK?pid=ImgDet&rs=1",
    postedOn: "Gedung Bangkit atau Gedung Rektorat merupakan ...............................................",
  ),
  Places(
      title: "Gedung Graha Wiyata Cacuk Sudarijanto-A",
      imageUrl: "https://cdn.antaranews.com/cache/800x533/2018/12/IMG-20181219-WA0066.jpg",
      category: "Gedung Perkuliahan",
      postedOn: "Gedung Graha Wiyata merupakan merupakan merupakan merupakan merupakan merupakan merupakan"),
];
