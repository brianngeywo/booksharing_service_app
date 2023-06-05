import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/notification.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';

class AcceptBorrowRequestDialog extends StatelessWidget {
  NotificationClass notification;
  AcceptBorrowRequestDialog({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        "Book Request",
        style: TextStyle(
          color: textColor,
        ),
      ),
      children: [
        my_divider,
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${notification.book.title} Borrow Request"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("From: ${notification.requester.name} "),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("On: ${formatter.format(notification.time)}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  test_allowed_users.add(notification.requester);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Request accepted!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                  for (var element in notification.book.allowedUsers) {
                    print(element.name);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookReadingPage(
                        book: notification.book,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Accept",
                  style: TextStyle(color: textColor),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  print(notification.requester.name);
                  test_allowed_users.remove(notification.requester);
                  for (var element in notification.book.allowedUsers) {
                    print(element.name);
                  }
                  Navigator.pop(context);
                },
                child: Text("Deny"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
