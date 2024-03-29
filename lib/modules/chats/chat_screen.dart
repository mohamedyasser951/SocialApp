import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_details/chat_details.dart';
import 'package:socialapp/shared/componenet/component.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) =>
                buildChatItem(cubit.users[index], context)),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cubit.users.length,
          ),
          fallback: (context) => const Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
  }
}

Widget buildChatItem(UserModel model, BuildContext context) {
  return InkWell(
    onTap: () {
      navigateTo(context: context, widget:  ChatDetails(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage("${model.image}"),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text("${model.name}"),
        const Spacer(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,size: 20.0,))
      ]),
    ),
  );
}
