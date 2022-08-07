import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_product/presentation/cart/database/db_helper.dart';
import 'package:search_product/presentation/cart/model/cart_model.dart';
import 'package:search_product/presentation/cart/model/item_model.dart';
import 'package:search_product/presentation/cart/model/products_data.dart';
import 'package:search_product/presentation/cart/provider/cart_provider.dart';
import 'package:search_product/presentation/cart/view/cart_screen.dart';
import 'package:search_product/presentation/resources/app_colors.dart';
import 'package:search_product/presentation/search/search_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper!
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: products[index].name,
          productSubName: products[index].subName,
          quantity: ValueNotifier(1),
          unitTag: products[index].unit,
          image: products[index].image,
        ),
      )
          .then((value) {
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(
        // title: buildSearch(),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 1.0),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  color: Colors.white,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CachedNetworkImage(
                          imageUrl: products[index].image,
                          width: 80,
                          height: 80,
                          progressIndicatorBuilder: (context, url, progress) {
                            return Container(
                              alignment: Alignment.center,
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.mainDarkBlue,
                                value: progress.progress,
                              ),
                            );
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(products[index].name.toString()),
                            Text(products[index].subName.toString()),
                            Text(products[index].unit.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: AppColors.mainDarkBlue),
                  onPressed: () {
                    saveData(index);
                  },
                  child: Icon(Icons.star_border_outlined),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

// Widget buildSearch() {
//   return SearchWidget(
//     text: query,
//     hintText: 'Введите запрос...',
//     onChanged: searchBook,
//   );
// }
//
// // метод для поиска
// void searchBook(String query) {
//   final productsItem = products.where((product) {
//     final titleLower = product.name.toLowerCase();
//     final authorLower = product.subName.toLowerCase();
//     final searchLower = query.toLowerCase();
//
//     return titleLower.contains(searchLower) ||
//         authorLower.contains(searchLower);
//   }).toList();
//
//   setState(() {
//     this.query = query;
//     this.productsItem = productsItem;
//   });
// }
}