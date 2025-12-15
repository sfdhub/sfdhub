#pragma once
#include "Fruit.h"
#include "Warehouse.h"
#include "SupplyOrder.h"
#include <cliext/list>

namespace WarehouseApp {

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
        System::Windows::Forms::Button^ searchButton;
        System::Windows::Forms::TextBox^ warehouseTextBox;
        System::Windows::Forms::TextBox^ orderNumberTextBox;
        System::Windows::Forms::ListBox^ resultListBox;
        System::Windows::Forms::TextBox^ databaseTextBox;
        System::Windows::Forms::Label^ warehouseLabel;
        System::Windows::Forms::Label^ orderNumberLabel;
        System::ComponentModel::Container^ components;

        void InitializeComponent(void) {
            this->searchButton = (gcnew System::Windows::Forms::Button());
            this->warehouseTextBox = (gcnew System::Windows::Forms::TextBox());
            this->orderNumberTextBox = (gcnew System::Windows::Forms::TextBox());
            this->resultListBox = (gcnew System::Windows::Forms::ListBox());
            this->databaseTextBox = (gcnew System::Windows::Forms::TextBox());
            this->warehouseLabel = (gcnew System::Windows::Forms::Label());
            this->orderNumberLabel = (gcnew System::Windows::Forms::Label());
            this->SuspendLayout();
            // 
            // searchButton
            // 
            this->searchButton->Location = System::Drawing::Point(480, 256);
            this->searchButton->Name = L"searchButton";
            this->searchButton->Size = System::Drawing::Size(200, 37);
            this->searchButton->TabIndex = 1;
            this->searchButton->Text = L"Поиск";
            this->searchButton->UseVisualStyleBackColor = true;
            this->searchButton->Click += gcnew System::EventHandler(this, &MainForm::searchButton_Click);
            // 
            // warehouseTextBox
            // 
            this->warehouseTextBox->Location = System::Drawing::Point(696, 315);
            this->warehouseTextBox->Name = L"warehouseTextBox";
            this->warehouseTextBox->Size = System::Drawing::Size(159, 22);
            this->warehouseTextBox->TabIndex = 5;
            // 
            // orderNumberTextBox
            // 
            this->orderNumberTextBox->Location = System::Drawing::Point(696, 364);
            this->orderNumberTextBox->Name = L"orderNumberTextBox";
            this->orderNumberTextBox->Size = System::Drawing::Size(159, 22);
            this->orderNumberTextBox->TabIndex = 6;
            // 
            // resultListBox
            // 
            this->resultListBox->FormattingEnabled = true;
            this->resultListBox->ItemHeight = 16;
            this->resultListBox->Location = System::Drawing::Point(30, 42);
            this->resultListBox->Name = L"resultListBox";
            this->resultListBox->Size = System::Drawing::Size(444, 180);
            this->resultListBox->TabIndex = 7;
            // 
            // databaseTextBox
            // 
            this->databaseTextBox->Location = System::Drawing::Point(30, 250);
            this->databaseTextBox->Multiline = true;
            this->databaseTextBox->Name = L"databaseTextBox";
            this->databaseTextBox->ReadOnly = true;
            this->databaseTextBox->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;
            this->databaseTextBox->Size = System::Drawing::Size(444, 200);
            this->databaseTextBox->TabIndex = 14;
            // 
            // warehouseLabel
            // 
            this->warehouseLabel->AutoSize = true;
            this->warehouseLabel->Location = System::Drawing::Point(532, 315);
            this->warehouseLabel->Name = L"warehouseLabel";
            this->warehouseLabel->Size = System::Drawing::Size(125, 16);
            this->warehouseLabel->TabIndex = 12;
            this->warehouseLabel->Text = L"Название склада:";
            // 
            // orderNumberLabel
            // 
            this->orderNumberLabel->AutoSize = true;
            this->orderNumberLabel->Location = System::Drawing::Point(554, 367);
            this->orderNumberLabel->Name = L"orderNumberLabel";
            this->orderNumberLabel->Size = System::Drawing::Size(103, 16);
            this->orderNumberLabel->TabIndex = 13;
            this->orderNumberLabel->Text = L"Номер заказа:";
            // 
            // MainForm
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(8, 16);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(867, 450);
            this->Controls->Add(this->databaseTextBox);
            this->Controls->Add(this->orderNumberLabel);
            this->Controls->Add(this->warehouseLabel);
            this->Controls->Add(this->resultListBox);
            this->Controls->Add(this->orderNumberTextBox);
            this->Controls->Add(this->warehouseTextBox);
            this->Controls->Add(this->searchButton);
            this->Name = L"MainForm";
            this->Text = L"Складской учет фруктов";
            this->ResumeLayout(false);
            this->PerformLayout();

        }

