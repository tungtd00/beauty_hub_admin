import 'package:beauty_hub_admin/modules/add_product/controller/add_product_controller.dart';
import 'package:beauty_hub_admin/modules/order_manage/view/product_category_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends GetView<AddProductController> {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Obx(
            () => Text(
              controller.title.value,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: controller.globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                  text: const TextSpan(
                      text: 'Tên sản phẩm ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  hintText: 'Nhập tên sản phẩm',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                ),
              ),
              const SizedBox(height: 12.0),
              RichText(
                  text: const TextSpan(
                      text: 'Giá sản phẩm ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nhập giá sản phẩm',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                ),
              ),
              const SizedBox(height: 12.0),
              RichText(
                  text: const TextSpan(
                      text: 'Ảnh sản phẩm ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              const SizedBox(height: 8.0),
              Obx(() => controller.imageFile.value == null
                  ? Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.shade200,
                      ),
                      child: IconButton(
                          onPressed: () {
                            controller.chooseImage();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          )))
                  : Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.shade200,
                        image: DecorationImage(
                          image: FileImage(controller.imageFile.value!),
                          fit: BoxFit.cover,
                        ),
                      ))),
              const SizedBox(height: 12.0),
              RichText(
                  text: const TextSpan(
                      text: 'Giới thiệu về sản phẩm ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.introController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Nhập giới thiệu sản phẩm',
                  helperMaxLines: 5,
                  helperText:
                      'Hãy viết giới thiệu về sản phẩm một cách hấp dẫn nhất, ngắn ngọn, dễ hiểu. Đó sẽ một cách thu hút người dùng hiệu quả và giúp bạn gia tăng doanh số bán hàng.',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              const Text(
                'Mô tả',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.descController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Nhập mô tả về sản phẩm',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Obx(
                () => controller.categories.isNotEmpty
                    ? ProductCategoryList(
                        categories: controller.categories,
                        productCategories: controller.chooseCategories,
                        onChoose: (dataList) {
                          controller.chooseCategories.value = dataList;
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(height: 12.0),
              RichText(
                  text: const TextSpan(
                      text: 'Xuất sứ của sản phẩm ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.originController,
                decoration: const InputDecoration(
                  hintText: 'Nhập xuất sứ',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        MaterialButton(
          onPressed: () {},
          color: Colors.green,
          minWidth: Get.width,
          height: 48.0,
          child: const Text(
            'Xác nhận',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
