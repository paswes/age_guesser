import 'package:age_guesser/modules/name_age/cubit/name_age_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuessAgePage extends StatelessWidget {
  const GuessAgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Guesser'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            EstimatedAge(),
            Spacer(),
            NameInputField(),
            SizedBox(height: 16.0),
            SubmitButton(),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

class NameInputField extends StatelessWidget {
  const NameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    NameAgeCubit c = context.read<NameAgeCubit>();

    return TextField(
      controller: c.nameController,
      focusNode: c.focusNode,
      onTapOutside: (_) => c.focusNode.unfocus(),
      onChanged: (value) => c.onChangedName(value),
      decoration: const InputDecoration(
        labelText: 'Enter a name...',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NameAgeCubit c = context.read<NameAgeCubit>();
    final NameAgeState s = context.select((NameAgeCubit c) => c.state);

    final String name = s.name.trim();
    final bool canSubmit = name.isNotEmpty;

    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color disabledColor = theme.disabledColor;

    return ElevatedButton(
      onPressed: canSubmit ? () => c.onSubmit(name) : null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: canSubmit ? primaryColor : disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: canSubmit ? primaryColor : disabledColor,
          ),
        ),
      ),
      child: Text(
        'Guess it!',
        style: TextStyle(
          color: canSubmit ? Colors.white : disabledColor,
        ),
      ),
    );
  }
}

class EstimatedAge extends StatelessWidget {
  const EstimatedAge({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((NameAgeCubit c) => c.state);

    return Center(
      child: _build(state),
    );
  }

  Widget _build(NameAgeState state) {
    const initialText = 'Already curious?';

    final status = state.status;
    switch (status) {
      case Status.initial:
        return const Text(initialText);
      case Status.loading:
        return const CircularProgressIndicator();
      case Status.success:
        if (state.age != null) {
          return Column(
            children: [
              const Text('Estimated age'),
              Text(
                '${state.age}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ],
          );
        }
        return const Text(initialText);
      case Status.error:
        return Text(
          '${state.lastException}',
          style: const TextStyle(
            color: Colors.red,
          ),
        );
    }
  }
}
