import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/modules/comment_page/comment_page.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeBanner(),
          PostsBuilder(),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class PostsBuilder extends StatefulWidget {
  const PostsBuilder({
    super.key,
  });

  @override
  State<PostsBuilder> createState() => _PostsBuilderState();
}

class _PostsBuilderState extends State<PostsBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<HomeLayoutCubit>(context).getPosts(),
        key: widget.key,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8.0,
            ),
            itemBuilder: (context, index) =>
                buildPostItem(index, snapshot.data!.docs[index], context),
          );
        });
  }
}

Widget buildPostItem(int index, var data, BuildContext context) {
  var cubit = HomeLayoutCubit.get(context);
  return BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
    builder: (context, state) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAlias,
        elevation: 12.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      "${data['image']}",
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
                            "${data['name']}",
                            style: const TextStyle(height: 1.4),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                      Text(
                        "${data['dateTime']}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 22,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "${data['text']}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            if (data['postImage'] != '')
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${data['postImage']}")),
                ),
              ),

            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      cubit.likePost(
                          posId: HomeLayoutCubit.get(context).postsId[index]);
                    },
                    child: InkWell(
                      onTap: () {
                        cubit.changeStateOfLike(postId: cubit.postsId[index]);
                        print(cubit.isLikeByMe);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 20,
                            color:
                                cubit.isLikeByMe ? Colors.red : Colors.black54,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "0"
                                .toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      navigateTo(context: context, widget: CommentScreen());
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.comment_outlined,
                          size: 20,
                          color: Colors.black54,
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
                ],
              ),
            ),
            // const Divider(
            //   color: Colors.grey,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: InkWell(
            //         child: Row(
            //           children: [
            //             CircleAvatar(
            //               radius: 16.0,
            //               backgroundImage: NetworkImage(
            //                   "${HomeLayoutCubit.get(context).userModel!.image}"),
            //             ),
            //             const SizedBox(
            //               width: 5,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 10),
            //               child: Text(
            //                 "Write a comment..",
            //                 style: Theme.of(context).textTheme.caption,
            //               ),
            //             ),
            //           ],
            //         ),
            //         onTap: () {},
            //       ),
            //     ),
            //   ],
            // ),
          ]),
        ),
      );
    },
  );
}


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