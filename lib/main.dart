import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/core/socket_service.dart';
import 'package:howdy/core/theme.dart';
import 'package:howdy/di_container.dart';
import 'package:howdy/features/auth/application/bloc/auth_bloc.dart';
import 'package:howdy/features/chat/application/bloc/message_bloc.dart';
import 'package:howdy/features/contact/application/bloc/contact_bloc.dart';
import 'package:howdy/features/contact/presentation/pages/contact_page.dart';
import 'package:howdy/features/auth/presensation/pages/login.dart';
import 'package:howdy/features/conversation/application/bloc/conversation_bloc.dart';
import 'package:howdy/features/conversation/presentation/pages/conversations_page.dart';
import 'package:howdy/features/auth/presensation/pages/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SocketService socketService = SocketService();
  await socketService.initSocketService();
  //SetUp Get Id
  setupDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(sl(), sl())),
        BlocProvider(
          create: (context) => ConversationBloc(fetchConversationUseCase: sl()),
        ),
        BlocProvider(
          create: (context) => MessageBloc(fetchMessageUseCase: sl()),
        ),
        BlocProvider(
          create:
              (context) => ContactBloc(
                addContactUseCase: sl(),
                fetchContactUseCase: sl(),
                checkOrCreateConversationUseCase: sl(),
                fetchRecentContactUseCase: sl(),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (BuildContext context) => Login(),
          '/register': (BuildContext context) => Register(),
          '/home': (BuildContext context) => ConversationsPage(),
          '/contact': (BuildContext context) => ContactPage(),
        },
        home: Register(),
      ),
    );
  }
}
