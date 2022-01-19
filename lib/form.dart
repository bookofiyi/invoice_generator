import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'package:invoice_generator/constants.dart';
// import 'package:invoice_generator/elements/child_field.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quiver/iterables.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  static const double spacing = 15;
  final TextEditingController _parentName = TextEditingController();
  String parentName = '';
  // final TextEditingController _childName = TextEditingController();
  // final TextEditingController _fee = TextEditingController();
  final TextEditingController _totalPaid = TextEditingController();
  String totalPaid = '';
  int? feeAsInt;
  int? totalPaidAsInt;
  int? totalFee;
  int? outstanding;

  final List<TextEditingController> _childNameControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  // String childName1 = '';
  // String childName2 = '';
  // String childName3 = '';
  // String childName4 = '';
  //
  final List<TextEditingController> _feeControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  String fee1 = '';
  String fee2 = '';
  String fee3 = '';
  String fee4 = '';

  List<int> allFeesAsInt = [];
  Map<String, String>? nameAndFee;
  int? totalExpected;

  String todayDate = '';

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

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _generateInvoice() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawImage(PdfBitmap(await _readImageData('logo.png')),
        const Rect.fromLTWH(0, 0, 100, 100));

    // Receipt text
    page.graphics.drawString('Receipt',
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold),
        bounds: const Rect.fromLTRB(440, 0, 0, 0));
    // end of Receipt text

    // Date Issued text
    page.graphics.drawString(
        todayDate, PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: const Rect.fromLTRB(380, 25, 0, 0));
    // end of Date Issued text

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2),
    );

    grid.columns.add(count: 2);
    grid.headers.add(1);

    // header text
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = _parentName.text;
    // header.cells[1].value = '';

    // ROW 1 (Child Name / Fee)
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = _childNameControllers[0].text;
    row.cells[1].value = 'NGN ${_feeControllers[0].text}';
    // row.cells[1].value = 'NGN 0';

    // ROW 2 (Total Fee to be Paid)
    row = grid.rows.add();
    row.cells[0].value = 'Total Expected';
    row.cells[1].value = 'NGN $totalExpected';
    // row.cells[1].value = 'NGN 0';

    // ROW 3 (Amount Paid currently)
    row = grid.rows.add();
    row.cells[0].value = 'Amount Paid';
    row.cells[1].value = 'NGN ${_totalPaid.text}';
    // row.cells[1].value = 'NGN 0';

    // ROW 4 (Outstanding currently)
    row = grid.rows.add();
    row.cells[0].value = 'Outstanding';
    row.cells[1].value = 'NGN $outstanding';
    // row.cells[1].value = 'NGN 0';

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 150, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, '$parentName.pdf');
  }

  // List<TextEditingController> childrenControllers = [];
  // List<TextEditingController> feeControllers = [];
  // List<int> childrenFields = [];

  // void _addControllers() {
  //   childrenControllers.insert(0, TextEditingController());
  //   feeControllers.insert(0, TextEditingController());
  //   debugPrint('_addControllers() called. Updated list:');
  //   debugPrint('Children Controllers: ${childrenControllers.toString()}');
  //   debugPrint('Fee Controllers: ${feeControllers.toString()}');
  // }

  // void _addChildField() {
  //   setState(() {
  //     childrenFields.add(1); // adds an empty container to list
  //     debugPrint('Children Fields: ${childrenFields.toString()}');
  //   });
  //   // Container is just a placeholder. It does nothing.
  //   // It is basically just filling up the List to be able to keep count
  //   // of number of elements in there.
  // }

  // void _addChildField() {
  //   childrenFields.add(Padding(
  //     padding: const EdgeInsets.only(bottom: 15.0),
  //     child: Row(
  //       children: [
  //         // child's name field
  //         Expanded(
  //           child: Container(
  //             decoration: const BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //               color: kLightGrey,
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 8.0),
  //               child: TextFormField(
  //                 // controller: childrenControllers[],
  //                 style: const TextStyle(
  //                   fontSize: 20,
  //                 ),
  //                 decoration: const InputDecoration(
  //                   contentPadding: EdgeInsets.all(10.0),
  //                   labelText: "Child's Name",
  //                   labelStyle: TextStyle(
  //                     color: kblack,
  //                   ),
  //                   floatingLabelStyle: TextStyle(
  //                     color: kblack,
  //                   ),
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // end of child's name field

  //         const SizedBox(
  //           width: spacing,
  //         ),

  //         // fee field
  //         Expanded(
  //           child: Container(
  //             decoration: const BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //               color: kLightGrey,
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 8.0),
  //               child: TextFormField(
  //                 // controller: ,
  //                 keyboardType: const TextInputType.numberWithOptions(
  //                   decimal: true,
  //                 ),
  //                 style: const TextStyle(
  //                   fontSize: 20,
  //                 ),
  //                 decoration: const InputDecoration(
  //                   contentPadding: EdgeInsets.all(10.0),
  //                   isDense: true,
  //                   prefixText: 'NGN ',
  //                   labelText: "Fee",
  //                   labelStyle: TextStyle(
  //                     color: kblack,
  //                   ),
  //                   floatingLabelStyle: TextStyle(
  //                     color: kblack,
  //                   ),
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // end of fee field

  //         IconButton(
  //           onPressed: () {
  //             setState(() {
  //               childrenFields.removeLast();
  //             });
  //           },
  //           icon: const Icon(Icons.cancel),
  //         ),
  //       ],
  //     ),
  //   ));
  // }

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
              onPressed: () {},
              icon: const Icon(Icons.folder, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kLightGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: _parentName,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            labelText: "Parent's Name",
                            labelStyle: TextStyle(
                              color: kblack,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: kblack,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            parentName = value;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: spacing,
                    ),

                    // first child and fee
                    Row(
                      children: [
                        // child's name field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _childNameControllers[0],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelText: "Child's Name",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // end of child's name field

                        const SizedBox(
                          width: spacing,
                        ),

                        // fee field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _feeControllers[0],
                                cursorColor: kblack,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  isDense: true,
                                  prefixText: 'NGN ',
                                  labelText: "Fee",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  fee1 = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        // end of fee field
                      ],
                    ),
                    //  end of first child and fee

                    const SizedBox(
                      height: spacing,
                    ),

                    // second child and fee
                    Row(
                      children: [
                        // child's name field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _childNameControllers[0],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelText: "Child's Name",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // end of child's name field

                        const SizedBox(
                          width: spacing,
                        ),

                        // fee field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _feeControllers[1],
                                cursorColor: kblack,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  isDense: true,
                                  prefixText: 'NGN ',
                                  labelText: "Fee",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  fee2 = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        // end of fee field
                      ],
                    ),
                    // end of second child and fee

                    const SizedBox(
                      height: spacing,
                    ),

                    // fourth child and fee
                    Row(
                      children: [
                        // child's name field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _childNameControllers[1],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelText: "Child's Name",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // end of child's name field

                        const SizedBox(
                          width: spacing,
                        ),

                        // fee field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _feeControllers[2],
                                cursorColor: kblack,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  isDense: true,
                                  prefixText: 'NGN ',
                                  labelText: "Fee",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  fee3 = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        // end of fee field
                      ],
                    ),
                    // end of third child and fee

                    const SizedBox(
                      height: spacing,
                    ),

                    // third child and fee
                    Row(
                      children: [
                        // child's name field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _childNameControllers[2],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelText: "Child's Name",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // end of child's name field

                        const SizedBox(
                          width: spacing,
                        ),

                        // fee field
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kLightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _feeControllers[3],
                                cursorColor: kblack,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  isDense: true,
                                  prefixText: 'NGN ',
                                  labelText: "Fee",
                                  labelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kblack,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  fee4 = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        // end of fee field
                      ],
                    ),
                    // end of fourth child and fee

                    const SizedBox(
                      height: spacing,
                    ),

                    // // what this should do is generate a list of fields
                    // // with a controllers for each field
                    // if (childrenFields.isNotEmpty)
                    //   ListView.builder(
                    //       padding: EdgeInsets.zero,
                    //       physics: const NeverScrollableScrollPhysics(),
                    //       itemCount: childrenFields.length,
                    //       shrinkWrap: true,
                    //       itemBuilder: (context, index) {
                    //         // TextEditingController _childNameController =
                    //         //     childrenControllers[index];
                    //         // TextEditingController _feeController =
                    //         //     feeControllers[index];
                    //         return ChildField(
                    //           childNameController: childrenControllers[index],
                    //           feeController: feeControllers[index],
                    //           currentChildField: childrenFields.removeAt(index),
                    //           currentChildNameController:
                    //               childrenControllers.removeAt(index),
                    //           currentFeeController:
                    //               feeControllers.removeAt(index),
                    //         );
                    //       })
                    // else
                    //   Container(),

                    // // Column(
                    // //   children: childrenFields,
                    // // ),

                    // const SizedBox(
                    //   height: spacing,
                    // ),

                    // // add button
                    // SizedBox(
                    //   width: 100,
                    //   child: MaterialButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         _addChildField();
                    //         _addControllers();
                    //       });
                    //     },
                    //     color: Colors.redAccent,
                    //     minWidth: 50,
                    //     height: 40,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //     child: Center(
                    //       child: Row(
                    //         children: const [
                    //           Icon(
                    //             Icons.add,
                    //             color: kwhite,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text('Add',
                    //               style: TextStyle(
                    //                 color: kwhite,
                    //                 fontSize: 20,
                    //               )),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // // end of add button

                    const SizedBox(
                      height: spacing,
                    ),

                    // total paid field
                    Container(
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
                    // end of total paid field
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                if (_parentName.text.isEmpty) {
                  showInSnackBar(context, 'Please type in the Parent\'s Name.');
                } else if (_childNameControllers[0].text.isEmpty ||
                    _feeControllers[0].text.isEmpty &&
                        _childNameControllers[1].text.isEmpty ||
                    _feeControllers[1].text.isEmpty &&
                        _childNameControllers[2].text.isEmpty ||
                    _feeControllers[2].text.isEmpty &&
                        _childNameControllers[3].text.isEmpty ||
                    _feeControllers[3].text.isEmpty) {
                  showInSnackBar(
                      context, 'At least one child and fee must be filled.');
                } else if (_totalPaid.text.isEmpty) {
                  showInSnackBar(context, 'Please fill in the total paid.');
                } else {
                  // code below parses the filled in "fee" fields
                  // as ints, then adds them to a list
                  for (var element in _feeControllers) {
                    if (element.text.isNotEmpty) {
                      allFeesAsInt.add(int.parse(element.text));
                    }
                  }
                  totalPaidAsInt = int.parse(totalPaid);
                  totalExpected = allFeesAsInt.fold(
                      0, (previous, current) => previous! + current);
                  // this adds all the members of the allFeesAsInt list

                  // TODO: Run through the filled Child Name and Fees and add each set into a Map

                  // for (var element in _childNameControllers) {
                  //   if (element.text.isNotEmpty) {
                  //     // nameAndFee![element.text] = ;
                  //   }
                  // }
                  todayDate = Jiffy(DateTime.now()).format('do MMM yyyy');
                  _generateInvoice();
                }

                // if (_fee.text.isNotEmpty || _totalPaid.text.isNotEmpty) {
                //   feeAsInt = int.parse(fee);
                //   totalPaidAsInt = int.parse(totalPaid);
                // } else {
                //   showInSnackBar(context, 'Please fill in all the fields');
                // }
                // if (_parentName.text.isEmpty ||
                //     _childName.text.isEmpty ||
                //     _fee.text.isEmpty ||
                //     _totalPaid.text.isEmpty) {
                //   showInSnackBar(context, 'Please fill in all the fields');
                // } else {
                //   if (totalPaidAsInt! > feeAsInt!) {
                //     showInSnackBar(context,
                //         'Total Paid cannot be greater than total fees.');
                //   } else {
                //     totalFee = feeAsInt;
                //     outstanding = (totalFee! - totalPaidAsInt!);
                //     todayDate = Jiffy(DateTime.now()).format('do MMM yyyy');
                //     _generateInvoice();
                //   }
                // }
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
