// class BaseController {
//   Dialog showErrorDialog(BuildContext context, Exception error) {
//     if (error is BadRequestException) {
//       var message = error.prefix;
//     } else if (error is NoConnectionException) {
//       var message = error.message;
//     } else if (error is ApiNotRespondingException) {}
//
//     String title = "Error!";
//     String description = "Error!";
//
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title,
//             ),
//             Text(
//               description,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.pop();
//               },
//               child: const Text('Okay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
