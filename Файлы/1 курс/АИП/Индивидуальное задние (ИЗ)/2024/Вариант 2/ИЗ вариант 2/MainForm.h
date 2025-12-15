#pragma once
#include "Customer.h" 
#include <cliext/list>

namespace BookStoreApp {

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
        System::Windows::Forms::TextBox^ discountTextBox;
        System::Windows::Forms::TextBox^ filterDiscountTextBox;
        System::Windows::Forms::ListBox^ customerListBox;
        System::Windows::Forms::ListBox^ filteredCustomerListBox;
        System::Windows::Forms::Label^ nameLabel;
        System::Windows::Forms::Label^ idLabel;
        System::Windows::Forms::Label^ discountLabel;
        System::Windows::Forms::Label^ filterDiscountLabel;
        System::Windows::Forms::Label^ customerListLabel;
        System::Windows::Forms::Label^ filteredListLabel;
        System::ComponentModel::Container^ components;

        void InitializeComponent(void) {
            this->addButton = (gcnew System::Windows::Forms::Button());
            this->filterButton = (gcnew System::Windows::Forms::Button());
            this->nameTextBox = (gcnew System::Windows::Forms::TextBox());
            this->idTextBox = (gcnew System::Windows::Forms::TextBox());
            this->discountTextBox = (gcnew System::Windows::Forms::TextBox());
            this->filterDiscountTextBox = (gcnew System::Windows::Forms::TextBox());
            this->customerListBox = (gcnew System::Windows::Forms::ListBox());
            this->filteredCustomerListBox = (gcnew System::Windows::Forms::ListBox());
            this->nameLabel = (gcnew System::Windows::Forms::Label());
            this->idLabel = (gcnew System::Windows::Forms::Label());
            this->discountLabel = (gcnew System::Windows::Forms::Label());
            this->filterDiscountLabel = (gcnew System::Windows::Forms::Label());
            this->customerListLabel = (gcnew System::Windows::Forms::Label());
            this->filteredListLabel = (gcnew System::Windows::Forms::Label());
            this->SuspendLayout();
            // 
            // addButton
            // 
            this->addButton->Location = System::Drawing::Point(410, 53);
            this->addButton->Name = L"addButton";
            this->addButton->Size = System::Drawing::Size(200, 37);
            this->addButton->TabIndex = 0;
            this->addButton->Text = L"Добавить клиента";
            this->addButton->UseVisualStyleBackColor = true;
            this->addButton->Click += gcnew System::EventHandler(this, &MainForm::addButton_Click);
            // 
            // filterButton
            // 
            this->filterButton->Location = System::Drawing::Point(410, 185);
            this->filterButton->Name = L"filterButton";
            this->filterButton->Size = System::Drawing::Size(200, 37);
            this->filterButton->TabIndex = 1;
            this->filterButton->Text = L"Фильтровать";
            this->filterButton->UseVisualStyleBackColor = true;
            this->filterButton->Click += gcnew System::EventHandler(this, &MainForm::filterButton_Click);
            // 
            // nameTextBox
            // 
            this->nameTextBox->Location = System::Drawing::Point(200, 31);
            this->nameTextBox->Name = L"nameTextBox";
            this->nameTextBox->Size = System::Drawing::Size(159, 22);
            this->nameTextBox->TabIndex = 2;
            // 
            // idTextBox
            // 
            this->idTextBox->Location = System::Drawing::Point(200, 68);
            this->idTextBox->Name = L"idTextBox";
            this->idTextBox->Size = System::Drawing::Size(159, 22);
            this->idTextBox->TabIndex = 3;
            // 
            // discountTextBox
            // 
            this->discountTextBox->Location = System::Drawing::Point(200, 105);
            this->discountTextBox->Name = L"discountTextBox";
            this->discountTextBox->Size = System::Drawing::Size(159, 22);
            this->discountTextBox->TabIndex = 4;
            // 
            // filterDiscountTextBox
            // 
            this->filterDiscountTextBox->Location = System::Drawing::Point(200, 222);
            this->filterDiscountTextBox->Name = L"filterDiscountTextBox";
            this->filterDiscountTextBox->Size = System::Drawing::Size(159, 22);
            this->filterDiscountTextBox->TabIndex = 5;
            // 
            // customerListBox
            // 
            this->customerListBox->FormattingEnabled = true;
            this->customerListBox->ItemHeight = 16;
            this->customerListBox->Location = System::Drawing::Point(667, 31);
            this->customerListBox->Name = L"customerListBox";
            this->customerListBox->Size = System::Drawing::Size(599, 196);
            this->customerListBox->TabIndex = 8;
            // 
            // filteredCustomerListBox
            // 
            this->filteredCustomerListBox->FormattingEnabled = true;
            this->filteredCustomerListBox->ItemHeight = 16;
            this->filteredCustomerListBox->Location = System::Drawing::Point(667, 272);
            this->filteredCustomerListBox->Name = L"filteredCustomerListBox";
            this->filteredCustomerListBox->Size = System::Drawing::Size(599, 196);
            this->filteredCustomerListBox->TabIndex = 9;
            // 
            // nameLabel
            // 
            this->nameLabel->AutoSize = true;
            this->nameLabel->Location = System::Drawing::Point(100, 31);
            this->nameLabel->Name = L"nameLabel";
            this->nameLabel->Size = System::Drawing::Size(39, 17);
            this->nameLabel->TabIndex = 10;
            this->nameLabel->Text = L"Имя:";
            // 
            // idLabel
            // 
            this->idLabel->AutoSize = true;
            this->idLabel->Location = System::Drawing::Point(100, 68);
            this->idLabel->Name = L"idLabel";
            this->idLabel->Size = System::Drawing::Size(25, 17);
            this->idLabel->TabIndex = 11;
            this->idLabel->Text = L"ID:";
            // 
            // discountLabel
            // 
            this->discountLabel->AutoSize = true;
            this->discountLabel->Location = System::Drawing::Point(100, 105);
            this->discountLabel->Name = L"discountLabel";
            this->discountLabel->Size = System::Drawing::Size(63, 17);
            this->discountLabel->TabIndex = 12;
            this->discountLabel->Text = L"Скидка:";
            // 
            // filterDiscountLabel
            // 
            this->filterDiscountLabel->AutoSize = true;
            this->filterDiscountLabel->Location = System::Drawing::Point(100, 222);
            this->filterDiscountLabel->Name = L"filterDiscountLabel";
            this->filterDiscountLabel->Size = System::Drawing::Size(87, 17);
            this->filterDiscountLabel->TabIndex = 13;
            this->filterDiscountLabel->Text = L"Скидка :";
            // 
            // customerListLabel
            // 
            this->customerListLabel->AutoSize = true;
            this->customerListLabel->Location = System::Drawing::Point(667, 11);
            this->customerListLabel->Name = L"customerListLabel";
            this->customerListLabel->Size = System::Drawing::Size(108, 17);
            this->customerListLabel->TabIndex = 14;
            this->customerListLabel->Text = L"Все клиенты:";
            // 
            // filteredListLabel
            // 
            this->filteredListLabel->AutoSize = true;
            this->filteredListLabel->Location = System::Drawing::Point(667, 252);
            this->filteredListLabel->Name = L"filteredListLabel";
            this->filteredListLabel->Size = System::Drawing::Size(159, 17);
            this->filteredListLabel->TabIndex = 15;
            this->filteredListLabel->Text = L"Отфильтрованные клиенты:";
            // 
            // MainForm
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(8, 16);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(1333, 554);
            this->Controls->Add(this->filteredListLabel);
            this->Controls->Add(this->customerListLabel);
            this->Controls->Add(this->filterDiscountLabel);
            this->Controls->Add(this->discountLabel);
            this->Controls->Add(this->idLabel);
            this->Controls->Add(this->nameLabel);
            this->Controls->Add(this->filteredCustomerListBox);
            this->Controls->Add(this->customerListBox);
            this->Controls->Add(this->filterDiscountTextBox);
            this->Controls->Add(this->discountTextBox);
            this->Controls->Add(this->idTextBox);
            this->Controls->Add(this->nameTextBox);
            this->Controls->Add(this->filterButton);
            this->Controls->Add(this->addButton);
            this->Name = L"MainForm";
            this->Text = L"Клиенты магазина книг";
            this->ResumeLayout(false);
            this->PerformLayout();

        }

