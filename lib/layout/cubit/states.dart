import 'package:socialapp/models/post_model.dart';

class HomeLayoutStates {}

//Initial State
class HomeLayoutIntialState extends HomeLayoutStates {}

//Bottom Navigation
class HomeChangeBottomNavState extends HomeLayoutStates {}

//GetUserStates
class SocialGetUserLoadingState extends HomeLayoutStates {}

class SocialGetUserSucessState extends HomeLayoutStates {}

class SocialGetUserErrorState extends HomeLayoutStates {}

//GetAllUsersStates
class SocialGetAllUsersLoadingState extends HomeLayoutStates {}

class SocialGetAllUsersSuccessState extends HomeLayoutStates {}

class SocialGetAllUsersErrorState extends HomeLayoutStates {}

//New Post
class SocialNewPostAtate extends HomeLayoutStates {}

//PickedProfileImage

class SocialProfileImagePickedSuccesState extends HomeLayoutIntialState {}

class SocialProfileImagePickedErrorState extends HomeLayoutIntialState {}

//PickedcoverImage

class SocialCoverImagePickedSuccesState extends HomeLayoutIntialState {}

class SocialCoverImagePickedErrorState extends HomeLayoutIntialState {}

//UploadProfileImage

class SocialUploadProfileImageSuccessState extends HomeLayoutIntialState {}

class SocialUploadProfileImageErrorState extends HomeLayoutIntialState {}

//UploadCoverImage

class SocialUploadCoveImageSuccessState extends HomeLayoutIntialState {}

class SocialUploadCoveImageErrorState extends HomeLayoutIntialState {}

//updateUserData

class SocialUpdateUserDataLoadingState extends HomeLayoutIntialState {}

// class SocialUpdateUserDataSuccessState extends HomeLayoutIntialState {}

class SocialUpdateUserDataErrorState extends HomeLayoutIntialState {}

//pickedPostImage
class SocialPickedPostImageSuccessState extends HomeLayoutStates {}

class SocialPickedPostImageErrorState extends HomeLayoutStates {}

//crate new post
class SocialCreateNewPostLoadingState extends HomeLayoutIntialState {}

class SocialCreateNewPostSuccessState extends HomeLayoutIntialState {}

class SocialCreateNewPostErrorState extends HomeLayoutIntialState {}

//Uplaod new postImage

class SocialUploadNewPostImageLoadingState extends HomeLayoutIntialState {}

class SocialUploadNewPostImageSuccessState extends HomeLayoutIntialState {}

class SocialUploadNewPostImageErrorState extends HomeLayoutIntialState {}

class SocialDeletePostImageState extends HomeLayoutStates {}

//Get Posts

class SocialGetPostsSuccessState extends HomeLayoutIntialState {
  List<PostModel> posts;
  SocialGetPostsSuccessState({required this.posts});
}

class SocialGetPostsLoadingState extends HomeLayoutIntialState {}

class SocialGetPostsErrorState extends HomeLayoutIntialState {}

//Like Post

class ChangeLikeState extends HomeLayoutIntialState {} 
class LikePostSuccessState extends HomeLayoutIntialState {}

class LikePostErrorState extends HomeLayoutIntialState {}


