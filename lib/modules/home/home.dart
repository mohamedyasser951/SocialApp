import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/comment_page/comment_page.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var refreshController1 = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
     

      return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = HomeLayoutCubit.get(context);
          var posts = HomeLayoutCubit.get(context).posts;

          return ConditionalBuilder(
              condition: posts.length>0 && cubit.userModel !=null,
              builder: (context) {
                return SmartRefresher(
                  controller: refreshController1,
                  physics: const BouncingScrollPhysics(),
                  onRefresh: () => _onRefresh(context),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(8.0),
                          elevation: 5.0,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              const Image(
                                  height: 200,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  image: NetworkImage(
                                      "https://img.freepik.com/free-photo/positive-european-male-model-points-right-with-both-index-fingers-suggets-try-use-product-turns-aside_273609-38445.jpg?size=626&ext=jpg")),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Communicate with Friends",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.posts.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8.0,
                          ),
                          itemBuilder: (context, index) =>
                              buildPostItem(index, cubit.posts[index], context),
                        ),
                        SizedBox(
                          height: 300.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
              fallback: ((context) => Center(
                    child: CupertinoActivityIndicator(
                      radius: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  )));
        },
      );
    });
  }

  void _onRefresh(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      HomeLayoutCubit.get(context).getUserData();
      HomeLayoutCubit.get(context).getPosts();
      refreshController1.refreshCompleted();
    });
  }
}

Widget buildPostItem(int index, PostModel model, BuildContext context) => Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    "${model.image}",
                  )),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${model.name}",
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    Text(
                      "${model.dateTime}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ))
            ],
          ),
          //  Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "${model.text}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),

          if (model.postImage != '')
            Container(
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("${model.postImage}")),
              ),
            ),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    HomeLayoutCubit.get(context).likePost(
                        posId: HomeLayoutCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "${HomeLayoutCubit.get(context).likes[index]}",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context: context, widget: CommentScreen());
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "0 comment",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    HomeLayoutCubit.get(context).likePost(
                        posId: HomeLayoutCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Send,
                        color: Colors.green,
                        size: 18,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "${HomeLayoutCubit.get(context).likes[index]}",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        backgroundImage: NetworkImage(
                            "${HomeLayoutCubit.get(context).userModel.image}"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Write a comment..",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ]),
      ),
    );


// InkWell(
//                 onTap: () {},
//                 child: Row(
//                   children: [
//                     const Icon(
//                       IconBroken.Heart,
//                       color: Colors.red,
//                       size: 18,
//                     ),
//                     const SizedBox(
//                       width: 4.0,
//                     ),
//                     Text(
//                       "Like",
//                       style: Theme.of(context).textTheme.caption,
//                     )
//                   ],
//                 ),
//               ),

//tags
 // Container(
          //   width: double.infinity,
          //   // height: 40.0,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 20,
          //             onPressed: () {},
          //             child: Text("#Software",
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.blue,
          //                     )),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 20,
          //             onPressed: () {},
          //             child: Text("#Software",
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.blue,
          //                     )),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 20,
          //             onPressed: () {},
          //             child: Text("#Development Software",
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.blue,
          //                     )),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   // height: 40.0,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 20,
          //             onPressed: () {},
          //             child: Text("#Software",
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.blue,
          //                     )),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 20,
          //             onPressed: () {},
          //             child: Text("#Software",
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.blue,
          //                     )),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 20,
          //             onPressed: () {},
          //             child: Text("#Development Software",
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.blue,
          //                     )),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),