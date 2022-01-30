import 'package:flutter/material.dart';

void main() {
  runApp(BooksApp());
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}
class BooksApp extends StatefulWidget{
  const BooksApp({Key? key}) : super(key: key);


  State<StatefulWidget> createState()=> _BooksAppState();
}
class _BooksAppState extends State<BooksApp>{

  final BookRouterDelegate _routerDelegate = BookRouterDelegate();
  final BookRouteInformationParser _routeInformationParser = BookRouteInformationParser();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
        title: 'Books App',
        routeInformationParser: _routeInformationParser,
        routerDelegate: _routerDelegate);
  }
}
class BooksListScreen extends StatelessWidget{
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    required this.books,
    required this.onTapped
  });

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for(var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: ()=> onTapped(book),
            )
        ],
      ),
    );
  }

}
class BookDetailsScreen extends StatelessWidget{
  final Book book;

  BookDetailsScreen({
    required this.book
  });

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(book != null)
              ...[
                Text(book.title, style: Theme.of(context).textTheme.headline6,),
                Text(book.author, style: Theme.of(context).textTheme.subtitle1)
              ]
          ],
        ),
      ),
    );
  }
}
class BookRoutePath {
  final int? id;
  final bool isUnkown;

  BookRoutePath.home():
      id = null,
      isUnkown = false;

  BookRoutePath.details(this.id):
      isUnkown = false;

  BookRoutePath.unknown():
      id = null,
      isUnkown = true;

  bool get isHomePage => id == null;
  bool get isDetailsPage => id != null;
}
class BookRouteInformationParser extends RouteInformationParser<BookRoutePath>{

  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation
      ) async{
    final uri = Uri.parse(routeInformation.location!);

    if(uri.pathSegments.isEmpty){
      return BookRoutePath.home();
    }

    if(uri.pathSegments.length == 2){
      if(uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);

      if(id == null) return BookRoutePath.unknown();
      return BookRoutePath.details(id);
    }

    return BookRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath path){

    if(path.isHomePage){
      return RouteInformation(location: '/');
    }

    if(path.isDetailsPage){
      return RouteInformation(location: '/book/${path.id}');
    }

    return RouteInformation(location: '/404');
  }
}
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
  with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath>{

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  Book? _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ];

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  BookRoutePath get currentConfiguration {
    if(show404){
      return BookRoutePath.unknown();
    }else{
      return _selectedBook == null ?
          BookRoutePath.home():
          BookRoutePath.details(books.indexOf(_selectedBook!));
    }
  }

  @override
  Widget build(BuildContext context){
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result){
        if(!route.didPop(result)) {
           return false;
        }

        _selectedBook = null;
        show404 = false;
        notifyListeners();

        return true;
      },
      pages: [
        MaterialPage(
            child: BooksListScreen(
              books: books,
              onTapped: _handleBookTapped,
            ),
            key: const ValueKey('BooksListPage')
        ),
        if(show404)
          const MaterialPage(child: UnknownScreen(), key: ValueKey('UnknownPage'))
        else if(_selectedBook != null)
          MaterialPage(
              child: BookDetailsScreen(book: _selectedBook!)
          )
      ],

    );

  }

  void _handleBookTapped(Book book){
    _selectedBook = book;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async{
    if(path.isUnkown){
      _selectedBook = null;
      show404 = true;
      return;
    }

    if(path.isDetailsPage){
      if(path.id != null){
        if(path.id! < 0 || path.id! > books.length -1 ){
          show404 = true;
          return;
        }
        _selectedBook = books[path.id!];
      }
    }else{
      _selectedBook = null;
    }

    show404 = false;
  }
}
class UnknownScreen extends StatelessWidget{
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404 Not Found!'),
      ),
    );
  }
}


























