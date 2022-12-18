import 'package:aceplus_codetest/widgets/full_screen_preloader.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UserDetail extends StatefulWidget {
  final int id;
  const UserDetail({super.key, required this.id});

  @override
  State<UserDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserDetail> {
  bool result = false;
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserDetailData(widget.id);
    } else {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserDetailDataOffline();
    }
    // generatedInitialValues();
    setState(() {
      _isPreloading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userDetailState, child) {
      // print("this is decoded form------> ${userDataState.decodedForm}");

      return _isPreloading
          ? const FullScreenPreloader()
          : Scaffold(
              appBar: AppBar(title: const Text("UserDetail")),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Name:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userDetailState.decodedDetailForm["name"],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userDetailState.decodedDetailForm["email"],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Address:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                """
                                ${userDetailState.decodedDetailForm["address"]["street"]}, 
                                ${userDetailState.decodedDetailForm["address"]["suite"]}, 
                                ${userDetailState.decodedDetailForm["address"]["city"]}, 
                                ${userDetailState.decodedDetailForm["address"]["zipcode"]} 
                                """,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Phone:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userDetailState.decodedDetailForm["phone"],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Website:",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userDetailState.decodedDetailForm["website"],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    });
  }
}
