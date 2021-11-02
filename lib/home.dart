import 'package:flutter/material.dart';
import 'package:product_demo/buy.dart';
import 'package:product_demo/product.dart';

class ProductHome extends StatefulWidget {
  const ProductHome({Key? key}) : super(key: key);

  @override
    _ProductHomeState createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  late Future<List<Product>> lsProduct;
  void initState() {
    super.initState();
    lsProduct = Product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("PRODUCT"),
        ),
        body: FutureBuilder(
            future: Product.fetchData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Product dt = snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          dt.title,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          dt.description,
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                        ),
                        leading: Image.network(
                          dt.image,
                          width: 100,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("\$${dt.price}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blue)),
                            BuyProduct()
                          ],
                        ),
                        isThreeLine: true,
                        horizontalTitleGap: 10,
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
