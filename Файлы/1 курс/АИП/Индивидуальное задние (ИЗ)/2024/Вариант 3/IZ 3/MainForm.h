#pragma once

#include "Customer.h"

namespace AirlineApp {
    using namespace System;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;

    public ref class MainForm : public System::Windows::Forms::Form {
    public:
        MainForm(void) {
            InitializeComponent();
            LoadInitialData();
        }

    protected:
        ~MainForm() {
            if (components) {
                delete components;
            }
        }

    private:
        System::Windows::Forms::Button^ filterButton;
        System::Windows::Forms::DateTimePicker^ startDatePicker;
        System::Windows::Forms::DateTimePicker^ endDatePicker;
        System::Windows::Forms::TextBox^ serviceTextBox;
        System::Windows::Forms::ListBox^ customerListBox;
        System::Windows::Forms::ListBox^ filteredCustomerListBox;
        System::Windows::Forms::Label^ startDateLabel;
        System::Windows::Forms::Label^ endDateLabel;
        System::Windows::Forms::Label^ serviceLabel;
        System::ComponentModel::Container^ components;

        void InitializeComponent(void) {
            this->filterButton = (gcnew System::Windows::Forms::Button());
            this->startDatePicker = (gcnew System::Windows::Forms::DateTimePicker());
            this->endDatePicker = (gcnew System::Windows::Forms::DateTimePicker());
            this->serviceTextBox = (gcnew System::Windows::Forms::TextBox());
            this->customerListBox = (gcnew System::Windows::Forms::ListBox());
            this->filteredCustomerListBox = (gcnew System::Windows::Forms::ListBox());
            this->startDateLabel = (gcnew System::Windows::Forms::Label());
            this->endDateLabel = (gcnew System::Windows::Forms::Label());
            this->serviceLabel = (gcnew System::Windows::Forms::Label());
            this->SuspendLayout();
            // 
            // filterButton
            // 
            this->filterButton->Location = System::Drawing::Point(410, 185);
            this->filterButton->Name = L"filterButton";
            this->filterButton->Size = System::Drawing::Size(200, 37);
            this->filterButton->TabIndex = 0;
            this->filterButton->Text = L"Filter";
            this->filterButton->UseVisualStyleBackColor = true;
            this->filterButton->Click += gcnew System::EventHandler(this, &MainForm::filterButton_Click);
            // 
            // startDatePicker
            // 
            this->startDatePicker->Format = System::Windows::Forms::DateTimePickerFormat::Short;
            this->startDatePicker->Location = System::Drawing::Point(200, 30);
            this->startDatePicker->Name = L"startDatePicker";
            this->startDatePicker->Size = System::Drawing::Size(200, 22);
            this->startDatePicker->TabIndex = 1;
            // 
            // endDatePicker
            // 
            this->endDatePicker->Format = System::Windows::Forms::DateTimePickerFormat::Short;
            this->endDatePicker->Location = System::Drawing::Point(200, 70);
            this->endDatePicker->Name = L"endDatePicker";
            this->endDatePicker->Size = System::Drawing::Size(200, 22);
            this->endDatePicker->TabIndex = 2;
            // 
            // serviceTextBox
            // 
            this->serviceTextBox->Location = System::Drawing::Point(200, 110);
            this->serviceTextBox->Name = L"serviceTextBox";
            this->serviceTextBox->Size = System::Drawing::Size(200, 22);
            this->serviceTextBox->TabIndex = 3;
            // 
            // customerListBox
            // 
            this->customerListBox->FormattingEnabled = true;
            this->customerListBox->ItemHeight = 16;
            this->customerListBox->Location = System::Drawing::Point(667, 30);
            this->customerListBox->Name = L"customerListBox";
            this->customerListBox->Size = System::Drawing::Size(599, 196);
            this->customerListBox->TabIndex = 4;
            // 
            // filteredCustomerListBox
            // 
            this->filteredCustomerListBox->FormattingEnabled = true;
            this->filteredCustomerListBox->ItemHeight = 16;
            this->filteredCustomerListBox->Location = System::Drawing::Point(667, 272);
            this->filteredCustomerListBox->Name = L"filteredCustomerListBox";
            this->filteredCustomerListBox->Size = System::Drawing::Size(599, 196);
            this->filteredCustomerListBox->TabIndex = 5;
            // 
            // startDateLabel
            // 
            this->startDateLabel->AutoSize = true;
            this->startDateLabel->Location = System::Drawing::Point(40, 30);
            this->startDateLabel->Name = L"startDateLabel";
            this->startDateLabel->Size = System::Drawing::Size(108, 16);
            this->startDateLabel->TabIndex = 6;
            this->startDateLabel->Text = L"Start time interval";
            // 
            // endDateLabel
            // 
            this->endDateLabel->AutoSize = true;
            this->endDateLabel->Location = System::Drawing::Point(40, 70);
            this->endDateLabel->Name = L"endDateLabel";
            this->endDateLabel->Size = System::Drawing::Size(105, 16);
            this->endDateLabel->TabIndex = 7;
            this->endDateLabel->Text = L"End time interval";
            // 
            // serviceLabel
            // 
            this->serviceLabel->AutoSize = true;
            this->serviceLabel->Location = System::Drawing::Point(40, 110);
            this->serviceLabel->Name = L"serviceLabel";
            this->serviceLabel->Size = System::Drawing::Size(126, 16);
            this->serviceLabel->TabIndex = 8;
            this->serviceLabel->Text = L"Name of the service";
            // 
            // MainForm
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(8, 16);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(1335, 565);
            this->Controls->Add(this->serviceLabel);
            this->Controls->Add(this->endDateLabel);
            this->Controls->Add(this->startDateLabel);
            this->Controls->Add(this->filteredCustomerListBox);
            this->Controls->Add(this->customerListBox);
            this->Controls->Add(this->serviceTextBox);
            this->Controls->Add(this->endDatePicker);
            this->Controls->Add(this->startDatePicker);
            this->Controls->Add(this->filterButton);
            this->Name = L"MainForm";
            this->Text = L"Airline Ticket Management";
            this->ResumeLayout(false);
            this->PerformLayout();

        }

        void LoadInitialData() {
            Customer^ customer1 = gcnew Customer("John Doe", 1);
            Order^ order1 = gcnew Order(DateTime(2024, 6, 1));
            order1->AddService(gcnew Service("Extra Baggage"));
            customer1->Orders->Add(order1);

            Customer^ customer2 = gcnew Customer("Jane Smith", 2);
            Order^ order2 = gcnew Order(DateTime(2024, 6, 10));
            order2->AddService(gcnew Service("Priority Boarding"));
            customer2->Orders->Add(order2);

            Customer^ customer3 = gcnew Customer("Gerald Fitzgerald", 3);
            Order^ order3 = gcnew Order(DateTime(2024, 6, 11));
            order3->AddService(gcnew Service("Business Lounge"));
            customer3->Orders->Add(order3);

            Customer^ customer4 = gcnew Customer("Darlene Wright", 4);
            Order^ order4 = gcnew Order(DateTime(2024, 6, 12));
            order4->AddService(gcnew Service("Extra Baggage"));
            customer4->Orders->Add(order4);

            Customer^ customer5 = gcnew Customer("Mary Perez", 5);
            Order^ order5 = gcnew Order(DateTime(2024, 6, 13));
            order5->AddService(gcnew Service("Priority Boarding"));
            customer5->Orders->Add(order5);

            Customer^ customer6 = gcnew Customer("Maria Brown", 6);
            Order^ order6 = gcnew Order(DateTime(2024, 6, 14));
            order6->AddService(gcnew Service("Business Lounge"));
            customer6->Orders->Add(order6);

           

            customerListBox->Items->Add("Name: " + customer1->Name + " , service: Extra Baggage");
            customerListBox->Items->Add("Name: " + customer2->Name + " , service: Priority Boarding");
            customerListBox->Items->Add("Name: " + customer3->Name + " , service: Business Lounge");
            customerListBox->Items->Add("Name: " + customer4->Name + " , service: Extra Baggage");
            customerListBox->Items->Add("Name: " + customer5->Name + " , service: Priority Boarding");
            customerListBox->Items->Add("Name: " + customer6->Name + " , service: Business Lounge");
        }

        void filterButton_Click(Object^ sender, EventArgs^ e) {
            DateTime startDate = startDatePicker->Value;
            DateTime endDate = endDatePicker->Value;
            String^ serviceName = serviceTextBox->Text;

            filteredCustomerListBox->Items->Clear();

            for each (Customer ^ customer in GetDummyCustomers()) {
                for each (Order ^ order in customer->Orders) {
                    if (order->OrderDate >= startDate && order->OrderDate <= endDate) {
                        for each (Service ^ service in order->Services) {
                            if (service->ServiceName->Contains(serviceName)) {
                                filteredCustomerListBox->Items->Add(customer->Name);
                                break;
                            }
                        }
                    }
                }
            }
        }

        List<Customer^>^ GetDummyCustomers() {
            List<Customer^>^ customers = gcnew List<Customer^>();

            Customer^ customer1 = gcnew Customer("John Doe", 1);
            Order^ order1 = gcnew Order(DateTime(2024, 6, 1));
            order1->AddService(gcnew Service("Extra Baggage"));
            customer1->Orders->Add(order1);

            Customer^ customer2 = gcnew Customer("Jane Smith", 2);
            Order^ order2 = gcnew Order(DateTime(2024, 6, 10));
            order2->AddService(gcnew Service("Priority Boarding"));
            customer2->Orders->Add(order2);

            Customer^ customer3 = gcnew Customer("Gerald Fitzgerald", 3);
            Order^ order3 = gcnew Order(DateTime(2024, 6, 11));
            order3->AddService(gcnew Service("Business Lounge"));
            customer3->Orders->Add(order3);

            Customer^ customer4 = gcnew Customer("Darlene Wright", 4);
            Order^ order4 = gcnew Order(DateTime(2024, 6, 12));
            order4->AddService(gcnew Service("Extra Baggage"));
            customer4->Orders->Add(order4);

            Customer^ customer5 = gcnew Customer("Mary Perez", 5);
            Order^ order5 = gcnew Order(DateTime(2024, 6, 13));
            order5->AddService(gcnew Service("Priority Boarding"));
            customer5->Orders->Add(order5);

            Customer^ customer6 = gcnew Customer("Maria Brown", 6);
            Order^ order6 = gcnew Order(DateTime(2024, 6, 14));
            order6->AddService(gcnew Service("Business Lounge"));
            customer6->Orders->Add(order6);

            customers->Add(customer1);
            customers->Add(customer2);
            customers->Add(customer3);
            customers->Add(customer4);
            customers->Add(customer5);
            customers->Add(customer6);

            return customers;
        }
    };
}
