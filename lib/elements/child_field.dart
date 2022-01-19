import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';

class ChildField extends StatefulWidget {
  const ChildField({
    Key? key,
    required this.childNameController,
    required this.feeController,
    required this.currentChildField,
    required this.currentChildNameController,
    required this.currentFeeController,
  }) : super(key: key);
  final TextEditingController childNameController;
  final TextEditingController feeController;
  final int currentChildField;
  final TextEditingController currentChildNameController;
  final TextEditingController currentFeeController;

  @override
  State<ChildField> createState() => _ChildFieldState();
}

class _ChildFieldState extends State<ChildField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          // child's name field
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kLightGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: widget.childNameController,
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
            width: 15,
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
                  controller: widget.feeController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
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
                ),
              ),
            ),
          ),
          // end of fee field

          IconButton(
            onPressed: () {
              setState(() {
                widget.currentChildField;
                widget.currentChildNameController;
                widget.currentFeeController;
              });
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
