import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateSettingDialog extends StatefulWidget {
  Function setBookingDate;
  DateRangePickerController dateRangePickerController;
  DateSettingDialog({required this.setBookingDate,required this.dateRangePickerController});

  @override
  _DateSettingDialogState createState() => _DateSettingDialogState();
}

class _DateSettingDialogState extends State<DateSettingDialog> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed:() => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                  Text(
                    "Date",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                      onPressed:() => widget.setBookingDate(),
                      icon: const Icon(Icons.check,color: Colors.green,)),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Check In",
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )
                          ),
                          const SizedBox(height: 10),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.green,
                                ),
                                color: Colors.white,
                              ),
                              child:Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.dateRangePickerController.selectedRange == null
                                        ? "Select Date"
                                        :
                                    widget.dateRangePickerController.selectedRange!.startDate == null
                                        ? "Select Date"
                                        :
                                    DateFormat('dd/MM/yyyy').format(widget.dateRangePickerController.selectedRange!.startDate!),
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Check Out",
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )
                          ),
                          const SizedBox(height: 10),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.red,
                                ),
                                color: Colors.white,
                              ),
                              child:Row(
                                children:[
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.dateRangePickerController.selectedRange == null
                                        ? "Select Date"
                                        :
                                    widget.dateRangePickerController.selectedRange!.endDate == null
                                        ? "Select Date"
                                        :
                                    DateFormat('dd/MM/yyyy').format(widget.dateRangePickerController.selectedRange!.endDate!),
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SfDateRangePicker(
                controller: widget.dateRangePickerController,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    setState(() {
                      print(args.value);
                    });
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}