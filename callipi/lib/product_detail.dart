import 'package:flutter/material.dart';
import 'product_api.dart';

class ProductDetailWidget extends StatelessWidget {
  final String productImageUrl;
  final String productName;
  final String productPrice;
  final String productDescription;

  const ProductDetailWidget({
    super.key,
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.network(
                                  productImageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              productName,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF333333),
                                letterSpacing: -0.28,
                                height: 17 / 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        productPrice,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD60A0A),
                          letterSpacing: -0.4,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 17),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF5F5F5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 19,
                        ),
                        child: Text(
                          productDescription,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333),
                            letterSpacing: -0.24,
                            height: 15 / 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Map<String, dynamic>> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = ProductApi.fetchProduct();
  }

  void _reloadProduct() {
    setState(() {
      productFuture = ProductApi.fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: _reloadProduct,
          ),
        ),
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Color(0xFF2196F3),
            fontFamily: 'SF Pro Text',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.48,
            height: 1.0,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF2196F3)),
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data'));
            }
            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Center(
                child: ProductDetailWidget(
                  productImageUrl: product['imgURL'] ?? '',
                  productName: product['name'] ?? '',
                  productPrice: 'Giá: ${product['price'] ?? ''}₫',
                  productDescription: product['des'] ?? '',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
