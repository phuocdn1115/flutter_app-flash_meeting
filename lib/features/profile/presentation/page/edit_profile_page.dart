import 'dart:io';

import 'package:flash_meeting_app/core/ui/default_button.dart';
import 'package:flash_meeting_app/core/ui/default_text_field.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meeting_app/features/profile/presentation/widget/circle_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const String route = '/edit_profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _avatarFile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var name = context.read<UserBloc>().state.userEntity?.name ?? '';
    var bio = context.read<UserBloc>().state.userEntity?.bio ?? '';

    nameController.text = name;
    bioController.text = bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var imagePicker = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (imagePicker != null) {
                          setState(() {
                            _avatarFile = File(imagePicker.path);
                          });
                        }
                      },
                      child:
                          _avatarFile != null
                              ? ClipOval(
                                child: Image.file(
                                  _avatarFile!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : CircleUserAvatar(
                                width: 100,
                                height: 100,
                                url: state.userEntity?.avatar,
                              ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  DefaultTextField(
                    hintText: 'Enter your name',
                    controller: nameController,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  DefaultTextField(
                    hintText: 'Enter bio',
                    controller: bioController,
                    maxLines: 6,
                    maxLength: 255,
                    minLines: 1,
                  ),
                  Spacer(),
                  DefaultButton(
                    text: 'Save',
                    onPressed: () {
                      context.read<UserBloc>().add(
                        EditUserEvent(
                          name: nameController.text,
                          bio: bioController.text,
                          avatar: _avatarFile,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.status == UserStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          } else if (state.status == UserStatus.successEditProfile) {
            context.pop();
          }
        },
      ),
    );
  }
}
