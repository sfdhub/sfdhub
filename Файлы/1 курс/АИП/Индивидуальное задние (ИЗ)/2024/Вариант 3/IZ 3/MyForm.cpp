#include "MainForm.h"

using namespace System;
using namespace System::Windows::Forms;
using namespace AirlineApp;

[STAThread]
void main(array<String^>^ args) {
    Application::EnableVisualStyles();
    Application::SetCompatibleTextRenderingDefault(false);

    Application::Run(gcnew MainForm());
}
