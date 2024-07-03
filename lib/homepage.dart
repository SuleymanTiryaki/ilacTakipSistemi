import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:untitled1/data.dart';
import 'package:untitled1/pillModel.dart';
import 'package:untitled1/services.dart';
import 'Cubit.dart';
import 'addPillWidget.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final List<PillModel> pillModelList = [];
  String dropdownvalue = "ml";
  TimeOfDay timeOfDayValue = const TimeOfDay(hour: 8, minute: 30);
  // ValueNotifier<TimeOfDay> timeOfDayValue =
  //     ValueNotifier<TimeOfDay>(const TimeOfDay(hour: 8, minute: 30));
  final _formKey = GlobalKey<FormState>();

  final UserService _service = UserService();
  List<UsersModelData?> users = [];

  @override
  void initState() {
    super.initState();
    Logger().d("initState");
    _service.fetcUsers().then((UsersModel? value) {
      if (value is UsersModel) {
        Logger().d(value.toJson());
        setState(() {
          users = value.data ?? [];
        });

        // users.add(value as UsersModelData);
      }
      // if (value != null! && value.data != null)
      //   setState(() {
      //     users.value.data!;
      //   });
      // else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TextCubit(_textController, _textController2, _textController3),
        child: BlocConsumer<TextCubit, CubitState>(listener: (context, state) {
          // showDialog(
          //             context: context,
          //             builder: (context) {
          //               return AlertDialog(
          //                 title: Text('Başarılı'),
          //                 content: Text('İlaç başarıyla eklendi!'),
          //                 actions: [
          //                   TextButton(
          //                     onPressed: () {
          //                       Navigator.pop(context);
          //                     },
          //                     child: Text('Tamam'),
          //                   ),
          //                 ],
          //               );
          //             },
          //           );
        }, builder: (context, state) {
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
                            height: 560,
                            color: Colors.grey.shade500,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                AddPillWidget(
                                  textController: _textController,
                                  textController2: _textController2,
                                  textController3: _textController3,
                                  //dropdownvalue: value,
                                  //timeOfDayValue: timeOfDayValue,
                                  formkey: _formKey,
                                  // onTap: () {
                                  //   if (_formKey.currentState!
                                  //       .validate()) {
                                  //     PillModel pillModel = PillModel(
                                  //         pillName:
                                  //             _textController.text,
                                  //         pariodOfDay:
                                  //             _textController2.text,
                                  //         howManyHours:
                                  //             _textController3.text,
                                  //         pillType: valueValue,
                                  //         startTime: timeValueValue);

                                  //     print(_textController.text);
                                  //     print(_textController2.text);
                                  //     print(_textController3.text);
                                  //     print(valueValue);
                                  //     print(timeValueValue);

                                  //     setState(() {
                                  //       pillModelList.add(pillModel);
                                  //       // pillModelList.add(pillModel1);
                                  //       // pillModelList.add(pillModel2);
                                  //     });
                                  //     showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return Center(
                                  //             child:
                                  //                 CircularProgressIndicator(),
                                  //           );
                                  //         });

                                  //     //Navigator.of(context).pop();
                                  //   }
                                  // },
                                ),
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
                          height: 415,
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
                                  shrinkWrap: true,
                                  itemCount: (state.pillModelList ?? []).length,
                                  itemBuilder: (context, index) {
                                    PillModel pillModel =
                                        state.pillModelList![index];
                                    Logger().d("listview $pillModel");
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "İlaç: ${pillModel.pillName ?? ''}",
                                        ),
                                        Text(
                                            "Günde kaç kere: ${pillModel.pariodOfDay ?? ''}"),
                                        Text(
                                            "Kaç saatte bir: ${pillModel.howManyHours ?? ''}"),
                                        Text(
                                            "Türü: ${pillModel.pillType ?? ''}"),
                                        Text(
                                            "Başlangıç Zamanı: ${pillModel.startTime!.hour.toString() ?? ''} : ${pillModel.startTime!.minute.toString() ?? ''}"),
                                        const SizedBox(height: 14),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              //  APİLERİN LİSTELENME KODU
                              // Expanded(
                              //   child: ListView.builder(
                              //     itemCount: users.length,
                              //     itemBuilder: (context, index) {
                              //       return Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           ListTile(
                              //             title: Text(
                              //                 " ${users[index]!.firstName} "),
                              //             subtitle:
                              //                 Text("${users[index]!.email!}"),
                              //             leading: CircleAvatar(
                              //               backgroundImage: NetworkImage(
                              //                   "${users[index]!.avatar!}"),
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        }));
  }
}
