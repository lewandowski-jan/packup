import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:packer/config/config.dart';
import 'package:packer/controllers/add_package_cubit/add_package_cubit.dart';
import 'package:packer/views/widgets/app_scaffold.dart';
import 'package:packer/views/widgets/app_text_button.dart';
import 'package:packer/views/widgets/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packer/views/widgets/loading_placeholder.dart';

class AddSenderPageRoute extends MaterialPageRoute<void> {
  AddSenderPageRoute()
      : super(builder: (BuildContext context) => AddSenderPage());
}

class AddSenderPage extends StatelessWidget {
  AddSenderPage({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final required = FormBuilderValidators.required(context);

    return BlocBuilder<AddPackageCubit, AddPackageState>(
      builder: (context, state) {
        return Stack(
          children: [
            AppScaffold(
              height: 60,
              title: const Text(
                'New sender',
                style: TextStyles.white24,
              ),
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name*',
                              style: TextStyles.white20,
                            ),
                            const SizedBox(height: 4),
                            AppTextField(
                              name: 'name',
                              validator:
                                  FormBuilderValidators.required(context),
                              padding: 12,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'City*',
                              style: TextStyles.white20,
                            ),
                            const SizedBox(height: 4),
                            AppTextField(
                              name: 'city',
                              validator: required,
                              padding: 12,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Address*',
                              style: TextStyles.white20,
                            ),
                            const SizedBox(height: 4),
                            AppTextField(
                              name: 'address',
                              validator: required,
                              padding: 12,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.streetAddress,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Post code*',
                              style: TextStyles.white20,
                            ),
                            const SizedBox(height: 4),
                            AppTextField(
                              name: 'postcode',
                              maxLength: 20,
                              validator: required,
                              padding: 12,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.streetAddress,
                            ),
                            const SizedBox(height: 12),
                            AppTextButton(
                              text: 'Save',
                              onPressed: () async {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  final value = _formKey.currentState!.value;
                                  final sender = await context
                                      .read<AddPackageCubit>()
                                      .addSender(
                                        name: value['name'],
                                        city: value['city'],
                                        addressLine: value['address'],
                                        postCode: value['postcode'],
                                      );
                                  Navigator.of(context).pop(sender);
                                }
                              },
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            if (state is AddPackageInProgress) const LoadingPlaceholder(),
          ],
        );
      },
    );
  }
}