        void searchButton_Click(System::Object^ sender, System::EventArgs^ e) {
            try {
                String^ warehouseName = warehouseTextBox->Text;
                int orderNumber = Int32::Parse(orderNumberTextBox->Text);

                resultListBox->Items->Clear();
                for each (Warehouse ^ warehouse in warehouses) {
                    if (warehouse->Name->Equals(warehouseName)) {
                        for each (SupplyOrder ^ order in orders) {
                            if (order->OrderNumber == orderNumber) {
                                for each (String ^ fruit in order->Fruits) {
                                    if (warehouse->Fruits->Contains(fruit)) {
                                        resultListBox->Items->Add(fruit);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception^ ex) {
                MessageBox::Show("Error: " + ex->Message);
            }
        }

        List<Warehouse^>^ warehouses;
        List<SupplyOrder^>^ orders;

        void LoadDataFromDatabase() {
            warehouses = gcnew List<Warehouse^>();
            orders = gcnew List<SupplyOrder^>();

            String^ connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=warehouse.mdb;";
            OleDbConnection^ connection = gcnew OleDbConnection(connectionString);

            try {
                connection->Open();
                // Load data from the single table "Inventory"
                OleDbCommand^ command = gcnew OleDbCommand("SELECT * FROM Inventory", connection);
                OleDbDataReader^ reader = command->ExecuteReader();

                while (reader->Read()) {
                    String^ warehouseName = reader["WarehouseName"]->ToString();
                    int orderNumber = Convert::ToInt32(reader["OrderNumber"]);
                    String^ fruitName = reader["FruitName"]->ToString();

                    Warehouse^ warehouse = nullptr;
                    for each (Warehouse ^ wh in warehouses) {
                        if (wh->Name->Equals(warehouseName)) {
                            warehouse = wh;
                            break;
                        }
                    }
                    if (warehouse == nullptr) {
                        warehouse = gcnew Warehouse(warehouseName);
                        warehouses->Add(warehouse);
                    }
                    warehouse->AddFruit(fruitName);

                    SupplyOrder^ order = nullptr;
                    for each (SupplyOrder ^ so in orders) {
                        if (so->OrderNumber == orderNumber) {
                            order = so;
                            break;
                        }
                    }
                    if (order == nullptr) {
                        order = gcnew SupplyOrder(orderNumber);
                        orders->Add(order);
                    }
                    order->AddFruit(fruitName);
                }

                reader->Close();

                // Display loaded data in databaseTextBox
                databaseTextBox->Text = "";
                databaseTextBox->AppendText("Склады:\r\n");
                for each (Warehouse ^ warehouse in warehouses) {
                    databaseTextBox->AppendText(" - " + warehouse->Name + "\r\n");
                    for each (String ^ fruit in warehouse->Fruits) {
                        databaseTextBox->AppendText("   * " + fruit + "\r\n");
                    }
                }

                databaseTextBox->AppendText("\r\nЗаказы на поставку:\r\n");
                for each (SupplyOrder ^ order in orders) {
                    databaseTextBox->AppendText("Заказ #" + order->OrderNumber + "\r\n");
                    for each (String ^ fruit in order->Fruits) {
                        databaseTextBox->AppendText("   * " + fruit + "\r\n");
                    }
                }
            }
            catch (Exception^ ex) {
                MessageBox::Show("Ошибка БД: " + ex->Message);
            }
            finally {
                connection->Close();
            }
        }
    };
}
