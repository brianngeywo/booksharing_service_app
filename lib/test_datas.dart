import 'dart:math';

import 'package:booksharing_service_app/models/Navigation_item.dart';
import 'package:booksharing_service_app/models/blog.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/book_club.dart';
import 'package:booksharing_service_app/models/comment.dart';
import 'package:booksharing_service_app/models/discussion_post.dart';
import 'package:booksharing_service_app/client/forum_question_comment.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/models/notification.dart';
import 'package:booksharing_service_app/models/question.dart';
import 'package:booksharing_service_app/models/rating.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// Create an instance of the DateFormat class
DateFormat formatter = DateFormat('yMMMd');
Random random = Random();
List<UserModel> test_users = [
  UserModel(
      id: '0',
      name: 'James',
      email: '0@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
  UserModel(
      id: '1',
      name: 'Brian',
      email: '1@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
  UserModel(
      id: '2',
      name: 'John',
      email: '2@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
  UserModel(
      id: '3',
      name: 'Levi',
      email: '3@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
  UserModel(
      id: '4',
      name: 'Mercy',
      email: '4@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
  UserModel(
      id: '5',
      name: 'Cheche',
      email: '5@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
];
List<UserModel> test_allowed_users = [
  UserModel(
      id: '0',
      name: 'James',
      email: '0@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
  UserModel(
      id: '1',
      name: 'Brian',
      email: '1@email.com',
      isAdmin: false,
      address: '',
      phoneNumber: ''),
];
UserModel myCurrentUser = test_users[3];

String getRandomId() {
  // Generate a random 6-character alphanumeric ID
  const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  String id = '';
  for (int i = 0; i < 6; i++) {
    id += chars[random.nextInt(chars.length)];
  }
  return id;
}

List<Book> test_books = [
  Book(
    id: getRandomId(),
    title: "Book one",
    author: "Author one",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description one",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
  Book(
    id: const Uuid().v4(),
    title: "Book 2",
    author: "Author 2",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description 2",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
  Book(
    id: const Uuid().v4(),
    title: "Book 3",
    author: "Author 3",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description 3",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
  Book(
    id: const Uuid().v4(),
    title: "Book 4",
    author: "Author 4",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description 4",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
  Book(
    id: const Uuid().v4(),
    title: "Book 5",
    author: "Author 5",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description 5",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
  Book(
    id: const Uuid().v4(),
    title: "Book 6",
    author: "Author 6",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description 6",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
  Book(
    id: const Uuid().v4(),
    title: "Book 7",
    author: "Author 7",
    genre: test_genres[Random().nextInt(test_genres.length)],
    description: "Description 7",
    coverUrl:
        "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80",
    postedBy: test_users[Random().nextInt(test_users.length)],
    ratings: test_ratings,
    allowedUsers: test_allowed_users,
  ),
];
List<BookClub> test_book_clubs = [
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[0],
    description: "This is a book club for ${test_genres[0].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[0].name} book club",
  ),
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[1],
    description: "This is a book club for ${test_genres[1].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[1].name} book club",
  ),
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[2],
    description: "This is a book club for ${test_genres[2].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[2].name} book club",
  ),
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[3],
    description: "This is a book club for ${test_genres[3].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[3].name} book club",
  ),
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[4],
    description: "This is a book club for ${test_genres[4].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[4].name} book club",
  ),
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[5],
    description: "This is a book club for ${test_genres[5].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[5].name} book club",
  ),
  BookClub(
    id: const Uuid().v4(),
    genre: test_genres[6],
    description: "This is a book club for ${test_genres[6].name} books.",
    members: [test_users[Random().nextInt(test_users.length)]],
    name: "${test_genres[6].name} book club",
  ),
];
// Create a list of genres in your app's state
List<Genre> test_genres = [
  Genre(
    id: "1",
    name: "Science Fiction",
    image_url:
        'https://images.unsplash.com/photo-1579566346927-c68383817a25?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  Genre(
    id: "2",
    name: "Romance",
    image_url:
        'https://images.unsplash.com/photo-1521033719794-41049d18b8d4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Um9tYW5jZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "3",
    name: "Mystery",
    image_url:
        'https://images.unsplash.com/photo-1611673982501-93cabee16c77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fEZpY3Rpb258ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "4",
    name: "Fantasy",
    image_url:
        'https://images.unsplash.com/photo-1560942485-b2a11cc13456?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
  ),
  Genre(
    id: "5",
    name: "Fiction",
    image_url:
        'https://images.unsplash.com/photo-1624027492684-327af1fb7559?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fEZpY3Rpb258ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "6",
    name: "Horror",
    image_url:
        'https://images.unsplash.com/photo-1601513445506-2ab0d4fb4229?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8SG9ycm9yfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "7",
    name: "Biography",
    image_url:
        'https://images.unsplash.com/photo-1601921004897-b7d582836990?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFoYXRtYSUyMGdhbmRoaXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "8",
    name: "Classic",
    image_url:
        'https://images.unsplash.com/photo-1580974582391-a6649c82a85f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmludGFnZSUyMGRyZXNzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  ),
];

List<Blog> test_blog_posts = [
  Blog(
    id: 0,
    title: '5 Tips for Reading More Books',
    author: 'Jane Smith',
    date: DateTime.now(),
    content:
        'In today\'s busy world, it can be hard to find time to read. But reading is a great way to relax and expand your mind. Here are 5 tips for reading more books:\n\n1. Set a goal for how many books you want to read each month.\n\n2. Make reading a part of your daily routine.\n\n3. Keep a book with you at all times.\n\n4. Join a book club.\n\n5. Try reading books in different genres.',
    comments: test_comments,
  ),
  Blog(
    id: 1,
    title: 'The Power of Reading Books',
    author: 'Jane Doe',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod lacus vel nisl dictum, sed eleifend turpis pulvinar. Aliquam erat volutpat. Vivamus vel finibus tellus, et viverra quam. Sed vel lobortis lorem. Donec euismod orci sit amet erat ullamcorper commodo. Mauris venenatis enim sed massa molestie, id gravida nisi bibendum. Morbi pulvinar sapien et arcu suscipit ullamcorper. Praesent imperdiet felis vel efficitur venenatis.',
    date: DateTime(2022, 3, 12),
    comments: [],
  ),
  Blog(
    id: 2,
    title: 'The Importance of Book Clubs',
    author: 'John Smith',
    content:
        'Integer eleifend tellus at suscipit ultricies. Nam eu fringilla eros, ac posuere ipsum. Proin bibendum erat sit amet est placerat tincidunt. Duis eget quam eget metus fringilla laoreet. Nunc euismod faucibus ultrices. Duis rutrum nunc eget massa consequat, nec consequat dolor efficitur. Nam mollis, augue non finibus tincidunt, metus arcu aliquet ante, at pulvinar quam urna ac nulla. Vivamus a consectetur turpis.',
    date: DateTime(2022, 5, 20),
    comments: test_comments,
  ),
  Blog(
    id: 3,
    title: 'How to Write a Book Review',
    author: 'Emily Davis',
    content:
        'Pellentesque ut sagittis quam. Etiam suscipit purus ac quam interdum, vel dignissim nisi lacinia. Nunc feugiat leo sed sapien euismod fringilla. Donec malesuada vestibulum dui, ac consequat arcu posuere a. Sed hendrerit, purus nec rutrum pretium, dolor mi bibendum dolor, in euismod odio est sit amet ante. Nullam sit amet consectetur tortor. Suspendisse varius luctus nisl vitae aliquam. Sed in quam nec metus dignissim pretium. Quisque at elit eget elit laoreet rhoncus. ',
    date: DateTime(2022, 7, 8),
    comments: test_comments,
  ),
  Blog(
    id: 4,
    title: "The Art of Writing: Tips and Tricks from a Bestselling Author",
    author: " Sarah Lee",
    content:
        """In this blog post, Sarah Lee shares some of her best tips for aspiring writers. 
      She discusses the importance of finding your own voice, developing a writing routine, and 
      editing your work ruthlessly. She also shares some of the challenges 
      she's faced as a writer and how she's overcome them.""",
    date: DateTime(2022, 4, 1),
    comments: [],
  ),
  Blog(
    id: 5,
    title:
        "The Benefits of Reading for Children: How Books Can Boost Development",
    author: "Michael Johnson",
    content:
        """Michael Johnson explores the many ways in which reading can benefit children. He discusses how books can help with language development, cognitive skills, and emotional intelligence. He also offers tips for parents who want to encourage their children to read more, such as setting aside dedicated reading time and making sure there are plenty of age-appropriate books available.""",
    date: DateTime(2022, 3, 15),
    comments: [],
  ),
  Blog(
    id: 6,
    title: "Traveling Through Books: How Literature Can Take You on a Journey",
    author: "Emily Chen",
    content:
        """In this blog post, Emily Chen explores the ways in which books can transport us to different times and places. She discusses how reading can provide a sense of escapism, broaden our horizons, and help us understand other cultures. She also shares some of her favorite books that have taken her on unforgettable journeys.""",
    date: DateTime(2021, 12, 25),
    comments: [],
  )
];

List<DiscussionPost> test_discussion_posts = [
  DiscussionPost(
    id: const Uuid().v4(),
    title: 'Review: To Kill a Mockingbird',
    author: test_users[Random().nextInt(test_users.length)],
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in urna ultricies, lacinia enim vel, venenatis quam. Aliquam eget risus ac risus dignissim pellentesque. Fusce nec suscipit arcu, ut maximus tellus. Nulla facilisi. Nullam molestie lacus risus, in hendrerit felis mollis ut. Sed venenatis risus vel sapien aliquam, nec lobortis lorem maximus.',
    date: DateTime.now(),
    comments: [],
  ),
  DiscussionPost(
    id: const Uuid().v4(),
    title: 'Character Analysis: Holden Caulfield',
    author: test_users[Random().nextInt(test_users.length)],
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in urna ultricies, lacinia enim vel, venenatis quam. Aliquam eget risus ac risus dignissim pellentesque. Fusce nec suscipit arcu, ut maximus tellus. Nulla facilisi. Nullam molestie lacus risus, in hendrerit felis mollis ut. Sed venenatis risus vel sapien aliquam, nec lobortis lorem maximus.',
    date: DateTime.now(),
    comments: [],
  ),
  DiscussionPost(
    id: const Uuid().v4(),
    title: 'Book Recommendation: The Great Gatsby',
    author: test_users[Random().nextInt(test_users.length)],
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in urna ultricies, lacinia enim vel, venenatis quam. Aliquam eget risus ac risus dignissim pellentesque. Fusce nec suscipit arcu, ut maximus tellus. Nulla facilisi. Nullam molestie lacus risus, in hendrerit felis mollis ut. Sed venenatis risus vel sapien aliquam, nec lobortis lorem maximus.',
    date: DateTime.now(),
    comments: [],
  ),
  DiscussionPost(
    id: const Uuid().v4(),
    title: 'Plot Analysis: The Catcher in the Rye',
    author: test_users[Random().nextInt(test_users.length)],
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in urna ultricies, lacinia enim vel, venenatis quam. Aliquam eget risus ac risus dignissim pellentesque. Fusce nec suscipit arcu, ut maximus tellus. Nulla facilisi. Nullam molestie lacus risus, in hendrerit felis mollis ut. Sed venenatis risus vel sapien aliquam, nec lobortis lorem maximus.',
    date: DateTime.now(),
    comments: test_comments,
  ),
  DiscussionPost(
    id: const Uuid().v4(),
    title: 'Book Recommendation: The Road',
    author: test_users[Random().nextInt(test_users.length)],
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in urna ultricies, lacinia enim vel, venenatis quam. Aliquam eget risus ac risus dignissim pellentesque. Fusce nec suscipit arcu, ut maximus tellus. Nulla facilisi. Nullam molestie lacus risus, in hendrerit felis mollis ut. Sed venenatis risus vel sapien aliquam, nec lobortis lorem maximus.',
    date: DateTime.now(),
    comments: test_comments,
  ),
  DiscussionPost(
    id: const Uuid().v4(),
    title: 'Book Review: The Nightingale by Kristin Hannah',
    author: test_users[Random().nextInt(test_users.length)],
    content:
        'I just finished reading The Nightingale by Kristin Hannah and it was amazing! The story is set in France during World War II and follows the lives of two sisters, Vianne and Isabelle, who are living under Nazi occupation. The writing is beautiful and the characters are so well-developed that I felt like I knew them personally. I highly recommend this book to anyone who enjoys historical fiction or just wants to read a great story.',
    date: DateTime(2022, 4, 15),
    comments: [],
  ),
];

List<Comment> test_comments = [
  Comment(
    id: '1',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'This is a great book!',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '2',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'I couldn\'t put this book down!',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '3',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'The characters in this book are so relatable.',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '4',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'I loved the plot twists in this book.',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '5',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'This book was a real page-turner!',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '6',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'I couldn\'t stop thinking about this book after I finished it.',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '7',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'The writing style in this book is beautiful.',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
  Comment(
    id: '8',
    author: test_users[Random().nextInt(test_users.length)],
    content: 'I recommend this book to everyone!',
    date: DateTime.now(),
    book: test_books[Random().nextInt(test_books.length)],
  ),
];

List<Rating> test_ratings = [
  Rating(
    stars: random.nextInt(5) + 1,
    comment: test_comments[random.nextInt(test_comments.length)],
    user: test_users[random.nextInt(test_users.length)],
  ),
  Rating(
    stars: random.nextInt(5) + 1,
    comment: test_comments[random.nextInt(test_comments.length)],
    user: test_users[random.nextInt(test_users.length)],
  ),
  Rating(
    stars: random.nextInt(5) + 1,
    comment: test_comments[random.nextInt(test_comments.length)],
    user: test_users[random.nextInt(test_users.length)],
  ),
  Rating(
    stars: random.nextInt(5) + 1,
    comment: test_comments[random.nextInt(test_comments.length)],
    user: test_users[random.nextInt(test_users.length)],
  ),
  Rating(
    stars: random.nextInt(5) + 1,
    comment: test_comments[random.nextInt(test_comments.length)],
    user: test_users[random.nextInt(test_users.length)],
  ),
];

// Example usage:

Book notification_book = test_books[Random().nextInt(test_books.length)];
List<NotificationClass> test_notifications = List.generate(
  test_books.length,
  (index) => NotificationClass(
    id: const Uuid().v4(),
    message: '${test_books[index].title} borrow request',
    time: DateTime.now(),
    book: test_books[index],
    opened: Random().nextBool(),
    requester: myCurrentUser,
  ),
);
List<Question> test_questions = [
  Question(
    id: '1',
    title: 'What are some good fantasy book series?',
    body:
        'I\'m a big fan of fantasy books and I\'m looking for some good series to read. Any recommendations?',
    attachedBook: Book(
      id: '1',
      title: 'The Name of the Wind',
      author: 'Patrick Rothfuss',
      genre: test_genres[Random().nextInt(test_genres.length)],
      postedBy: test_users[1],
      ratings: test_ratings,
      description:
          'The Name of the Wind is a fantasy novel by Patrick Rothfuss. It is the first book in the Kingkiller Chronicle series, followed by The Wise Man\'s Fear. The story is narrated from the third person, but mostly consists of Kvothe\'s recollections of his past.',
      allowedUsers: test_allowed_users,
      coverUrl: "",
    ),
    postedBy: test_users[0],
    upvotes: [],
    downvotes: [],
    timeUploaded: DateTime.now(),
  ),
  Question(
    id: '2',
    title: 'What is the best science fiction book of all time?',
    body:
        'I\'m a huge fan of science fiction and I want to know what the best science fiction book of all time is. What do you think?',
    attachedBook: Book(
      id: '2',
      title: 'Ender\'s Game',
      author: 'Orson Scott Card',
      genre: test_genres[Random().nextInt(test_genres.length)],
      postedBy: test_users[2],
      ratings: test_ratings,
      description:
          'Ender\'s Game is a military science fiction novel by American author Orson Scott Card. Set in Earth\'s future, the novel presents an imperiled humankind after two conflicts with the Formics, an insectoid alien species they dub the "buggers".',
      coverUrl: '',
      allowedUsers: test_allowed_users,
    ),
    postedBy: test_users[1],
    upvotes: [],
    downvotes: [],
    timeUploaded: DateTime.now(),
  ),
  Question(
    id: '3',
    title: 'Can you recommend a good self-help book?',
    body:
        'I\'m looking for a good self-help book to help me with time management and productivity. Any suggestions?',
    attachedBook: Book(
        id: '3',
        title: 'The 7 Habits of Highly Effective People',
        author: 'Stephen Covey',
        genre: test_genres[Random().nextInt(test_genres.length)],
        postedBy: test_users[3],
        ratings: test_ratings,
        description:
            'The 7 Habits of Highly Effective People is a self-help book written by Stephen Covey. It presents an approach to being effective in attaining goals by aligning oneself to what Covey calls "true north" principles based on a character ethic that he presents as universal and timeless.',
        coverUrl: '',
        allowedUsers: []),
    postedBy: test_users[2],
    upvotes: [],
    downvotes: test_allowed_users,
    timeUploaded: DateTime.now(),
  ),
];
List<ForumQuestionComment> forum_comments = [
  ForumQuestionComment(
    id: '1',
    comment:
        'I recommend the book "Atomic Habits" by James Clear. It\'s a great book on building good habits and breaking bad ones.',
    postedBy: test_users[1],
    upvotes: [],
    downvotes: [],
  ),
  ForumQuestionComment(
    id: '2',
    comment:
        'I\'ve heard good things about "The Power of Habit" by Charles Duhigg. Might be worth checking out!',
    postedBy: test_users[2],
    upvotes: [],
    downvotes: [],
  ),
];
List<NavigationItem> menuItems = [
  NavigationItem(
    icon: Icons.person,
    title: 'UserModel Management',
    page: 'UserModel Management Page',
  ),
  NavigationItem(
    icon: Icons.book,
    title: 'Book Management',
    page: 'Book Management Page',
  ),
  NavigationItem(
    icon: Icons.group,
    title: 'Book Clubs',
    page: 'Book Clubs Page',
  ),
  NavigationItem(
    icon: Icons.forum,
    title: 'Forums',
    page: 'Forums Page',
  ),
];
List<Map<String, dynamic>> userManagementActions = [
  {
    'icon': Icons.list,
    'label': 'UserModel List',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.person,
    'label': 'User Details',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.security,
    'label': 'User Roles and Permissions',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.search,
    'label': 'UserModel Search',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.toggle_on,
    'label': 'UserModel Activation/Deactivation',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.edit,
    'label': 'UserModel Profile Editing',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.analytics,
    'label': 'UserModel Statistics and Analytics',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.report,
    'label': 'UserModel Reporting',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.history,
    'label': 'UserModel Actions Log',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
];

List<Map<String, dynamic>> bookManagementActions = [
  {
    'icon': Icons.list,
    'label': 'View Book List',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.add,
    'label': 'Add New Book',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.edit,
    'label': 'Edit Book Details',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.delete,
    'label': 'Delete Book',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.search,
    'label': 'Search Books',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.category,
    'label': 'Book Categories',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.star,
    'label': 'Book Reviews',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.request_page,
    'label': 'Book Requests',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.pie_chart,
    'label': 'Book Statistics',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
  {
    'icon': Icons.import_export,
    'label': 'Import/Export Books',
    'onTap': () {
      // Implement navigation or action logic here
    },
  },
];

List<Map<String, dynamic>> adminBookClubsActions =
    generateRandomBookClubsNamesAndIcon();
List<Map<String, dynamic>> generateRandomBookClubsNamesAndIcon() {
  List<Map<String, dynamic>> bookClubs = [];

  for (int i = 0; i < test_genres.length; i++) {
    bookClubs.add({
      'label': "${test_genres[i].name} book club",
      'icon': Icons.book,
    });
  }
  return bookClubs;
}

List<Map<String, dynamic>> test_admin_forum_questions_actions =
    generateAdminForumQuestions();
List<Map<String, dynamic>> generateAdminForumQuestions() {
  List<Map<String, dynamic>> forumQuestions = [];
  for (int i = 0; i < test_questions.length; i++) {
    forumQuestions.add({
      'label': test_questions[i].title,
      'icon': Icons.forum,
    });
  }
  return forumQuestions;
}
