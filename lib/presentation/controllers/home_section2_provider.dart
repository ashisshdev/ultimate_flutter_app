import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ultimate_flutter_app/domain/repositories/some_api_service_repository.dart';

// ignore_for_file: avoid_print

class HomeSection2Controller extends ChangeNotifier {
  final SomeRepositoryImpl someRepositoryImpl;
  HomeSection2Controller({required this.someRepositoryImpl});

  /// get methods
  getSuccessFunction1(BuildContext context) async {
    print("\nrunning success get method 1");
    var response = await someRepositoryImpl.getSuccess1();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  getSuccessFunction2(BuildContext context) async {
    print("\nrunning success get method 2");
    var response = await someRepositoryImpl.getSuccess2();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  getFailureFunction1(BuildContext context) async {
    print("\nrunning failure get method 1");
    var response = await someRepositoryImpl.getFailure1();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  getFailureFunction2(BuildContext context) async {
    print("\nrunning failure get method 2");
    var response = await someRepositoryImpl.getFailure2();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      // print(jsonDecode(r.request!.url.toString()));
      print(jsonDecode(r.body));
    });
  }

  getFailureFunction3(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.getFailure3();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  /// post methods
  postSuccessFunction1(BuildContext context) async {
    print("\nrunning success post method 1");
    var response = await someRepositoryImpl.postSuccess1();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  postSuccessFunction2(BuildContext context) async {
    print("\nrunning success get method 2");
    var response = await someRepositoryImpl.postSuccess2();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  postFailureFunction1(BuildContext context) async {
    print("\nrunning failure get method 1");
    var response = await someRepositoryImpl.postFailure1();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  postFailureFunction2(BuildContext context) async {
    print("\nrunning failure get method 2");
    var response = await someRepositoryImpl.postFailure2();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.request!.url.toString()));
      print(jsonDecode(r.body));
    });
  }

  postFailureFunction3(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.postFailure3();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  /// update methods
  updateSuccessFunction1(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.updateSuccess();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  updateFailureFunction1(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.updateFailure1();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.request!.url.toString()));
      print(jsonDecode(r.body));
    });
  }

  updateFailureFunction2(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.updateFailure2();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.request!.url.toString()));

      print(jsonDecode(r.body));
    });
  }

  /// delete methods
  deleteSuccess(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.deleteSuccess();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }

  deleteFailure(BuildContext context) async {
    print("\nrunning failure get method 3");
    var response = await someRepositoryImpl.deleteFailure();
    response.fold((l) {
      print("\nyeah exception");
      handleError(l);
    }, (r) {
      print("\nyeah success");
      print(jsonDecode(r.body));
    });
  }
}

handleError(error) {
  print("Unknown exception     -    ");
  print(error.message);
  print(error.prefix);
  print(error.url);

  // if (error is BadRequestException) {
  //   var message = error.message;
  //   DialogHelper.showErroDialog(description: message);
  // } else if (error is FetchDataException) {
  //   var message = error.message;
  //   DialogHelper.showErroDialog(description: message);
  // } else if (error is ApiNotRespondingException) {
  //   DialogHelper.showErroDialog(
  //       description: 'Oops! It took longer to respond.');
  // }
}

enum ControllerStatus { initial, loading, success, error }
