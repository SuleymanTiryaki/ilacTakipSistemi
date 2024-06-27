import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled1/pillModel.dart';

class AddPillWidget extends StatefulWidget {
  final Function()? onTap;
  final TextEditingController textController;
  final TextEditingController textController2;
  final TextEditingController textController3;
  final ValueNotifier<String> dropdownvalue;
  final ValueNotifier<TimeOfDay> timeOfDayValue;
  final GlobalKey<FormState> formkey;

  const AddPillWidget(
      {super.key,
      this.onTap,
      required this.textController,
      required this.textController2,
      required this.textController3,
      required this.dropdownvalue,
      required this.timeOfDayValue,
      required this.formkey});

  @override
  State<AddPillWidget> createState() => _AddPillWidgetState();
}

class _AddPillWidgetState extends State<AddPillWidget> {
  final List<String> _items = [
    "ml",
    "mg",
    "hap",
  ];

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox(),
        );
      },
    ).then((value) {
      //setState(() {
      widget.timeOfDayValue.value = value!;
      // });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              maxLength: 15,
              controller: widget.textController,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  hintText: "İlacın adını giriniz",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: widget.textController.clear,
                    icon: const Icon(Icons.clear),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bu alan boş bırakılamaz';
                }
              },
            ),
      
            TextField(
                keyboardType: TextInputType.number,
                maxLength: 2,
                controller: widget.textController2,
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: "Günde kaç kere?",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: widget.textController2.clear,
                      icon: const Icon(Icons.clear),
                    ))),
            TextField(
                keyboardType: TextInputType.number,
                maxLength: 2,
                controller: widget.textController3,
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: "Kaç saatte bir?",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: widget.textController3.clear,
                      icon: const Icon(Icons.clear),
                    ))),
            //ilaç türü
            ValueListenableBuilder(
                valueListenable: widget.dropdownvalue,
                builder: (context, valueValue, _) {
                  return DropdownButton(
                      value: valueValue,
                      items: _items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        widget.dropdownvalue.value = newValue!;
                      });
                }),
      
            //BAŞLANGIÇ ZAMANI
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: _showTimePicker,
              child: Text(
                "Başlangıç Zamanı",
                style: TextStyle(fontSize: 15),
              ),
              color: (Colors.white),
            ),
            ValueListenableBuilder(
                valueListenable: widget.timeOfDayValue,
                builder: (context, timeValueValue, _) {
                  return Text(
                    timeValueValue.format(context).toString(),
                    style: TextStyle(fontSize: 15),
                  );
      
                  const SizedBox(
                    height: 13,
                  );
                }),
            //KAYDET BUTONU
            MaterialButton(
              onPressed: widget.onTap,
              child: Text(
                "Kaydet",
                style: TextStyle(fontSize: 15),
              ),
              color: (Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
