import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:marche/models/shop_app/creditcard_model.dart';

class CCardWidget extends StatefulWidget {
  final CardsModel? model;
  final Function callback;
  final String? activecard;
  const CCardWidget({
    required this.model,
    required this.callback,
    required this.activecard,
  });

  @override
  State<CCardWidget> createState() => Credit_CardState();
}

class Credit_CardState extends State<CCardWidget> {
  String type = "";
  String parsedNumber = "";
  final visa = RegExp('^4[0-9]{6,}\$');
  final master = RegExp(
      '^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}\$');
  final amex = RegExp('^3[47][0-9]{5,}\$');
  final discover = RegExp('^6(?:011|5[0-9]{2})[0-9]{3,}\$');
  final jcb = RegExp('^(?:2131|1800|35[0-9]{3})[0-9]{3,}\$');

  @override
  void initState() {
    super.initState();
    var cnum = widget.model!.number.toString();

    if (visa.hasMatch(cnum)) {
      type = "Visa";
    } else if (master.hasMatch(cnum)) {
      type = "MasterCard";
    } else if (amex.hasMatch(cnum)) {
      type = "Amex";
    } else if (discover.hasMatch(cnum)) {
      type = "Discover";
    } else if (jcb.hasMatch(cnum)) {
      type = "JCB";
    }
    var count = 0;
    parsedNumber = "";
    widget.model!.number.toString().split("").forEach((e) {
      if (count == 4) {
        print(e);
        parsedNumber = parsedNumber + "-" + e;
        count = 0;
      } else {
        parsedNumber = parsedNumber + e;
      }
      count += 1;
    });
  }

  Future checkout() {
    return Dialogs.materialDialog(
      color: Colors.white,
      msg: 'Congratulations, you won 500 points',
      title: 'Congratulations',
      lottieBuilder: Lottie.asset(
        'assets/cong_example.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: kIsWeb ? 0.3 : null,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Claim',
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget.callback(widget.model!.id);
        },
        child: Card(
          elevation: 5,
          color: widget.model!.id == widget.activecard
              ? Colors.redAccent
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(type,
                          style: TextStyle(
                            fontSize: 20,
                            color: widget.model!.id == widget.activecard
                                ? Colors.white
                                : Colors.black,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        parsedNumber,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: widget.model!.id == widget.activecard
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            widget.model!.date.toString().split("-")[0] +
                                " - " +
                                widget.model!.date.toString().split("-")[1],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: widget.model!.id == widget.activecard
                                    ? Colors.white
                                    : Colors.black),
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                color: widget.model!.id == widget.activecard
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
