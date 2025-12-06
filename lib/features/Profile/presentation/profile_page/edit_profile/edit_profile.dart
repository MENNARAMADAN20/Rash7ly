import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rash7ly/components/formfields/auth_form_field.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/services/cloudinare_service/cloudinary_service.dart';
import 'package:rash7ly/core/services/local/local_helper.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/Profile/presentation/profile_page/repo/edit_profile_repo.dart';
import 'package:rash7ly/features/auth/data/models/user_model.dart';
import 'package:rash7ly/features/home/widgets/arrow_back_app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = LocalHelper.getUserData();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isloading = false;
  Future<void> _changeProfileImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked == null) return;

      setState(() => isloading = true);

      final file = File(picked.path);

      // 1) رفع الصورة إلى Cloudinary
      final cloudinary = CloudinaryService();
      final imageUrl = await cloudinary.uploadFile(file);

      // 2) تحديث الفايرستور + اللوكال
      await UpdateProfile().updateProfile(
        userId: user!.id,
        newPhotoUrl: imageUrl,
      );

      // 3) تحديث local user object
      user!.photoUrl = imageUrl;
      LocalHelper.setUserData(user);

      // 4) تحديث الواجهة
      setState(() {});

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Profile photo updated")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 60,
        leading: ArrowBackAppBar(
          backgroundColor: AppColors.lightGreyColor,
          iconColor: AppColors.darkModeColor,
        ),
        title: Text(
          "Edit Profile",
          style: TextStyles.getSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // profile image with edit icon
            //  ProfileImage
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                // الصورة نفسها
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user?.photoUrl != null
                      ? NetworkImage(user!.photoUrl!)
                      : AssetImage(AppAssets.personProfile) as ImageProvider,
                ),

                // زر الكاميرا
                GestureDetector(
                  onTap: _changeProfileImage,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            Gap(30),
            Text(
              user?.name ?? 'User Name',
              style: TextStyles.getSize24(
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
            Gap(40),
            Text(
              user?.email ?? 'Leonardo@gmail.com',
              style: TextStyles.getSize18(
                fontWeight: FontWeight.normal,
                color: AppColors.greyColor,
              ),
            ),
            Gap(70),
            /////////////
            // form fields
            AuthFormField(controller: nameController, hint: "New User Name"),
            Gap(60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: isloading
                  ? null
                  : () async {
                      final newName = nameController.text.trim();

                      try {
                        await UpdateProfile().updateProfile(
                          userId: user!.id,
                          newName: newName.isNotEmpty ? newName : null,
                          // لو عايز تضيف اختيار صورة:
                          // newPhotoUrl: newPhotoUrl,
                        );
                        setState(() {
                          isloading = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Profile updated successfully."),
                            backgroundColor: AppColors.blueColor,
                          ),
                        );

                        setState(() {}); // refresh UI
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Error: $e")));
                      } finally {
                        setState(() {
                          isloading = false;
                        });
                      }
                    },
              child: Text(
                "Save Changes",
                style: TextStyles.getSize18(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
