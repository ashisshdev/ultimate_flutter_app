import 'package:flutter/material.dart';
import 'package:ultimate_flutter_app/domain/repositories/some_api_service_repository.dart';

class HomeSection2Controller extends ChangeNotifier {
  final SomeRepositoryImpl _someRepositoryImpl;
  HomeSection2Controller(this._someRepositoryImpl);

  successFunction1() {}
}

enum ControllerStatus { initial, loading, success, error }

// class StatusBuilder extends StatelessWidget {
//   const StatusBuilder({Key? key}) : super(key: key);
//
//   final ControllerStatus _controllerStatus;
//   final Widget success;
//
//   @override
//   Widget build(BuildContext context) {
//     if(_controllerStatus == ControllerStatus.initial){
//       return Center(child: TextButton(child: Text("Load data"),onPressed: (){
//         /// trigger fetch data function in controller
//       },),);
//     }else if(_controllerStatus == ControllerStatus.success){
//       return
//     } else if(_controllerStatus == ControllerStatus.success){
//       return
//     } else {
//       return const CircularProgressIndicator();
//     }
//   }
// }
