import 'package:flutter/material.dart';

final ValueNotifier<List<Map<String, dynamic>>> cartItems =
    ValueNotifier<List<Map<String, dynamic>>>([]);

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Katalog',
      theme: ThemeData(useMaterial3: true),
      home: DiscoverPage(),
    );
  }
}

class DiscoverPage extends StatelessWidget {
  DiscoverPage({super.key});

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Cyber Security Summit',
      'price': 650,
      'image': 'assets/images/cyber.png',
      'date': '12 Mart 2026 ㆍ 11.00 - 16.50',
      'location': 'Bursa',
      'isOnline': false,
      'desc':
          'Siber güvenlik alanındaki güncel tehditler, savunma mekanizmaları ve kariyer fırsatlarının ele alınacağı kapsamlı bir zirve. Etkinlik kapsamında uzman konuşmacılar tarafından gerçekleştirilecek oturumlar, canlı demo gösterimleri ve panel tartışmaları yer alacaktır. Katılımcılar networking alanında sektör profesyonelleriyle birebir iletişim kurma fırsatı yakalayacaktır.',
    },
    {
      'name': 'Junior Developer Meetup',
      'price': 200,
      'image': 'assets/images/junior.png',
      'date': '25 Mart 2026 ㆍ 12.00 - 16.00',
      'location': 'İstanbul',
      'isOnline': false,
      'desc':
          'Junior geliştiriciler için özel olarak tasarlanmış bu meetup etkinliğinde teknik paylaşımlar, kariyer yol haritası konuşmaları ve mini CV/LinkedIn değerlendirme seansı yapılacaktır. Katılımcılar hem deneyim paylaşımı yapacak hem de yazılım dünyasında ilk adımlarını daha sağlam atma fırsatı bulacaktır.',
    },
    {
      'name': 'CodeUp Community Day',
      'price': 300,
      'image': 'assets/images/codeup.png',
      'date': '5 Nisan 2026 ㆍ 11.00 - 17.00',
      'location': 'Online',
      'isOnline': true,
      'desc':
          'Topluluk odaklı bu etkinlikte yazılım geliştiriciler bir araya gelerek teknik atölye çalışmaları, mini hackathon ve ekip çalışmaları gerçekleştirecektir. Gün boyunca farklı konularda kısa teknik sunumlar yapılacak ve katılımcılar aktif olarak projelere dahil olacaktır.',
    },
    {
      'name': 'Women in Tech',
      'price': 450,
      'image': 'assets/images/women.png',
      'date': '18 Nisan 2026 ㆍ 11.00 - 16.50',
      'location': 'Online',
      'isOnline': true,
      'desc':
          'Teknoloji alanında kadınların güçlendirilmesini amaçlayan bu etkinlikte ilham veren konuşmalar, deneyim paylaşımları ve mentorluk oturumları yer alacaktır. Katılımcılar sektörde aktif rol alan profesyonellerle tanışma ve kariyer fırsatları hakkında bilgi edinme imkanı bulacaktır.',
    },
    {
      'name': 'Startup Networking Night',
      'price': 250,
      'image': 'assets/images/networking.png',
      'date': '30 Nisan 2026 ㆍ 15.00 - 19.50',
      'location': 'İzmir',
      'isOnline': false,
      'desc':
          'Girişimcilik ve yazılım dünyasını bir araya getiren bu networking gecesinde startup kurucuları, yatırımcılar ve geliştiriciler bir araya geliyor. Serbest networking alanı, kısa sunumlar ve girişim tanıtımları ile katılımcılar yeni iş birlikleri kurma fırsatı yakalayacaktır.',
    },
    {
      'name': 'NextGen Developer',
      'price': 500,
      'image': 'assets/images/nextgen.png',
      'date': '10 Mayıs 2026 ㆍ 11.00 - 16.00',
      'location': 'Online',
      'isOnline': true,
      'desc':
          'Geleceğin geliştiricileri için hazırlanan bu etkinlikte modern web teknolojileri, mobil geliştirme trendleri ve yapay zeka uygulamaları ele alınacaktır. Teknik oturumlar ve canlı kodlama demoları ile katılımcılar bilgi seviyelerini ileriye taşıyacaktır.',
    },
  ];
  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((p) {
      final name = (p['name'] as String).toLowerCase();
      return name.contains(searchCtrl.text.toLowerCase().trim());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evently'),
        actions: [
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: cartItems,
            builder: (context, items, _) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (items.isNotEmpty)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${items.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              controller: searchCtrl,
              onChanged: (_) => (context as Element).markNeedsBuild(),
              decoration: InputDecoration(
                hintText: 'Etkinlik ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          if (searchCtrl.text.trim().isEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/banner.png',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'Sonuç bulunamadı...',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      //  burası InkWell + Card kodu
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    product['image'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  '₺${product['price']}',
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 8),
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

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product['image'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // 📅 Tarih
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 18),
                SizedBox(width: 8),
                Text(
                  'Tarih',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(product['date'], style: const TextStyle(fontSize: 15)),

            const SizedBox(height: 16),

            // 📍 Konum
            Row(
              children: const [
                Icon(Icons.location_on, size: 18),
                SizedBox(width: 8),
                Text(
                  'Konum',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(product['location'], style: const TextStyle(fontSize: 15)),

            const SizedBox(height: 16),

            // 📝 Açıklama
            Row(
              children: const [
                Icon(Icons.description, size: 18),
                SizedBox(width: 8),
                Text(
                  'Etkinlik Hakkında',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product['desc'],
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),

            const SizedBox(height: 16),
            Text(
              product['name'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '₺${product['price']}',
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartItems.value = [...cartItems.value, widget.product];

                  setState(() {
                    isAdded = true;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ürün sepete eklendi 🛒")),
                  );
                },
                child: Text(isAdded ? "Sepete Eklendi ✓" : "Sepete Ekle"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')), //Cart =Sepetim
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: cartItems,
        builder: (context, items, _) {
          final total = items.fold<int>(
            0,
            (sum, item) => sum + (item['price'] as int),
          );

          if (items.isEmpty) {
            return const Center(
              child: Text(
                "Sepetin şu an boş 🛒",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return Column(
            children: [
              /// 🔥 TOPLAM BAR
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Toplam: ₺$total",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// 🔥 LİSTE
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final product = items[index];

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(product['name']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "₺${product['price']}",
                              style: const TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                final updated = [...cartItems.value];
                                updated.removeAt(index);
                                cartItems.value = updated;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
