using OOP5;
using Point = OOP5.Point;

namespace OOP6
{
    public partial class CreateDialog : Form
    {
        public Shape shape { get; set; }

        public CreateDialog()
        {
            InitializeComponent(); 
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex == 0)
            {
                float x = (float)numericUpDown1.Value, y = (float)numericUpDown2.Value;
                float a2 = (float)numericUpDown3.Value / 2;
                shape = new Square(new Point(x - a2, y + a2), new Point(x + a2, y + a2), new Point(x + a2, y - a2), new Point(x - a2, y - a2));
                
            }
            else
            {
                shape = new Hexagon(new Point((float)numericUpDown3.Value, (float)numericUpDown4.Value), new Point((float)numericUpDown5.Value, (float)numericUpDown6.Value), new Point((float)numericUpDown7.Value, (float)numericUpDown8.Value), new Point((float)numericUpDown9.Value, (float)numericUpDown10.Value), new Point((float)numericUpDown11.Value, (float)numericUpDown12.Value), new Point((float)numericUpDown13.Value, (float)numericUpDown14.Value));
            }

            this.DialogResult = DialogResult.OK;
            this.Close();
        }
    }
}
