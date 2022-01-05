import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  static const double spacing = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Generator'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.folder, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Parent's Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: spacing,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10.0),
                          labelText: "Child's Name",
                          hintText: "Child's Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: spacing,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          isDense: true,
                          prefixText: 'NGN',
                          prefixStyle: TextStyle(
                            color: Colors.white,
                          ),
                          labelText: "Fee",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: spacing,
                ),

                // add button
                SizedBox(
                  width: 100,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.redAccent,
                    minWidth: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Add'),
                        ],
                      ),
                    ),
                  ),
                ),
                // end of add button

                const SizedBox(
                  height: spacing,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey,
                  ),
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    style: const TextStyle(
                      height: 0.7,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Total Paid',
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: () {},
              minWidth: double.infinity,
              height: 70,
              elevation: 3,
              color: Colors.redAccent,
              child: const Text(
                'Generate Invoice',
                style: TextStyle(
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
