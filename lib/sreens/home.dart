import 'package:aceplus_codetest/provider/user_provider.dart';
import 'package:aceplus_codetest/sreens/detail.dart';
import 'package:aceplus_codetest/widgets/full_screen_preloader.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool result = false;
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      await Provider.of<UserProvider>(context, listen: false).getUserData();
    } else {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserDataOffline();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userDataState, child) {
          // print("this is decoded form------> ${userDataState.decodedForm}");

          return _isPreloading
              ? const FullScreenPreloader()
              : ListView.builder(
                  itemCount: userDataState.decodedForm.length,
                  itemBuilder: (context, index) {
                    // print(index);
                    return Card(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserDetail(
                                  id: userDataState.decodedForm[index]["id"],
                                ),
                              ),
                            );
                          },
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(userDataState.decodedForm[index]["name"]),
                          subtitle:
                              Text(userDataState.decodedForm[index]["email"]),
                          trailing: const Icon(Icons.arrow_right_rounded),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
