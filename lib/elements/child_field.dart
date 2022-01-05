import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';

class ChildField extends StatelessWidget {
  const ChildField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // child's name field
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: kLightGrey,
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: TextField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
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
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  isDense: true,
                  prefixText: 'NGN ',
                  // prefixStyle: TextStyle(
                  //   color: kgrey,
                  //   fontSize: 20,
                  // ),
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
          onPressed: () {},
          icon: const Icon(Icons.cancel),
        ),
      ],
    );
  }
}
