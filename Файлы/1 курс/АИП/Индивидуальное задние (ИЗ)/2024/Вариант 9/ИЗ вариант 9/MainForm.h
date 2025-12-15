#pragma once
#include "Customer.h"
#include <cliext/list>

namespace TaxiApp {

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
        System::Windows::Forms::TextBox^ destinationTextBox;
        System::Windows::Forms::TextBox^ discountTextBox;
        System::Windows::Forms::TextBox^ filterDestinationTextBox;
        System::Windows::Forms::TextBox^ filterDiscountTextBox;
        System::Windows::Forms::ListBox^ orderListBox;
        System::Windows::Forms::ListBox^ filteredOrderListBox;
        System::Windows::Forms::Label^ nameLabel;
        System::Windows::Forms::Label^ destinationLabel;
        System::Windows::Forms::Label^ discountLabel;
        System::Windows::Forms::Label^ filterDestinationLabel;
        System::Windows::Forms::Label^ filterDiscountLabel;
        System::Windows::Forms::Label^ orderListLabel;
        System::Windows::Forms::Label^ filteredListLabel;
        System::ComponentModel::Container^ components;

        void InitializeComponent(void) {
            this->addButton = (gcnew System::Windows::Forms::Button());
            this->filterButton = (gcnew System::Windows::Forms::Button());
            this->filterDestinationTextBox = (gcnew System::Windows::Forms::TextBox());
            this->filterDiscountTextBox = (gcnew System::Windows::Forms::TextBox());
            this->orderListBox = (gcnew System::Windows::Forms::ListBox());
            this->filteredOrderListBox = (gcnew System::Windows::Forms::ListBox());
            this->nameLabel = (gcnew System::Windows::Forms::Label());
            this->destinationLabel = (gcnew System::Windows::Forms::Label());
            this->discountLabel = (gcnew System::Windows::Forms::Label());
            this->filterDestinationLabel = (gcnew System::Windows::Forms::Label());
            this->filterDiscountLabel = (gcnew System::Windows::Forms::Label());
            this->orderListLabel = (gcnew System::Windows::Forms::Label());
            this->filteredListLabel = (gcnew System::Windows::Forms::Label());
            this->SuspendLayout();
            // 
            // addButton
            // 
            this->addButton->Location = System::Drawing::Point(0, 0);
            this->addButton->Name = L"addButton";
            this->addButton->Size = System::Drawing::Size(75, 23);
            this->addButton->TabIndex = 19;
            // 
            // filterButton
            // 
            this->filterButton->Location = System::Drawing::Point(480, 256);
            this->filterButton->Name = L"filterButton";
            this->filterButton->Size = System::Drawing::Size(200, 37);
            this->filterButton->TabIndex = 1;
            this->filterButton->Text = L"Фильтровать";
            this->filterButton->UseVisualStyleBackColor = true;
            this->filterButton->Click += gcnew System::EventHandler(this, &MainForm::filterButton_Click);
            // 
            // filterDestinationTextBox
            // 
            this->filterDestinationTextBox->Location = System::Drawing::Point(696, 315);
            this->filterDestinationTextBox->Name = L"filterDestinationTextBox";
            this->filterDestinationTextBox->Size = System::Drawing::Size(159, 22);
            this->filterDestinationTextBox->TabIndex = 5;
            // 
            // filterDiscountTextBox
            // 
            this->filterDiscountTextBox->Location = System::Drawing::Point(696, 364);
            this->filterDiscountTextBox->Name = L"filterDiscountTextBox";
            this->filterDiscountTextBox->Size = System::Drawing::Size(159, 22);
            this->filterDiscountTextBox->TabIndex = 6;
            this->filterDiscountTextBox->TextChanged += gcnew System::EventHandler(this, &MainForm::filterDiscountTextBox_TextChanged);
            // 
            // orderListBox
            // 
            this->orderListBox->FormattingEnabled = true;
            this->orderListBox->ItemHeight = 16;
            this->orderListBox->Location = System::Drawing::Point(30, 42);
            this->orderListBox->Name = L"orderListBox";
            this->orderListBox->Size = System::Drawing::Size(444, 180);
            this->orderListBox->TabIndex = 7;
            // 
            // filteredOrderListBox
            // 
            this->filteredOrderListBox->FormattingEnabled = true;
            this->filteredOrderListBox->ItemHeight = 16;
            this->filteredOrderListBox->Location = System::Drawing::Point(30, 256);
            this->filteredOrderListBox->Name = L"filteredOrderListBox";
            this->filteredOrderListBox->Size = System::Drawing::Size(444, 180);
            this->filteredOrderListBox->TabIndex = 8;
            // 
            // nameLabel
            // 
            this->nameLabel->Location = System::Drawing::Point(0, 0);
            this->nameLabel->Name = L"nameLabel";
            this->nameLabel->Size = System::Drawing::Size(100, 23);
            this->nameLabel->TabIndex = 18;
            // 
            // destinationLabel
            // 
            this->destinationLabel->Location = System::Drawing::Point(0, 0);
            this->destinationLabel->Name = L"destinationLabel";
            this->destinationLabel->Size = System::Drawing::Size(100, 23);
            this->destinationLabel->TabIndex = 17;
            // 
            // discountLabel
            // 
            this->discountLabel->Location = System::Drawing::Point(0, 0);
            this->discountLabel->Name = L"discountLabel";
            this->discountLabel->Size = System::Drawing::Size(100, 23);
            this->discountLabel->TabIndex = 16;
            // 
            // filterDestinationLabel
            // 
            this->filterDestinationLabel->AutoSize = true;
            this->filterDestinationLabel->Location = System::Drawing::Point(477, 318);
            this->filterDestinationLabel->Name = L"filterDestinationLabel";
            this->filterDestinationLabel->Size = System::Drawing::Size(209, 16);
            this->filterDestinationLabel->TabIndex = 12;
            this->filterDestinationLabel->Text = L"Фильтр по пункту назначения:";
            this->filterDestinationLabel->Click += gcnew System::EventHandler(this, &MainForm::filterDestinationLabel_Click);
            // 
            // filterDiscountLabel
            // 
            this->filterDiscountLabel->AutoSize = true;
            this->filterDiscountLabel->Location = System::Drawing::Point(554, 367);
            this->filterDiscountLabel->Name = L"filterDiscountLabel";
            this->filterDiscountLabel->Size = System::Drawing::Size(126, 16);
            this->filterDiscountLabel->TabIndex = 13;
            this->filterDiscountLabel->Text = L"Фильтр по скидке:";
            // 
            // orderListLabel
            // 
            this->orderListLabel->AutoSize = true;
            this->orderListLabel->Location = System::Drawing::Point(27, 9);
            this->orderListLabel->Name = L"orderListLabel";
            this->orderListLabel->Size = System::Drawing::Size(115, 16);
            this->orderListLabel->TabIndex = 14;
            this->orderListLabel->Text = L"Список заказов:";
            // 
            // filteredListLabel
            // 
            this->filteredListLabel->AutoSize = true;
            this->filteredListLabel->Location = System::Drawing::Point(27, 237);
            this->filteredListLabel->Name = L"filteredListLabel";
            this->filteredListLabel->Size = System::Drawing::Size(184, 16);
            this->filteredListLabel->TabIndex = 15;
            this->filteredListLabel->Text = L"Отфильтрованные заказы:";
            this->filteredListLabel->Click += gcnew System::EventHandler(this, &MainForm::filteredListLabel_Click);
            // 
            // MainForm
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(8, 16);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(867, 450);
            this->Controls->Add(this->filteredListLabel);
            this->Controls->Add(this->orderListLabel);
            this->Controls->Add(this->filterDiscountLabel);
            this->Controls->Add(this->filterDestinationLabel);
            this->Controls->Add(this->discountLabel);
            this->Controls->Add(this->destinationLabel);
            this->Controls->Add(this->nameLabel);
            this->Controls->Add(this->filteredOrderListBox);
            this->Controls->Add(this->orderListBox);
            this->Controls->Add(this->filterDiscountTextBox);
            this->Controls->Add(this->filterDestinationTextBox);
            this->Controls->Add(this->filterButton);
            this->Controls->Add(this->addButton);
            this->Name = L"MainForm";
            this->Text = L"Заказ такси";
            this->ResumeLayout(false);
            this->PerformLayout();

        }

