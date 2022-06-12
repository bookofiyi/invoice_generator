import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';
import 'package:invoice_generator/settings.dart';

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
          // _generateInvoiceButton(),

          Center(
            child: MaterialButton(
              onPressed: () {},
              minWidth: double.infinity,
              height: 70,
              elevation: 3,
              color: kred,
              child: const Text('Generate Invoice',
                  style: TextStyle(
                    fontSize: 25,
                    color: kwhite,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
