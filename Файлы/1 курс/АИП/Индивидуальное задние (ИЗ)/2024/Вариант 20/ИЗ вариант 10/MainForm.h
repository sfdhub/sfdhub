#pragma once
#include "User.h"
#include "ComputerAddress.h"
#include <cliext/list>

namespace SecurityApp {

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
        System::Windows::Forms::Button^ filterButton;
        System::Windows::Forms::TextBox^ failureTypeTextBox;
        System::Windows::Forms::ListBox^ computerListBox;
        System::Windows::Forms::ListBox^ userListBox;
        System::ComponentModel::Container^ components;
        System::Windows::Forms::DataGridView^ dataGridView;

           //std::unordered_map<String^, ComputerAddress^> computerAddresses;

        ListBox^ dataListBox = gcnew ListBox();
    private: System::Windows::Forms::Label^ label1;
    private: System::Windows::Forms::Label^ label2;
    private: System::Windows::Forms::Label^ label3;

        void InitializeComponent(void) {
            this->filterButton = (gcnew System::Windows::Forms::Button());
            this->failureTypeTextBox = (gcnew System::Windows::Forms::TextBox());
            this->computerListBox = (gcnew System::Windows::Forms::ListBox());
            this->userListBox = (gcnew System::Windows::Forms::ListBox());
            this->label1 = (gcnew System::Windows::Forms::Label());
            this->label2 = (gcnew System::Windows::Forms::Label());
            this->label3 = (gcnew System::Windows::Forms::Label());
            this->SuspendLayout();
            // 
            // filterButton
            // 
            this->filterButton->Location = System::Drawing::Point(410, 53);
            this->filterButton->Name = L"filterButton";
            this->filterButton->Size = System::Drawing::Size(200, 37);
            this->filterButton->TabIndex = 1;
            this->filterButton->Text = L"Фильтровать";
            this->filterButton->UseVisualStyleBackColor = true;
            this->filterButton->Click += gcnew System::EventHandler(this, &MainForm::filterButton_Click);
            // 
            // failureTypeTextBox
            // 
            this->failureTypeTextBox->Location = System::Drawing::Point(200, 31);
            this->failureTypeTextBox->Name = L"failureTypeTextBox";
            this->failureTypeTextBox->Size = System::Drawing::Size(159, 22);
            this->failureTypeTextBox->TabIndex = 2;
            // 
            // computerListBox
            // 
            this->computerListBox->FormattingEnabled = true;
            this->computerListBox->ItemHeight = 16;
            this->computerListBox->Location = System::Drawing::Point(667, 31);
            this->computerListBox->Name = L"computerListBox";
            this->computerListBox->Size = System::Drawing::Size(654, 196);
            this->computerListBox->TabIndex = 8;
            // 
            // userListBox
            // 
            this->userListBox->FormattingEnabled = true;
            this->userListBox->ItemHeight = 16;
            this->userListBox->Location = System::Drawing::Point(667, 272);
            this->userListBox->Name = L"userListBox";
            this->userListBox->Size = System::Drawing::Size(654, 196);
            this->userListBox->TabIndex = 9;
            // 
            // label1
            // 
            this->label1->AutoSize = true;
            this->label1->Location = System::Drawing::Point(39, 31);
            this->label1->Name = L"label1";
            this->label1->Size = System::Drawing::Size(143, 16);
            this->label1->TabIndex = 10;
            this->label1->Text = L"Введите код ошибки:";
            this->label1->Click += gcnew System::EventHandler(this, &MainForm::label1_Click);
            // 
            // label2
            // 
            this->label2->AutoSize = true;
            this->label2->Location = System::Drawing::Point(664, 9);
            this->label2->Name = L"label2";
            this->label2->Size = System::Drawing::Size(162, 16);
            this->label2->TabIndex = 11;
            this->label2->Text = L"Список пользователей:";
            // 
            // label3
            // 
            this->label3->AutoSize = true;
            this->label3->Location = System::Drawing::Point(664, 253);
            this->label3->Name = L"label3";
            this->label3->Size = System::Drawing::Size(334, 16);
            this->label3->TabIndex = 12;
            this->label3->Text = L"Отфильтрованные пользователи по коду ошибки:";
            this->label3->Click += gcnew System::EventHandler(this, &MainForm::label3_Click);
            // 
            // MainForm
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(8, 16);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(1333, 554);
            this->Controls->Add(this->label3);
            this->Controls->Add(this->label2);
            this->Controls->Add(this->label1);
            this->Controls->Add(this->userListBox);
            this->Controls->Add(this->computerListBox);
            this->Controls->Add(this->failureTypeTextBox);
            this->Controls->Add(this->filterButton);
            this->Name = L"MainForm";
            this->Text = L"Информационная безопасность";
            this->ResumeLayout(false);
            this->PerformLayout();

        }

        Dictionary<String^, ComputerAddress^>^ computerAddresses = gcnew Dictionary<String^, ComputerAddress^>();

        void LoadDataFromDatabase() {
    try {
        String^ connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=SecurityDB.accdb;";
        OleDbConnection^ connection = gcnew OleDbConnection(connectionString);
        connection->Open();

        String^ query = "SELECT ComputerAddress, UserName, FailureType FROM SecurityData";
        OleDbCommand^ command = gcnew OleDbCommand(query, connection);
        OleDbDataReader^ reader = command->ExecuteReader();

        while (reader->Read()) {
            String^ computerAddress = reader["ComputerAddress"]->ToString();
            String^ userName = reader["UserName"]->ToString();
            String^ failureType = reader["FailureType"]->ToString();

            String^ item = "Адрес компьютера: " + computerAddress + ", Имя пользователя: " + userName + ", Код ошибки: " + failureType;
            computerListBox->Items->Add(item);

            if (!computerAddresses->ContainsKey(computerAddress)) {
                computerAddresses[computerAddress] = gcnew ComputerAddress(computerAddress);
            }

            User^ user = gcnew User(userName);
            user->AddFailureType(gcnew ComputerFailureType(failureType));
            computerAddresses[computerAddress]->AddUser(user);
        }

        reader->Close();
        connection->Close();
    }
    catch (Exception^ ex) {
        MessageBox::Show("Ошибка загрузки данных: " + ex->Message);
    }
}

        void filterButton_Click(System::Object^ sender, System::EventArgs^ e) {
            String^ failureTypeFilter = failureTypeTextBox->Text;
            userListBox->Items->Clear();

            for each (KeyValuePair<String^, ComputerAddress^> kvp in computerAddresses) {
                ComputerAddress^ compAddr = kvp.Value;
                for each (User ^ user in compAddr->Users) {
                    for each (ComputerFailureType ^ failureType in user->FailureTypes) {
                        if (failureType->FailureType->Equals(failureTypeFilter, StringComparison::OrdinalIgnoreCase)) {
                            userListBox->Items->Add(
                                "Пользователь: " + user->Name );
                        }
                    }
                }
            }
        }

    private: System::Void label1_Click(System::Object^ sender, System::EventArgs^ e) {
    }
private: System::Void label3_Click(System::Object^ sender, System::EventArgs^ e) {
}
};
}