        void filterButton_Click(System::Object^ sender, System::EventArgs^ e) {
            try {
                String^ filterDestination = filterDestinationTextBox->Text;
                double filterDiscount = Double::Parse(filterDiscountTextBox->Text);

                filteredOrderListBox->Items->Clear();
                for each (String ^ order in orderListBox->Items) {
                    if (order->Contains(filterDestination) && order->Contains(filterDiscount.ToString())) {
                        filteredOrderListBox->Items->Add(order);
                    }
                }
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message);
            }
        }

        void LoadDataFromDatabase() {
            try {
                // Создание строки подключения
                String^ connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=TaxiAppDatabase.accdb;";
                OleDbConnection^ conn = gcnew OleDbConnection(connString);

                // Открытие соединения
                conn->Open();

                // Создание SQL-запроса
                String^ query = "SELECT * FROM Orders";
                OleDbCommand^ cmd = gcnew OleDbCommand(query, conn);
                OleDbDataReader^ reader = cmd->ExecuteReader();

                // Чтение данных из базы данных
                while (reader->Read()) {
                    String^ name = reader["CustomerName"]->ToString();
                    String^ destination = reader["Destination"]->ToString();
                    double discount = Convert::ToDouble(reader["Discount"]);

                    // Создание объектов Customer и Order
                    Customer^ customer = gcnew Customer(name, discount);
                    customer->Order->AddDestinationOrder(gcnew DestinationOrder(destination));

                    // Добавление данных в ListBox
                    orderListBox->Items->Add(String::Format("Имя: {0}, Пункт назначения: {1}, Скидка: {2}", customer->Name, destination, customer->Discount));
                }

                // Закрытие соединения
                reader->Close();
                conn->Close();
            }
            catch (Exception^ ex) {
                MessageBox::Show(ex->Message);
            }
        }
    private: System::Void filterDestinationLabel_Click(System::Object^ sender, System::EventArgs^ e) {
    }
private: System::Void filteredListLabel_Click(System::Object^ sender, System::EventArgs^ e) {
}
private: System::Void filterDiscountTextBox_TextChanged(System::Object^ sender, System::EventArgs^ e) {
}
};
}
    