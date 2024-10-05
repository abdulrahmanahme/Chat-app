abstract class ChatState {}

class InitialChat extends ChatState {}

/// Chat states
class LoadingChatState extends ChatState {}

class ChatSuccessState extends ChatState {}

class ChatErrorState extends ChatState {}

/// Update Online Status
class OnlineStatusLoadingState extends ChatState {}

class OnlineStatusSuccessState extends ChatState {}

class OnlineStatusErrorState extends ChatState {}

/// IsUserTyping

class UserTypingLoadingState extends ChatState {}

class UserTypingSuccessState extends ChatState {}

class UserTypingErrorState extends ChatState {}

/// fetch all user

class GetAllUserLoadingState extends ChatState {}

class GetAllUserSuccessState extends ChatState {
  GetAllUserSuccessState(this.userDataList);
List<Map<String, dynamic>>userDataList;
}

class GetAllUserErrorState extends ChatState {
  GetAllUserErrorState(this.error);
  String error;

}
