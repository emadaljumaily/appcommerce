import 'package:appcommerce/models/Dataj.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
     this.product,
  }) : super(key: key);

  final Dataj product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  final storage=new FlutterSecureStorage();
  void setValuee() async {
    await storage.write(key: 'immj', value: widget.product.image[0]);

  }
  @override
  void initState() {
    setValuee();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child: Image.network(widget.product.image[selectedImage].toString()),
            ),
          ),
        ),
         SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ...List.generate(widget.product.image.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }
  void setValue(aa) async {
    await storage.write(key: 'immj', value: aa);
  }
  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
          //print(widget.product.image[index]);
          setValue(widget.product.image[index]);
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
          child: Image.network(widget.product.image[index].toString()),
      ),
    );
  }
}
