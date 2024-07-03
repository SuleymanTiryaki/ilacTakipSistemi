import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Cubit.dart';
import 'package:untitled1/pillModel.dart';

class AddPillWidget extends StatefulWidget {
  final TextEditingController textController;
  final TextEditingController textController2;
  final TextEditingController textController3;
  
  final GlobalKey<FormState> formkey;

  const AddPillWidget(
      {super.key,
      required this.textController,
      required this.textController2,
      required this.textController3,

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
  String dropdownvalue = "ml";
  TimeOfDay timeOfDayValue = const TimeOfDay(hour: 8, minute: 30);

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
      setState(() {

      timeOfDayValue = value!;
      });
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
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bu alan boş bırakılamaz';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
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
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bu alan boş bırakılamaz';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
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
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bu alan boş bırakılamaz';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            // İlaç Türü Dropdown
            DropdownButtonFormField(
              value: dropdownvalue,
              items: _items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.grey.shade300,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Başlangıç Zamanı
            MaterialButton(
              onPressed: _showTimePicker,
              child: Text(
                "Başlangıç Zamanı: ${timeOfDayValue.format(context)}",
                style: TextStyle(fontSize: 15),
              ),
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 10),
            // Kaydet Butonu
            MaterialButton(
              
              onPressed: () {
                if (widget.formkey.currentState!.validate()) {
                  // Form doğrulandı, verileri işleyebilirsiniz
                  PillModel pillModel = PillModel(
                    pillName: widget.textController.text,
                    pariodOfDay: widget.textController2.text,
                    howManyHours: widget.textController3.text,
                    pillType: dropdownvalue,
                    startTime: timeOfDayValue,
                    
                  );

                  // Bloc üzerinden işlem yapılabilir
                  context.read<TextCubit>().addPillModel(pillModel);

                  // setState(() {
                  //   _pillModelList.add(pillModel);
                  // });

                  
                  // Formu sıfırla
                  // widget.formkey.currentState!.reset();
                }
              },
              child: Text(
                "Kaydet",
                style: TextStyle(fontSize: 15),
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
