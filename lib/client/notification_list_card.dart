import 'package:booksharing_service_app/client/accept_borrow_request_dialog.dart';
import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/notification.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:flutter/material.dart';

class NotificationListCard extends StatefulWidget {
  NotificationClass notification;
  NotificationListCard({Key? key, required this.notification})
      : super(key: key);

  @override
  State<NotificationListCard> createState() => _NotificationListCardState();
}

class _NotificationListCardState extends State<NotificationListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(7),
      color: widget.notification.opened
          ? Colors.grey.withOpacity(0)
          : Colors.grey.withOpacity(0.2),
      elevation: widget.notification.opened ? 0 : 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.notification.book.coverUrl),
        ),
        title: Text(
          widget.notification.message,
          style: TextStyle(color: textColor),
        ),
        subtitle: Text(formatter.format(widget.notification.time)),
        onTap: () {
          if (widget.notification.opened) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookReadingPage(
                  book: widget.notification.book,
                ),
              ),
            );
          } else {
            setState(() {
              widget.notification.opened = true;
            });
            showDialog(
              context: context,
              builder: (context) => AcceptBorrowRequestDialog(
                notification: widget.notification,
              ),
            );
          }
        },
      ),
    );
  }
}
