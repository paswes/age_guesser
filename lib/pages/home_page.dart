import 'package:age_guesser/cubit/age_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      onTapOutside: (_) => c.removeFocus(),
      onChanged: (value) => c.onChangedName(value.trim()),
      decoration: const InputDecoration(
        labelText: 'Enter your name...',
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NameAgeCubit c = context.read<NameAgeCubit>();

    return BlocBuilder<NameAgeCubit, NameAgeState>(
      builder: (context, state) {
        final String? name = state.name;
        final bool isDirty = name != c.nameController.text;
        final bool canSubmit = (name?.isNotEmpty ?? false) && !isDirty;
        return ElevatedButton(
          onPressed: canSubmit ? () => c.getAge(state.name!) : null,
          child: const Text('Guess it!'),
        );
      },
    );
  }
}

class EstimatedAge extends StatelessWidget {
  const EstimatedAge({super.key});

  Widget _build(NameAgeState state) {
    if (state.status.isLoading) {
      return const CircularProgressIndicator();
    }

    if (state.status.isError) {
      return Text(
        '${state.lastException}',
        style: const TextStyle(
          color: Colors.red,
        ),
      );
    }

    if (state.age == null) {
      return const SizedBox();
    }

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

  @override
  Widget build(BuildContext context) {
    final state = context.select((NameAgeCubit c) => c.state);

    return Center(
      child: _build(state),
    );
  }
}
