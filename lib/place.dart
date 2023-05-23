import 'package:flutter/material.dart';

void main() {
  runApp(const Place());
}

class Place extends StatelessWidget {
  const Place({super.key});

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

class PlaceList extends StatelessWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: _articles.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _articles[index];
              return Container(
                height: 136,
                margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0)),
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
                            Text("${item.category}",
                                style: Theme.of(context).textTheme.caption),
                            SizedBox(height: 10),
                            Text("${item.postedOn}",
                                style: Theme.of(context).textTheme.caption),
                            const SizedBox(height: 8),
                          ],
                        )),
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.imageUrl),
                            ))),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String category;
  final String postedOn;

  Article(
      {required this.title,
        required this.imageUrl,
        required this.category,
        required this.postedOn});
}

final List<Article> _articles = [
  Article(
    title: "Gedung Bangkit",
    category: "Gedung Perkantoran",
    imageUrl: "https://tse3.mm.bing.net/th/id/OIP.S1DLKAVn2ZdRl0q_2wVJGgHaEK?pid=ImgDet&rs=1",
    postedOn: "Gedung Bangkit atau Gedung Rektorat merupakan ...............................................",
  ),
  Article(
      title: "Gedung Graha Wiyata Cacuk Sudarijanto-A",
      imageUrl: "https://cdn.antaranews.com/cache/800x533/2018/12/IMG-20181219-WA0066.jpg",
      category: "Gedung Perkuliahan",
      postedOn: "Gedung Graha Wiyata merupakan merupakan merupakan merupakan merupakan merupakan merupakan"),
];