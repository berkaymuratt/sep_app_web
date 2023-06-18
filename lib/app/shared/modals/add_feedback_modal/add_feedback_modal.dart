import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/shared/modals/add_feedback_modal/add_feedback_modal_view_model.dart';
import 'package:sep_app_web/app/shared/sep_toast_messages.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';

class AddFeedbackModal extends StatefulWidget {
  final String reportId;

  const AddFeedbackModal({Key? key, required this.reportId}) : super(key: key);

  @override
  State<AddFeedbackModal> createState() => _AddFeedbackModalState();
}

class _AddFeedbackModalState extends State<AddFeedbackModal> {
  String comment = "";

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddFeedbackModalViewModel>();

    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.green,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 35 / 100,
        child: Stack(
          children: [
            _body(context),
            viewModel.isStateLoading
                ? Container(
                    color: Colors.black26,
                    child: const Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _title(),
          Flexible(
            child: ListView(
              children: [
                _commentInput(),
                _saveButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.commentDots,
                color: Colors.red,
                size: 21,
              ),
              SizedBox(width: 5),
              Text(
                "Yorum Ekle",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          SepDivider(height: 3, width: 300),
        ],
      ),
    );
  }

  Widget _commentInput() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLength: 500,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'Yorumunuz',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          comment = value;
        },
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    final AddFeedbackModalViewModel viewModel = context.read<AddFeedbackModalViewModel>();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 500),
      child: MaterialButton(
        padding: const EdgeInsets.all(10),
        onPressed: () {
          viewModel.addDoctorFeedback(widget.reportId, comment).then((isSuccessful) {
            if (isSuccessful) {
              context.pop();
              displaySuccessMessage(context, content: "İşlem Başarılı");
            } else {
              displayErrorMessage(context, content: "Hata Oluştu");
            }
          });
        },
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.plus, size: 15, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Ekle',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
