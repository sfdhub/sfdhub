#pragma once
#include "Customer.h"
#include <cliext/list>

namespace FoodStoreApp {

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
        System::Windows::Forms::TextBox^ productTitleTextBox;
        System::Windows::Forms::TextBox^ discountTextBox;
        System::Windows::Forms::TextBox^ filterDiscountTextBox;
        System::Windows::Forms::ListBox^ customerListBox;
        System::Windows::Forms::ListBox^ filteredCustomerListBox;
        System::Windows::Forms::Label^ nameLabel;
        System::Windows::Forms::Label^ productTitleLabel;
        System::Windows::Forms::Label^ discountLabel;
        System::Windows::Forms::Label^ filterDiscountLabel;
        System::Windows::Forms::Label^ customerListLabel;
        System::Windows::Forms::Label^ filteredListLabel;
        System::ComponentModel::Container^ components;

        void InitializeComponent(void) {
            this->addButton = (gcnew System::Windows::Forms::Button());
            this->filterButton = (gcnew System::Windows::Forms::Button());
            this->nameTextBox = (gcnew System::Windows::Forms::TextBox());
            this->productTitleTextBox = (gcnew System::Windows::Forms::TextBox());
            this->discountTextBox = (gcnew System::Windows::Forms::TextBox());
            this->filterDiscountTextBox = (gcnew System::Windows::Forms::TextBox());
            this->customerListBox = (gcnew System::Windows::Forms::ListBox());
            this->filteredCustomerListBox = (gcnew System::Windows::Forms::ListBox());
            this->nameLabel = (gcnew System::Windows::Forms::Label());
            this->productTitleLabel = (gcnew System::Windows::Forms::Label());
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
            this->filterButton->Location = System::Drawing::Point(693, 192);
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
            // productTitleTextBox
            // 
            this->productTitleTextBox->Location = System::Drawing::Point(200, 68);
            this->productTitleTextBox->Name = L"productTitleTextBox";
            this->productTitleTextBox->Size = System::Drawing::Size(159, 22);
            this->productTitleTextBox->TabIndex = 3;
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
            this->filterDiscountTextBox->Location = System::Drawing::Point(502, 199);
            this->filterDiscountTextBox->Name = L"filterDiscountTextBox";
            this->filterDiscountTextBox->Size = System::Drawing::Size(159, 22);
            this->filterDiscountTextBox->TabIndex = 5;
            // 
            // customerListBox
            // 
            this->customerListBox->FormattingEnabled = true;
            this->customerListBox->ItemHeight = 16;
            this->customerListBox->Location = System::Drawing::Point(48, 269);
            this->customerListBox->Name = L"customerListBox";
            this->customerListBox->Size = System::Drawing::Size(402, 196);
            this->customerListBox->TabIndex = 6;
            // 
            // filteredCustomerListBox
            // 
            this->filteredCustomerListBox->FormattingEnabled = true;
            this->filteredCustomerListBox->ItemHeight = 16;
            this->filteredCustomerListBox->Location = System::Drawing::Point(502, 269);
            this->filteredCustomerListBox->Name = L"filteredCustomerListBox";
            this->filteredCustomerListBox->Size = System::Drawing::Size(391, 196);
            this->filteredCustomerListBox->TabIndex = 7;
            // 
            // nameLabel
            // 
            this->nameLabel->AutoSize = true;
            this->nameLabel->Location = System::Drawing::Point(69, 34);
            this->nameLabel->Name = L"nameLabel";
            this->nameLabel->Size = System::Drawing::Size(33, 16);
            this->nameLabel->TabIndex = 8;
            this->nameLabel->Text = L"Имя";
            // 
            // productTitleLabel
            // 
            this->productTitleLabel->AutoSize = true;
            this->productTitleLabel->Location = System::Drawing::Point(69, 71);
            this->productTitleLabel->Name = L"productTitleLabel";
            this->productTitleLabel->Size = System::Drawing::Size(123, 16);
            this->productTitleLabel->TabIndex = 9;
            this->productTitleLabel->Text = L"Название товара";
            // 
            // discountLabel
            // 
            this->discountLabel->AutoSize = true;
            this->discountLabel->Location = System::Drawing::Point(69, 108);
            this->discountLabel->Name = L"discountLabel";
            this->discountLabel->Size = System::Drawing::Size(54, 16);
            this->discountLabel->TabIndex = 10;
            this->discountLabel->Text = L"Скидка";
            // 
            // filterDiscountLabel
            // 
            this->filterDiscountLabel->AutoSize = true;
            this->filterDiscountLabel->Location = System::Drawing::Point(379, 202);
            this->filterDiscountLabel->Name = L"filterDiscountLabel";
            this->filterDiscountLabel->Size = System::Drawing::Size(104, 16);
            this->filterDiscountLabel->TabIndex = 11;
            this->filterDiscountLabel->Text = L"Фильтр скидки";
            // 
            // customerListLabel
            // 
            this->customerListLabel->AutoSize = true;
            this->customerListLabel->Location = System::Drawing::Point(54, 241);
            this->customerListLabel->Name = L"customerListLabel";
            this->customerListLabel->Size = System::Drawing::Size(119, 16);
            this->customerListLabel->TabIndex = 12;
            this->customerListLabel->Text = L"Список клиентов";
            this->customerListLabel->Click += gcnew System::EventHandler(this, &MainForm::customerListLabel_Click);
            // 
            // filteredListLabel
            // 
            this->filteredListLabel->AutoSize = true;
            this->filteredListLabel->Location = System::Drawing::Point(499, 241);
            this->filteredListLabel->Name = L"filteredListLabel";
            this->filteredListLabel->Size = System::Drawing::Size(188, 16);
            this->filteredListLabel->TabIndex = 13;
            this->filteredListLabel->Text = L"Отфильтрованные клиенты";
            // 
            // MainForm
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(8, 16);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(924, 503);
            this->Controls->Add(this->filteredListLabel);
            this->Controls->Add(this->customerListLabel);
            this->Controls->Add(this->filterDiscountLabel);
            this->Controls->Add(this->discountLabel);
            this->Controls->Add(this->productTitleLabel);
            this->Controls->Add(this->nameLabel);
            this->Controls->Add(this->filteredCustomerListBox);
            this->Controls->Add(this->customerListBox);
            this->Controls->Add(this->filterDiscountTextBox);
            this->Controls->Add(this->discountTextBox);
            this->Controls->Add(this->productTitleTextBox);
            this->Controls->Add(this->nameTextBox);
            this->Controls->Add(this->filterButton);
            this->Controls->Add(this->addButton);
            this->Name = L"MainForm";
            this->Text = L"Торговля продуктами питания";
            this->ResumeLayout(false);
            this->PerformLayout();

        }

