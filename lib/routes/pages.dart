import 'package:get/get.dart';
import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:beauty_hub_admin/modules/auth/view/auth_page.dart';
import 'package:beauty_hub_admin/modules/home/view/home_page.dart';
import 'package:beauty_hub_admin/modules/splash/view/splash_page.dart';
import 'package:beauty_hub_admin/modules/auth/binding/auth_binding.dart';
import 'package:beauty_hub_admin/modules/home/binding/home_binding.dart';
import 'package:beauty_hub_admin/modules/splash/binding/splash_binding.dart';
import 'package:beauty_hub_admin/modules/staff_manage/view/staff_manage.dart';
import 'package:beauty_hub_admin/modules/staff_manage/binding/staff_manage.dart';
import 'package:beauty_hub_admin/modules/add_product/view/add_product_page.dart';
import 'package:beauty_hub_admin/modules/order_manage/view/order_manage_page.dart';
import 'package:beauty_hub_admin/modules/add_user_admin/view/add_user_admin_page.dart';
import 'package:beauty_hub_admin/modules/add_product/binding/add_product_binding.dart';
import 'package:beauty_hub_admin/modules/product_manage/view/product_manage_page.dart';
import 'package:beauty_hub_admin/modules/order_manage/binding/order_manage_binding.dart';
import 'package:beauty_hub_admin/modules/add_user_admin/binding/add_user_admin_binding.dart';
import 'package:beauty_hub_admin/modules/product_manage/binding/product_manage_binding.dart';
import 'package:beauty_hub_admin/modules/revenue_statistics/view/revenue_statistics_page.dart';
import 'package:beauty_hub_admin/modules/revenue_statistics/binding/revenue_statistics_binding.dart';

final pages = [
  GetPage(
    name: AppRoutes.splashPage,
    page: () => const SplashPage(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: AppRoutes.authPage,
    page: () => const AuthPage(),
    binding: AuthBinding(),
  ),
  GetPage(

    name: AppRoutes.homePage,
    page: () =>  HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoutes.productManagePage,
    page: () => const ProductManagePage(),
    binding: ProductManageBinding(),
  ),
  GetPage(
    name: AppRoutes.orderManagePage,
    page: () => const OrderManagePage(),
    binding: OrderManageBinding(),
  ),
  GetPage(
    name: AppRoutes.revenueStatisticsPage,
    page: () => const RevenueStatisticsPage(),
    binding: RevenueStatisticsBinding(),
  ),
  GetPage(
    name: AppRoutes.addProductPage,
    page: () => const AddProductPage(),
    binding: AddProductBinding(),
  ),
  GetPage(
    name: AppRoutes.staffManage,
    page: () => const StaffManage(),
    binding: StaffManageBinding(),
  ),
   GetPage(
    name: AppRoutes.addUserAdmin,
    page: () =>  AddUserAdminPage(),
    binding: AddUserAdminBinding(),
  ),
];
