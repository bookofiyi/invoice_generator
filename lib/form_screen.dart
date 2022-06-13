import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';
import 'package:invoice_generator/pdf_logic.dart';
import 'package:invoice_generator/settings.dart';
import 'package:jiffy/jiffy.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  static const double spacing = 15;
  final List<TextEditingController> _itemControllers = [];
  final List<TextEditingController> _feeControllers = [];
  final List<Widget> _itemAndRowFields = [];

  final TextEditingController _customerName = TextEditingController();
  String customerName = '';
  final TextEditingController _totalPaid = TextEditingController();
  String totalPaid = '';
  int? totalExpected;

  List<String> itemNames = [];
  List<int> fees = [];
  String todayDate = '';
  int? totalPaidAsInt;
  int? outstanding;

  @override
  void dispose() {
    for (final controller in _itemControllers) {
      controller.dispose();
    }
    for (final controller in _feeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _addFields() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final itemController = TextEditingController();
        final feeController = TextEditingController();
        final fields = Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                // item's name field
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kLightGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: itemController,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "Item ${_itemControllers.length + 1}",
                            labelStyle: const TextStyle(
                              color: kblack,
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: kblack,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // end of item's name field

                const SizedBox(
                  width: spacing,
                ),

                // fee field
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kLightGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: feeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          isDense: true,
                          prefixText: 'NGN ',
                          labelText: "Fee ${_feeControllers.length + 1}",
                          labelStyle: const TextStyle(
                            color: kblack,
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: kblack,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                // end of fee field

                IconButton(
                  onPressed: () {
                    setState(() {
                      _itemAndRowFields.removeLast();
                      _itemControllers.removeLast();
                      _feeControllers.removeLast();
                    });
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ));

        setState(() {
          _itemControllers.add(itemController);
          _feeControllers.add(feeController);
          _itemAndRowFields.add(fields);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: _itemAndRowFields.length,
        itemBuilder: (context, index) {
          return Container(
            child: _itemAndRowFields[index],
          );
        });
  }

  void showInSnackBar(context, String value) {
    final snackBar = SnackBar(
      content: Text(value),
      backgroundColor: kred,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: kwhite,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Generator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // customer name field
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kLightGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: _customerName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Customer's Name",
                    labelStyle: TextStyle(
                      color: kblack,
                    ),
                    floatingLabelStyle: TextStyle(
                      color: kblack,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    customerName = value;
                  },
                ),
              ),
            ),
          ),
          // end of customer name field
          const SizedBox(
            height: spacing,
          ),
          Expanded(
            child: _listView(),
          ),
          _addFields(),

          // total paid field
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kLightGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: _totalPaid,
                  cursorColor: kblack,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    color: kblack,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    prefixText: 'NGN ',
                    labelText: 'Total Paid',
                    labelStyle: TextStyle(
                      color: kblack,
                    ),
                    floatingLabelStyle: TextStyle(
                      color: kblack,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    totalPaid = value;
                  },
                ),
              ),
            ),
          ),
          // end of total paid field

          const SizedBox(
            height: spacing,
          ),

          Center(
            child: MaterialButton(
              onPressed: () {
                if (_customerName.text.isEmpty) {
                  showInSnackBar(
                      context, 'Please enter in the Customer\'s Name.');
                } else if (_totalPaid.text.isEmpty) {
                  showInSnackBar(context, 'Please enter the total paid.');
                } else {
                  // makes sure the lists are empty before adding new values.
                  // This is especially useful for when a user generates a PDF,
                  // then goes back to make changes to the entered values.
                  itemNames.clear();
                  fees.clear();
                }

                // adds content of non-empty text fields for item names and
                // adds them to itemNames list
                _itemControllers
                    .where((element) => element.text != '')
                    .forEach((element) {
                  itemNames.add(element.text);
                });

                // converts content of non-empty text fields for fees to ints
                // and adds them to fees list
                _feeControllers
                    .where((element) => element.text != '')
                    .forEach((element) {
                  fees.add(int.parse(element.text));

                  totalPaidAsInt = int.parse(totalPaid);
                  // sums up the fees expected to be paid
                  totalExpected = fees.fold(
                      0, (previousValue, current) => previousValue! + current);
                  outstanding = totalExpected! - totalPaidAsInt!;

                  todayDate = Jiffy(DateTime.now()).format('do MMM yyyy');

                  if (totalPaidAsInt! > totalExpected!) {
                    showInSnackBar(context,
                        'Total Expected cannot be higher than Total Paid.');
                  } else if (itemNames.length > fees.length) {
                    showInSnackBar(context, 'Please fill in the missing fee.');
                  } else if (itemNames.length < fees.length) {
                    showInSnackBar(
                        context, 'Please fill in the missing item name.');
                  } else {
                    PDFLogic pdf = PDFLogic(
                      customerName: customerName,
                      todayDate: todayDate,
                      itemNames: itemNames,
                      fees: fees,
                      totalExpected: totalExpected!,
                      totalPaid: _totalPaid.text,
                      outstanding: outstanding!,
                    );
                    pdf.generateInvoice();
                  }
                });
              },
              minWidth: double.infinity,
              height: 70,
              elevation: 3,
              color: kred,
              child: const Text(
                'Generate Invoice',
                style: TextStyle(
                  fontSize: 25,
                  color: kwhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
