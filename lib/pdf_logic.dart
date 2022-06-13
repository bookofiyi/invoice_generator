import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'mobile.dart';

class PDFLogic {
  const PDFLogic({
    required this.todayDate,
    required this.customerName,
    required this.itemNames,
    required this.fees,
    required this.totalExpected,
    required this.totalPaid,
    required this.outstanding,
  });

  final String customerName;
  final String todayDate;
  final int totalExpected;
  final String totalPaid;
  final int outstanding;
  final List itemNames;
  final List fees;

  Future<Uint8List> _readImageData(String fullImagePath) async {
    final data = await rootBundle.load(fullImagePath);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> generateInvoice() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    // logo
    page.graphics.drawImage(
        PdfBitmap(await _readImageData('assets/images/logo.png')),
        const Rect.fromLTWH(0, 0, 100, 100));
    // end of logo

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

    // signature
    page.graphics.drawImage(
        PdfBitmap(await _readImageData('assets/images/signature.png')),
        const Rect.fromLTWH(380, 550, 139, 76));
    // end of signature

    // principal officer
    page.graphics.drawString(
        'Principal Officer', PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: const Rect.fromLTRB(405, 600, 0, 0));
    // end of principal officer

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
    header.cells[0].value = customerName;
    // end of header text

    // Rows for item names and fees
    PdfGridRow row;
    for (var i = 0; i < itemNames.length; i++) {
      row = grid.rows.add();
      row.cells[0].value = itemNames[i];
      row.cells[1].value = 'NGN ' + fees[i].toString();
    }
    // end of rows for item names and fees

    // Row for total fees expected
    row = grid.rows.add();
    row.cells[0].value = 'Total Expected';
    row.cells[1].value = 'NGN $totalExpected';
    // end of row for total fees expected

    // Row for amount paid
    row = grid.rows.add();
    row.cells[0].value = 'Amount Paid';
    row.cells[1].value = 'NGN $totalPaid';
    // end of row for amount paid

    // ROW 4 (Outstanding currently)
    row = grid.rows.add();
    row.cells[0].value = 'Outstanding';
    row.cells[1].value = 'NGN $outstanding';

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 150, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, '$customerName.pdf');
  }
}