        List<Customer^>^ customers = gcnew List<Customer^>();

        void addButton_Click(Object^ sender, EventArgs^ e) {
            try {
                String^ name = nameTextBox->Text;
                int id = Int32::Parse(idTextBox->Text);
                double discount = Double::Parse(discountTextBox->Text);

                Customer^ customer = gcnew Customer(name, id, discount);
                customers->Add(customer);

                customerListBox->Items->Add("Имя: " + customer->Name + ", ID: " + customer->Id + ", Скидка: " + customer->Discount + "%");

                nameTextBox->Clear();
                idTextBox->Clear();
                discountTextBox->Clear();
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message, "Ошибка", MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        void filterButton_Click(Object^ sender, EventArgs^ e) {
            try {
                double filterDiscount = Double::Parse(filterDiscountTextBox->Text);
                filteredCustomerListBox->Items->Clear();

                for each (Customer ^ customer in customers) {
                    if (customer->Discount == filterDiscount) {
                        filteredCustomerListBox->Items->Add("Имя: " + customer->Name + ", ID: " + customer->Id + ", Скидка: " + customer->Discount + "%");
                    }
                }
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message, "Ошибка", MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        void LoadDataFromDatabase() {
            try {
                String^ connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=BookStore.accdb;";
                OleDbConnection^ connection = gcnew OleDbConnection(connectionString);
                connection->Open();

                String^ query = "SELECT Name, ID, Discount FROM Customers";
                OleDbCommand^ command = gcnew OleDbCommand(query, connection);
                OleDbDataReader^ reader = command->ExecuteReader();

                while (reader->Read()) {
                    String^ name = reader["Name"]->ToString();
                    int id = Int32::Parse(reader["ID"]->ToString());
                    double discount = Double::Parse(reader["Discount"]->ToString());

                    Customer^ customer = gcnew Customer(name, id, discount);
                    customers->Add(customer);

                    customerListBox->Items->Add("Имя: " + customer->Name + ", ID: " + customer->Id + ", Скидка: " + customer->Discount + "%");
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
