import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';

class ResumeUploadWidget extends StatefulWidget {
  final Function(File?)? onFileSelected;
  final String? initialFileName;
  final bool isRequired;

  const ResumeUploadWidget({
    Key? key,
    this.onFileSelected,
    this.initialFileName,
    this.isRequired = false,
  }) : super(key: key);

  @override
  State<ResumeUploadWidget> createState() => _ResumeUploadWidgetState();
}

class _ResumeUploadWidgetState extends State<ResumeUploadWidget> {
  File? _selectedFile;
  String? _fileName;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _fileName = widget.initialFileName;
  }

  Future<void> _pickFile() async {
    try {
      setState(() {
        _isUploading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;

        // Validate file size (max 10MB)
        int fileSizeInBytes = await _selectedFile!.length();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        if (fileSizeInMB > 10) {
          _showErrorDialog('File size should not exceed 10MB');
          _selectedFile = null;
          _fileName = null;
        } else {
          widget.onFileSelected?.call(_selectedFile);
        }
      }
    } catch (e) {
      _showErrorDialog('Error picking file: ${e.toString()}');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
    });
    widget.onFileSelected?.call(null);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildFileIcon(String? fileName) {
    if (fileName == null)
      return Icon(Icons.upload_file, color: AppColors.primaryColor);

    String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
      case 'doc':
      case 'docx':
        return Icon(Icons.description, color: Colors.blue, size: 24);
      default:
        return Icon(Icons.insert_drive_file,
            color: AppColors.primaryColor, size: 24);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Resume',
              style: TextStyles.regular3(),
            ),
            if (widget.isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: _fileName != null
                  ? AppColors.primaryColor
                  : Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _fileName != null
              ? _buildSelectedFileWidget()
              : _buildUploadWidget(),
        ),
        SizedBox(height: 4),
        Text(
          'Supported formats: PDF, DOC, DOCX (Max 10MB)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadWidget() {
    return InkWell(
      onTap: _isUploading ? null : _pickFile,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (_isUploading)
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              )
            else ...[
              _buildFileIcon(null),
              SizedBox(height: 8),
              Text(
                'Upload Resume',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Tap to browse files',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFileWidget() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          _buildFileIcon(_fileName),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fileName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (_selectedFile != null)
                  FutureBuilder<int>(
                    future: _selectedFile!.length(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        double sizeInMB = snapshot.data! / (1024 * 1024);
                        return Text(
                          '${sizeInMB.toStringAsFixed(2)} MB',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _pickFile,
                icon: Icon(Icons.edit, color: AppColors.primaryColor, size: 20),
                tooltip: 'Change file',
              ),
              IconButton(
                onPressed: _removeFile,
                icon: Icon(Icons.delete, color: Colors.red, size: 20),
                tooltip: 'Remove file',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
