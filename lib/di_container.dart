import 'package:get_it/get_it.dart';
import 'package:howdy/features/auth/data/datasource/remote_data_source.dart';
import 'package:howdy/features/auth/data/repository/auth_repository_impl.dart';
import 'package:howdy/features/auth/domain/repositories/auth_repository.dart';
import 'package:howdy/features/auth/domain/usecases/login_use_case.dart';
import 'package:howdy/features/auth/domain/usecases/register_use_case.dart';
import 'package:howdy/features/chat/data/repository/message_repository_impl.dart';
import 'package:howdy/features/chat/domain/repositories/message_repository.dart';
import 'package:howdy/features/contact/data/repository/contact_repository_impl.dart';
import 'package:howdy/features/contact/domain/repositories/contact_repository.dart';
import 'package:howdy/features/conversation/data/datasource/conversation_remote_data_source.dart';
import 'package:howdy/features/conversation/data/repository/conversation_repository_impl.dart';
import 'package:howdy/features/conversation/domain/repositories/conversations_repository.dart';
import 'features/chat/data/datasource/messages_remote_data_source.dart';
import 'features/chat/domain/usecases/fetch_message_use_case.dart';
import 'features/contact/data/datasource/contact_remote_data_source.dart';
import 'features/contact/domain/usecases/add_contact_use_case.dart';
import 'features/contact/domain/usecases/fetch_contact_use_case.dart';
import 'features/contact/domain/usecases/fetch_recent_contact_use_case.dart';
import 'features/conversation/domain/usecases/check_or_create_conversation_use_case.dart';
import 'features/conversation/domain/usecases/fetch_conversation_use_case.dart';

final GetIt sl = GetIt.instance;

void setupDependencies(){
  const String baseUrl = "http://10.0.2.2:6000";

  //DataSource
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(baseUrl: baseUrl),);
  sl.registerLazySingleton<ConversationRemoteDataSource>(() => ConversationRemoteDataSource(baseUrl: baseUrl),);
  sl.registerLazySingleton<MessagesRemoteDataSource>(() => MessagesRemoteDataSource(baseUrl: baseUrl),);
  sl.registerLazySingleton<ContactRemoteDataSource>(() => ContactRemoteDataSource(baseUrl: baseUrl),);

  //Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()),);
  sl.registerLazySingleton<ConversationsRepository>(() => ConversationRepositoryImpl(remoteDataSource: sl()),);
  sl.registerLazySingleton<ContactRepository>(() => ContactRepositoryImpl(remoteDataSource: sl()),);
  sl.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(remoteDataSource: sl()),);

  //UseCases
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(repository: sl()),);
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()),);
  sl.registerLazySingleton<FetchConversationUseCase>(() => FetchConversationUseCase(repository: sl()),);
  sl.registerLazySingleton<FetchMessageUseCase>(() => FetchMessageUseCase(repository: sl()),);
  sl.registerLazySingleton<AddContactUseCase>(() => AddContactUseCase(repository: sl()),);
  sl.registerLazySingleton<FetchContactUseCase>(() => FetchContactUseCase(repository: sl()),);
  sl.registerLazySingleton<CheckOrCreateConversationUseCase>(() => CheckOrCreateConversationUseCase(repository: sl()),);
  sl.registerLazySingleton<FetchRecentContactUseCase>(() => FetchRecentContactUseCase(repository: sl()),);

}