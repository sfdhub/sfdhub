using OOP5;
using System.Runtime.Intrinsics.Arm;
using System.Security.Cryptography;
using System.Text;
using System.Windows.Forms;

namespace OOP6
{
    public partial class Form1 : Form
    {
        Shape[] shapes = { null, null };

        private void UpdateFigureInfo()
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 2; i++)
            {
                sb.Append($"Фигура {i + 1}:");
                if (shapes[i] == null)
                    sb.Append(" Не создана");
                else
                {
                    sb.Append('\n');
                    sb.Append("Тип: " + shapes[i].ID);
                    sb.Append('\n');
                    sb.Append("Площадь: " + shapes[i].GetArea());
                    sb.Append('\n');
                    sb.Append("Координаты: ");
                    sb.Append('\n');
                    foreach (var p in shapes[i].GetPoints())
                    {
                        sb.Append($"X: {p.X} Y: {p.Y}");
                        sb.Append('\n');
                    }
                }

                if (i == 0)
                    fig1Text.Text = sb.ToString();
                else
                    fig2Text.Text = sb.ToString();
                sb.Clear();
            }

        }

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            UpdateFigureInfo();

        }

        private bool isFirstFigure()
        {
            DialogResult dialogResult = MessageBox.Show("Хотите изменить первую фигуру (да) или вторую (нет)", "Выбор фигуры", MessageBoxButtons.YesNo);
            if (dialogResult == DialogResult.Yes)
                return true;
            return false;
        }

        // Create
        private void button8_Click(object sender, EventArgs e)
        {
            CreateDialog cd = new CreateDialog();
            if (cd.ShowDialog() == DialogResult.OK)
            {
                shapes[isFirstFigure() ? 0 : 1] = cd.shape;
                UpdateFigureInfo();
            }
        }

        // Remove
        private void button7_Click(object sender, EventArgs e)
        {
            shapes[isFirstFigure() ? 0 : 1] = null;
            UpdateFigureInfo();
        }

        // Swap
        private void button2_Click(object sender, EventArgs e)
        {
            Shape tmp;
            tmp = shapes[0];
            shapes[0] = shapes[1];
            shapes[1] = tmp;
            UpdateFigureInfo();
        }


        // Diff
        private void button4_Click(object sender, EventArgs e)
        {
            if (shapes[0] == null || shapes[1] == null)
            {
                MessageBox.Show("Фигуры ещё не сформированы", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (Operations.IsBigger(shapes[0], shapes[1]))
                MessageBox.Show("Первая фигура больше по площади", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else if (Operations.IsLess(shapes[0], shapes[1]))
                MessageBox.Show("Первая фигура меньше по площади", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show("Фигуры равны по площади", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        // IsInclude
        private void button3_Click(object sender, EventArgs e)
        {
            if (shapes[0] == null || shapes[1] == null)
            {
                MessageBox.Show("Фигуры ещё не сформированы", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (Operations.IsInclude(shapes[0], shapes[1]))
                MessageBox.Show("Первая фигура включает вторую", "Проверка включения", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else if (Operations.IsInclude(shapes[1], shapes[0]))
                MessageBox.Show("Вторая фигура включает первую", "Проверка включения", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show("Не включает", "Проверка включения", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        // Rotate
        private void button5_Click(object sender, EventArgs e)
        {
            bool isFirst = isFirstFigure();
            if (shapes[isFirst ? 0 : 1] == null)
            {
                MessageBox.Show("Фигура ещё не сформирована", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            shapes[isFirst ? 0 : 1].Rotate((float)angle.Value);
            UpdateFigureInfo();
        }

        // Move
        private void button6_Click(object sender, EventArgs e)
        {
            bool isFirst = isFirstFigure();
            if (shapes[isFirst ? 0 : 1] == null)
            {
                MessageBox.Show("Фигура ещё не сформирована", "Сравнить фигуры", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            shapes[isFirst ? 0 : 1].Move(new OOP5.Point((float)X.Value, (float)Y.Value));
            UpdateFigureInfo();
        }
    }
}
