import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marche/models/shop_app/airtime_model.dart';
import 'package:marche/modules/checkout/checkout.dart';
import 'package:marche/modules/credit/addcard.dart';
import 'package:marche/modules/credit/payment.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';
import 'package:marche/modules/login/shop_login-screen.dart';
import 'package:marche/shared/components/components.dart';

class BuyAirTime extends StatefulWidget {
  const BuyAirTime({Key? key}) : super(key: key);

  @override
  State<BuyAirTime> createState() {
    return _BuyAirTimeState();
  }
}

class _BuyAirTimeState extends State<BuyAirTime> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _numberHasError = false;
  bool _amountHasError = false;
  bool _carriertHasError = false;

  var carrierOptions = ['Gamcel', 'Africell', 'Qcell', 'Commium'];
  var amountOptions = ['10', '30', '60', '150'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Buy Airtime')),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  // enabled: false,
                  onChanged: () {
                    _formKey.currentState!.save();
                    debugPrint(_formKey.currentState!.value.toString());
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  skipDisabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      FormBuilderDropdown<String>(
                        // autovalidate: true,
                        name: 'amount',
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          suffix: _amountHasError
                              ? const Icon(Icons.error)
                              : const Icon(Icons.check),
                          hintText: 'Select a carrier',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: amountOptions
                            .map((amount) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: amount,
                                  child: Text(amount),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _amountHasError = !(_formKey
                                    .currentState?.fields['amount']
                                    ?.validate() ??
                                false);
                          });
                        },
                        valueTransformer: (val) => val?.toString(),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.disabled,
                        name: 'phone',
                        maxLength: 7,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          suffixIcon: _numberHasError
                              ? const Icon(Icons.error, color: Colors.red)
                              : const Icon(Icons.check, color: Colors.green),
                        ),
                        onChanged: (val) {
                          if (val == "") {}
                          setState(() {
                            _numberHasError = !(_formKey
                                    .currentState?.fields['phone']
                                    ?.validate() ??
                                false);
                          });
                        },
                        valueTransformer: (text) => num.tryParse(text!),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.match('pattern'), // check that it starts with 3, 5, 2, 7, 9, or 6
                        ]),
                        initialValue: null,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDropdown<String>(
                        // autovalidate: true,
                        name: 'carrier',
                        decoration: InputDecoration(
                          labelText: 'Carrier',
                          suffix: _carriertHasError
                              ? const Icon(Icons.error)
                              : const Icon(Icons.check),
                          hintText: 'Select a carrier',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: carrierOptions
                            .map((carrier) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: carrier,
                                  child: Text(carrier),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _carriertHasError = !(_formKey
                                    .currentState?.fields['carrier']
                                    ?.validate() ??
                                false);
                          });
                        },
                        valueTransformer: (val) => val?.toString(),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      true ? Text("Please fill all required fieds") : Text(""),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print(_formKey.currentState?.fields);
                          if (_formKey.currentState?.fields['phone']!.value ==
                                  null ||
                              _formKey.currentState?.fields['amount']!.value ==
                                  null ||
                              _formKey.currentState?.fields['carrier']!.value ==
                                  null) {
                            ShopCubit().showInfoModal(
                                context,
                                {
                                  "title": "Error",
                                  "desc": "",
                                  "content": "Enter all required fields."
                                },
                                DialogType.ERROR);
                          } else {
                            ShopCubit.get(context).type = 'airtime';
                            ShopCubit.get(context).activeAirtime =
                                AirTimeModel.fromJson({
                              "phone":
                                  _formKey.currentState?.fields['phone']!.value,
                              "amount": _formKey
                                  .currentState?.fields['amount']!.value,
                              "carrier": _formKey
                                  .currentState?.fields['carrier']!.value,
                            });
                            setState(() {});
                            if (ShopCubit.get(context).loginModel == null) {
                              navigateTo(
                                  context,
                                  const ShopLoginScreen(
                                    next: Final_Checkout(),
                                  ));
                            } else {
                              navigateTo(
                                context,
                                Final_Checkout(),
                              );
                            }
                          }
                        },
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              'Place Order',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
