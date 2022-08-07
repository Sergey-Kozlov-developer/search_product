import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_product/presentation/cart/database/db_helper.dart';
import 'package:search_product/presentation/cart/model/cart_model.dart';
import 'package:search_product/presentation/cart/provider/cart_provider.dart';
import 'package:search_product/presentation/resources/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Избранное'),
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
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: Consumer<CartProvider>(
          builder: (BuildContext context, provider, widget) {
            if (provider.cart.isEmpty) {
              return const Center(
                child: Text(
                  'Your Cart is Empty',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              );
            } else {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 1.0),
                shrinkWrap: true,
                itemCount: provider.cart.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 5.0,
                        child: Row(
                          children: [
                            // Spacer(),
                            CachedNetworkImage(
                              imageUrl: provider.cart[index].image!,
                              width: 70,
                              height: 70,
                              progressIndicatorBuilder:
                                  (context, url, progress) {
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
                            // Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(provider.cart[index].productName!),
                                const SizedBox(height: 5),
                                Text(provider.cart[index].productSubName!),
                                const SizedBox(height: 5),
                                Text(provider.cart[index].unitTag!),
                                ValueListenableBuilder<int>(
                                  valueListenable:
                                      provider.cart[index].quantity!,
                                  builder: (context, val, child) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        PlusMinusButtons(
                                          addQuantity: () {
                                            cart.addQuantity(
                                                provider.cart[index].id!);
                                            dbHelper!.updateQuantity(
                                              Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: provider
                                                    .cart[index].productName,
                                                productSubName: provider
                                                    .cart[index].productSubName,
                                                quantity: ValueNotifier(provider
                                                    .cart[index]
                                                    .quantity!
                                                    .value),
                                                unitTag: provider
                                                    .cart[index].unitTag,
                                                image:
                                                    provider.cart[index].image,
                                              ),
                                            );
                                          },
                                          deleteQuantity: () {
                                            cart.deleteQuantity(
                                                provider.cart[index].id!);
                                          },
                                          text: val.toString(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.mainDarkBlue),
                          onPressed: () {
                            dbHelper!.deleteCartItem(provider.cart[index].id!);
                            provider.removeItem(provider.cart[index].id!);
                            provider.removeCounter();
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment Successful'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            color: Colors.yellow.shade600,
            alignment: Alignment.center,
            height: 50.0,
            child: const Text(
              'Proceed to Pay',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;

  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: deleteQuantity,
            icon: const Icon(Icons.remove),
            color: AppColors.mainDarkBlue),
        Text(text),
        IconButton(
            onPressed: addQuantity,
            icon: const Icon(Icons.add),
            color: AppColors.mainDarkBlue),
      ],
    );
  }
}
