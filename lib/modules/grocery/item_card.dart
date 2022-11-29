import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marche/models/shop_app/shopdata_model.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:marche/shared/components/constants.dart';
import 'package:marche/shared/networks/end_points.dart';
import 'package:marche/shared/styles/dimensions.dart';

import '../../models/shop_app/cart_model.dart';

class ItemCard extends StatefulWidget {
  final ItemDataModel product;
  const ItemCard(this.product);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = ShopCubit.get(context).cart.contains(widget.product);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: 4, bottom: 5),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 220,
              width: 180,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(Dimensions.RADIUS_SMALL)),
                        child: Image(
                          image: NetworkImage(
                              '${URL}img?id=' +
                                  widget.product.image!,
                              headers: {'x-auth-token': "token"}),
                          width: 180,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // itemList[index]['active']
                      //     ? SizedBox()
                      //     : NotAvailableWidget(
                      //         isStore: false),
                    ]),
                    Expanded(
                      child: Stack(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  widget.product.name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeLarge),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text("\$" +
                                          widget.product.price.toString()),
                                    ]),
                              ]),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                if (isSelected) {
                                  ShopCubit.get(context)
                                      .cart
                                      .remove(widget.product);
                                } else {
                                  ShopCubit.get(context)
                                      .cart
                                      .add(widget.product);
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                                child: Icon(
                                    isSelected ? Icons.remove : Icons.add,
                                    size: 20,
                                    color: Colors.white),
                              ),
                            )),
                      ]),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
