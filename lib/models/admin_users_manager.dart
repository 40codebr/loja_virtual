import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/models/user_model.dart';

class AdminUsersManager extends ChangeNotifier {

  List<UserModel> users = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  // Habilitar se usar o real-time
  // StreamSubscription _subscription;

  void updateUser(UserManager userManager) {
    // _subscription?.cancel(); // Habilitar se usar o real-time
    if(userManager.adminEnabled){
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(){
    // Real-time
    /*
    _subscription = firestore.collection('users').snapshots().listen((snapshot){
      users = snapshot.docs.map((d) => UserModel.fromDocument(d)).toList();
      users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      notifyListeners();
    });
    */
    firestore.collection('users').get().then((snapshot){
      users = snapshot.docs.map((d) => UserModel.fromDocument(d)).toList();
      users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();

  // Habilitar se usar o real-time
  /* @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  } */
}