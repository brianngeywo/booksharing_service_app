// import 'dart:math';
//
// import 'package:booksharing_service_app/client/notification_list_card.dart';
// import 'package:booksharing_service_app/constants.dart';
// import 'package:booksharing_service_app/models/notification.dart';
// import 'package:booksharing_service_app/static_datas.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
//
// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Notifications",
//           style: TextStyle(
//             color: textColor,
//           ),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await Future.delayed(const Duration(seconds: 2));
//           // Refresh the data here.
//           test_notifications = List.generate(
//             10,
//             (index) => NotificationClass(
//               id: const Uuid().v4(),
//               message: '${notification_book.title} borrow request',
//               time: DateTime.now(),
//               book: notification_book,
//               opened: Random().nextBool(),
//               requester: myCurrentUser,
//             ),
//           );
//         },
//         child: ListView(
//           children: test_notifications
//               .map((e) => NotificationListCard(notification: e))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
