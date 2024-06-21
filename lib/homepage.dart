import 'package:flutter/material.dart';
import 'package:untitled1/pillModel.dart';
import 'textfield.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final List<PillModel> pillModelList = [];
  ValueNotifier<String> value = ValueNotifier<String>("ml");
  ValueNotifier<TimeOfDay> timeOfDayValue =
      ValueNotifier<TimeOfDay>(const TimeOfDay(hour: 8, minute: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey.shade300,

            //title: Text("İlaç Takip Sistemi"),

            expandedHeight: 15,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: Colors.grey.shade500,
                  child: Column(
                    children: [
                      const SizedBox(height: 75),
                      Text(
                        "İ L A Ç  T A K İ P",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  )
                  //mainAxisAlignment: MainAxisAlignment.center,

                  ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 530,
                    color: Colors.grey.shade500,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: value,
                            builder: (context, String valueValue, _) {
                              return ValueListenableBuilder(
                                  valueListenable: timeOfDayValue,
                                  builder:
                                      (context, TimeOfDay timeValueValue, _) {
                                    return AddPillWidget(
                                      textController: _textController,
                                      textController2: _textController2,
                                      textController3: _textController3,
                                      dropdownvalue: value,
                                      timeOfDayValue: timeOfDayValue,
                                      onTap: () {
                                        PillModel pillModel = PillModel(
                                            pillName: _textController.text,
                                            pariodOfDay: _textController2.text,
                                            howManyHours: _textController3.text,
                                            pillType: valueValue,
                                            startTime: timeValueValue);
                                        // PillModel pillModel = PillModel(pillName2:_textController2.text);
                                        //PillModel pillModel = PillModel(pillName3:_textController3.text);
                                        print(_textController.text);
                                        print(_textController2.text);
                                        print(_textController3.text);
                                        print(valueValue);
                                        print(timeValueValue);

                                        setState(() {
                                          pillModelList.add(pillModel);
                                          // pillModelList.add(pillModel1);
                                          // pillModelList.add(pillModel2);
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            });

                                        //Navigator.of(context).pop();
                                      },
                                    );
                                  });
                            })
                      ],
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  color: Colors.grey.shade500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 14),
                      Text(
                        "Son Kaydedilenler",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: pillModelList.length,
                          itemBuilder: (context, index) {
                            PillModel pillModel = pillModelList[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "İlaç: ${pillModel.pillName ?? ''}",
                                ),
                                Text(
                                    "Günde kaç kere: ${pillModel.pariodOfDay ?? ''}"),
                                Text(
                                    "Kaç saatte bir: ${pillModel.howManyHours ?? ''}"),
                                Text("Türü: ${pillModel.pillType ?? ''}"),
                                Text("Başlangıç Zamanı: ${pillModel.startTime!.hour.toString() ?? ''} : ${pillModel.startTime!.minute.toString() ?? ''}"),
                                
                                const SizedBox(height: 14),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