        ref class Customer {
        public:
            String^ Name;
            String^ ProductTitle;
            double Discount;

            Customer(String^ name, String^ productTitle, double discount) {
                Name = name;
                ProductTitle = productTitle;
                Discount = discount;
            }
        };

        List<Customer^>^ customers = gcnew List<Customer^>();

        void addButton_Click(System::Object^ sender, System::EventArgs^ e) {
            String^ name = nameTextBox->Text;
            String^ productTitle = productTitleTextBox->Text;
            double discount = Double::Parse(discountTextBox->Text);

            Customer^ newCustomer = gcnew Customer(name, productTitle, discount);
            customers->Add(newCustomer);

            customerListBox->Items->Add("Имя: " + name + ", Товар: " + productTitle + ", Скидка: " + discount + "%");
        }

        void filterButton_Click(System::Object^ sender, System::EventArgs^ e) {
            filteredCustomerListBox->Items->Clear();
            double filterDiscount = Double::Parse(filterDiscountTextBox->Text);

            for each (Customer ^ customer in customers) {
                if (customer->Discount >= filterDiscount) {
                    filteredCustomerListBox->Items->Add(customer->ProductTitle);
                }
            }
        }

        void LoadDataFromDatabase() {
            String^ connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=FoodStoreDatabase.accdb;";
            String^ query = "SELECT * FROM Customers";

            OleDbConnection^ connection = gcnew OleDbConnection(connectionString);
            OleDbCommand^ command = gcnew OleDbCommand(query, connection);

            try {
                connection->Open();
                OleDbDataReader^ reader = command->ExecuteReader();
                while (reader->Read()) {
                    String^ name = reader["Name"]->ToString();
                    String^ productTitle = reader["ProductTitle"]->ToString();
                    double discount = Double::Parse(reader["Discount"]->ToString());

                    Customer^ customer = gcnew Customer(name, productTitle, discount);
                    customers->Add(customer);

                    customerListBox->Items->Add("Имя: " + name + ", Товар: " + productTitle + ", Скидка: " + discount + "%");
                }
                reader->Close();
            }
            catch (Exception^ ex) {
                MessageBox::Show("Ошибка подключения к базе данных: " + ex->Message);
            }
            finally {
                connection->Close();
            }
        }
    private: System::Void customerListLabel_Click(System::Object^ sender, System::EventArgs^ e) {
    }
};
}
