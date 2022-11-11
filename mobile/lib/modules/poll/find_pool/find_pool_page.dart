import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './find_pool_controller.dart';

class FindPoolPage extends GetView<FindPoolController> {
    
    const FindPoolPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('FindPoolPage'),),
            body: Container(),
        );
    }
}