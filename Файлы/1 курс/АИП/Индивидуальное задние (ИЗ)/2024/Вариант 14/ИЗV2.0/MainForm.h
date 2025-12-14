#pragma once
#include "Student.h"
#include <cliext/list>

namespace StudentRecordApp {

    using namespace System;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Collections::Generic;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;
    using namespace System::Data::OleDb;

    public ref class MainForm : public System::Windows::Forms::Form {
    public:
        MainForm(void) {
            InitializeComponent();
            LoadDataFromDatabase();
        }

    protected:
        ~MainForm() {
            if (components) {
                delete components;
            }
        }

    private:
        System::Windows::Forms::Button^ addButton;
        System::Windows::Forms::Button^ filterButton;
        System::Windows::Forms::TextBox^ nameTextBox;
        System::Windows::Forms::TextBox^ idTextBox;
        System::Windows::Forms::TextBox^ subject1TextBox;
        System::Windows::Forms::TextBox^ subject2TextBox;
        System::Windows::Forms::TextBox^ filterSubject1TextBox;
        System::Windows::Forms::TextBox^ filterSubject2TextBox;
        System::Windows::Forms::ListBox^ studentListBox;
        System::Windows::Forms::ListBox^ filteredStudentListBox;
        System::Windows::Forms::Label^ nameLabel;
        System::Windows::Forms::Label^ idLabel;
        System::Windows::Forms::Label^ subject1Label;
        System::Windows::Forms::Label^ subject2Label;
        System::Windows::Forms::Label^ filterSubject1Label;
        System::Windows::Forms::Label^ filterSubject2Label;
        System::Windows::Forms::Label^ studentListLabel;
        System::Windows::Forms::Label^ filteredListLabel;
        List<Student^>^ students;

    private:
        System::ComponentModel::Container^ components;

        void InitializeComponent(void) {
            this->addButton = (gcnew System::Windows::Forms::Button());
            this->filterButton = (gcnew System::Windows::Forms::Button());
            this->nameTextBox = (gcnew System::Windows::Forms::TextBox());
            this->idTextBox = (gcnew System::Windows::Forms::TextBox());
            this->subject1TextBox = (gcnew System::Windows::Forms::TextBox());
            this->subject2TextBox = (gcnew System::Windows::Forms::TextBox());
            this->filterSubject1TextBox = (gcnew System::Windows::Forms::TextBox());
            this->filterSubject2TextBox = (gcnew System::Windows::Forms::TextBox());
            this->studentListBox = (gcnew System::Windows::Forms::ListBox());
            this->filteredStudentListBox = (gcnew System::Windows::Forms::ListBox());
            this->nameLabel = (gcnew System::Windows::Forms::Label());
            this->idLabel = (gcnew System::Windows::Forms::Label());
            this->subject1Label = (gcnew System::Windows::Forms::Label());
            this->subject2Label = (gcnew System::Windows::Forms::Label());
            this->filterSubject1Label = (gcnew System::Windows::Forms::Label());
            this->filterSubject2Label = (gcnew System::Windows::Forms::Label());
            this->studentListLabel = (gcnew System::Windows::Forms::Label());
            this->filteredListLabel = (gcnew System::Windows::Forms::Label());
            this->SuspendLayout();

            // addButton
            this->addButton->Location = System::Drawing::Point(300, 22);
            this->addButton->Name = L"addButton";
            this->addButton->Size = System::Drawing::Size(150, 30);
            this->addButton->TabIndex = 0;
            this->addButton->Text = L"Добавить студента";
            this->addButton->UseVisualStyleBackColor = true;
            this->addButton->Click += gcnew System::EventHandler(this, &MainForm::addButton_Click);

            // filterButton
            this->filterButton->Location = System::Drawing::Point(300, 150);
            this->filterButton->Name = L"filterButton";
            this->filterButton->Size = System::Drawing::Size(150, 30);
            this->filterButton->TabIndex = 1;
            this->filterButton->Text = L"Фильтровать";
            this->filterButton->UseVisualStyleBackColor = true;
            this->filterButton->Click += gcnew System::EventHandler(this, &MainForm::filterButton_Click);

            // nameTextBox
            this->nameTextBox->Location = System::Drawing::Point(150, 25);
            this->nameTextBox->Name = L"nameTextBox";
            this->nameTextBox->Size = System::Drawing::Size(120, 20);
            this->nameTextBox->TabIndex = 2;

            // idTextBox
            this->idTextBox->Location = System::Drawing::Point(150, 55);
            this->idTextBox->Name = L"idTextBox";
            this->idTextBox->Size = System::Drawing::Size(120, 20);
            this->idTextBox->TabIndex = 3;

            // subject1TextBox
            this->subject1TextBox->Location = System::Drawing::Point(150, 85);
            this->subject1TextBox->Name = L"subject1TextBox";
            this->subject1TextBox->Size = System::Drawing::Size(120, 20);
            this->subject1TextBox->TabIndex = 4;

            // subject2TextBox
            this->subject2TextBox->Location = System::Drawing::Point(150, 115);
            this->subject2TextBox->Name = L"subject2TextBox";
            this->subject2TextBox->Size = System::Drawing::Size(120, 20);
            this->subject2TextBox->TabIndex = 5;

            // filterSubject1TextBox
            this->filterSubject1TextBox->Location = System::Drawing::Point(150, 153);
            this->filterSubject1TextBox->Name = L"filterSubject1TextBox";
            this->filterSubject1TextBox->Size = System::Drawing::Size(120, 20);
            this->filterSubject1TextBox->TabIndex = 6;

            // filterSubject2TextBox
            this->filterSubject2TextBox->Location = System::Drawing::Point(150, 183);
            this->filterSubject2TextBox->Name = L"filterSubject2TextBox";
            this->filterSubject2TextBox->Size = System::Drawing::Size(120, 20);
            this->filterSubject2TextBox->TabIndex = 7;

            // studentListBox
            this->studentListBox->FormattingEnabled = true;
            this->studentListBox->Location = System::Drawing::Point(500, 25);
            this->studentListBox->Name = L"studentListBox";
            this->studentListBox->Size = System::Drawing::Size(450, 160);
            this->studentListBox->TabIndex = 8;

            // filteredStudentListBox
            this->filteredStudentListBox->FormattingEnabled = true;
            this->filteredStudentListBox->Location = System::Drawing::Point(500, 220);
            this->filteredStudentListBox->Name = L"filteredStudentListBox";
            this->filteredStudentListBox->Size = System::Drawing::Size(450, 160);
            this->filteredStudentListBox->TabIndex = 9;

            // nameLabel
            this->nameLabel->Location = System::Drawing::Point(20, 25);
            this->nameLabel->Name = L"nameLabel";
            this->nameLabel->Size = System::Drawing::Size(100, 23);
            this->nameLabel->Text = L"Имя:";

            // idLabel
            this->idLabel->Location = System::Drawing::Point(20, 55);
            this->idLabel->Name = L"idLabel";
            this->idLabel->Size = System::Drawing::Size(100, 23);
            this->idLabel->Text = L"ID:";

            // subject1Label
            this->subject1Label->Location = System::Drawing::Point(20, 85);
            this->subject1Label->Name = L"subject1Label";
            this->subject1Label->Size = System::Drawing::Size(75, 23);
            this->subject1Label->Text = L"Предмет 1:";

            // subject2Label
            this->subject2Label->Location = System::Drawing::Point(20, 115);
            this->subject2Label->Name = L"subject2Label";
            this->subject2Label->Size = System::Drawing::Size(75, 23);
            this->subject2Label->Text = L"Предмет 2:";

            // filterSubject1Label
            this->filterSubject1Label->Location = System::Drawing::Point(20, 153);
            this->filterSubject1Label->Name = L"filterSubject1Label";
            this->filterSubject1Label->Size = System::Drawing::Size(125, 23);
            this->filterSubject1Label->Text = L"Фильтр Предмет 1:";

            // filterSubject2Label
            this->filterSubject2Label->Location = System::Drawing::Point(20, 183);
            this->filterSubject2Label->Name = L"filterSubject2Label";
            this->filterSubject2Label->Size = System::Drawing::Size(125, 23);
            this->filterSubject2Label->Text = L"Фильтр Предмет 2:";

            // studentListLabel
            this->studentListLabel->Location = System::Drawing::Point(600, 5);
            this->studentListLabel->Name = L"studentListLabel";
            this->studentListLabel->Size = System::Drawing::Size(100, 15);
            this->studentListLabel->Text = L"Список студентов:";

            // filteredListLabel
            this->filteredListLabel->Location = System::Drawing::Point(600, 200);
            this->filteredListLabel->Name = L"filteredListLabel";
            this->filteredListLabel->Size = System::Drawing::Size(150, 15);
            this->filteredListLabel->Text = L"Отфильтрованный список:";

            // MainForm
            this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(1000, 450);
            this->Controls->Add(this->filteredListLabel);
            this->Controls->Add(this->studentListLabel);
            this->Controls->Add(this->filterSubject2Label);
            this->Controls->Add(this->filterSubject1Label);
            this->Controls->Add(this->subject2Label);
            this->Controls->Add(this->subject1Label);
            this->Controls->Add(this->idLabel);
            this->Controls->Add(this->nameLabel);
            this->Controls->Add(this->filteredStudentListBox);
            this->Controls->Add(this->studentListBox);
            this->Controls->Add(this->filterSubject2TextBox);
            this->Controls->Add(this->filterSubject1TextBox);
            this->Controls->Add(this->subject2TextBox);
            this->Controls->Add(this->subject1TextBox);
            this->Controls->Add(this->idTextBox);
            this->Controls->Add(this->nameTextBox);
            this->Controls->Add(this->filterButton);
            this->Controls->Add(this->addButton);
            this->Name = L"MainForm";
            this->Text = L"Зачетная книжка студентов";
            this->ResumeLayout(false);
            this->PerformLayout();

            // Initialize the list of students
            students = gcnew List<Student^>();
        }

        void addButton_Click(Object^ sender, EventArgs^ e) {
            try {
                String^ name = nameTextBox->Text;
                int id = Int32::Parse(idTextBox->Text);
                String^ subject1 = subject1TextBox->Text;
                String^ subject2 = subject2TextBox->Text;

                Student^ student = gcnew Student(name, id);
                student->RecordBook->AddSubject(gcnew Subject(subject1));
                student->RecordBook->AddSubject(gcnew Subject(subject2));
                students->Add(student);

                studentListBox->Items->Add("Имя: " + student->Name + ", ID: " + student->Id + ", Предметы: " + subject1 + ", " + subject2);

                nameTextBox->Clear();
                idTextBox->Clear();
                subject1TextBox->Clear();
                subject2TextBox->Clear();
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message, "Ошибка", MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        void filterButton_Click(Object^ sender, EventArgs^ e) {
            try {
                String^ filterSubject1 = filterSubject1TextBox->Text;
                String^ filterSubject2 = filterSubject2TextBox->Text;

                filteredStudentListBox->Items->Clear();

                for each (Student ^ student in students) {
                    bool hasSubject1 = false;
                    bool hasSubject2 = false;

                    for each (Subject ^ subject in student->RecordBook->Subjects) {
                        if (subject->Name == filterSubject1) {
                            hasSubject1 = true;
                        }
                        if (subject->Name == filterSubject2) {
                            hasSubject2 = true;
                        }
                    }

                    if (hasSubject1 && hasSubject2) {
                        filteredStudentListBox->Items->Add("ID: " + student->Id);
                    }
                }
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message, "Ошибка", MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        void LoadDataFromDatabase() {
            try {
                String^ connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=StudentRecords.accdb;";
                OleDbConnection^ connection = gcnew OleDbConnection(connectionString);
                connection->Open();
                String^ query = "SELECT * FROM Students";
                OleDbCommand^ command = gcnew OleDbCommand(query, connection);
                OleDbDataReader^ reader = command->ExecuteReader();

                while (reader->Read()) {
                    String^ name = reader["Name"]->ToString();
                    int id = Int32::Parse(reader["ID"]->ToString());
                    String^ subject1 = reader["Subject1"]->ToString();
                    String^ subject2 = reader["Subject2"]->ToString();

                    Student^ student = gcnew Student(name, id);
                    student->RecordBook->AddSubject(gcnew Subject(subject1));
                    student->RecordBook->AddSubject(gcnew Subject(subject2));
                    students->Add(student);

                    studentListBox->Items->Add("Имя: " + student->Name + ", ID: " + student->Id + ", Предметы: " + subject1 + ", " + subject2);
                }

                reader->Close();
                connection->Close();
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message, "Ошибка", MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }
    };
}
