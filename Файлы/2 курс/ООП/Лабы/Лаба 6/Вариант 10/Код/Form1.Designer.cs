namespace OOP6
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            button1 = new Button();
            button2 = new Button();
            button3 = new Button();
            button4 = new Button();
            button5 = new Button();
            button6 = new Button();
            button7 = new Button();
            button8 = new Button();
            fig1Text = new Label();
            fig2Text = new Label();
            Y = new NumericUpDown();
            X = new NumericUpDown();
            angle = new NumericUpDown();
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            ((System.ComponentModel.ISupportInitialize)Y).BeginInit();
            ((System.ComponentModel.ISupportInitialize)X).BeginInit();
            ((System.ComponentModel.ISupportInitialize)angle).BeginInit();
            SuspendLayout();
            // 
            // button1
            // 
            button1.Location = new Point(544, 14);
            button1.Name = "button1";
            button1.Size = new Size(94, 29);
            button1.TabIndex = 0;
            button1.Text = "Выход";
            button1.UseVisualStyleBackColor = true;
            // 
            // button2
            // 
            button2.Location = new Point(482, 339);
            button2.Name = "button2";
            button2.Size = new Size(161, 29);
            button2.TabIndex = 1;
            button2.Text = "Поменять местами";
            button2.UseVisualStyleBackColor = true;
            button2.Click += button2_Click;
            // 
            // button3
            // 
            button3.Location = new Point(482, 201);
            button3.Name = "button3";
            button3.Size = new Size(161, 29);
            button3.TabIndex = 2;
            button3.Text = "Включает ли фигура";
            button3.UseVisualStyleBackColor = true;
            button3.Click += button3_Click;
            // 
            // button4
            // 
            button4.Location = new Point(482, 236);
            button4.Name = "button4";
            button4.Size = new Size(161, 29);
            button4.TabIndex = 3;
            button4.Text = "Сравнить фигуры";
            button4.UseVisualStyleBackColor = true;
            button4.Click += button4_Click;
            // 
            // button5
            // 
            button5.Location = new Point(482, 372);
            button5.Name = "button5";
            button5.Size = new Size(161, 29);
            button5.TabIndex = 4;
            button5.Text = "Повернуть фигуру";
            button5.UseVisualStyleBackColor = true;
            button5.Click += button5_Click;
            // 
            // button6
            // 
            button6.Location = new Point(477, 406);
            button6.Name = "button6";
            button6.Size = new Size(161, 29);
            button6.TabIndex = 5;
            button6.Text = "Переместить фигуру";
            button6.UseVisualStyleBackColor = true;
            button6.Click += button6_Click;
            // 
            // button7
            // 
            button7.Location = new Point(499, 84);
            button7.Name = "button7";
            button7.Size = new Size(144, 29);
            button7.TabIndex = 6;
            button7.Text = "Удалить фигуру";
            button7.UseVisualStyleBackColor = true;
            button7.Click += button7_Click;
            // 
            // button8
            // 
            button8.Location = new Point(499, 49);
            button8.Name = "button8";
            button8.Size = new Size(144, 29);
            button8.TabIndex = 7;
            button8.Text = "Создать фигуру";
            button8.UseVisualStyleBackColor = true;
            button8.Click += button8_Click;
            // 
            // fig1Text
            // 
            fig1Text.AutoSize = true;
            fig1Text.Location = new Point(23, 14);
            fig1Text.Name = "fig1Text";
            fig1Text.Size = new Size(157, 20);
            fig1Text.TabIndex = 8;
            fig1Text.Text = "Фигура 1: Не создана\r\n";
            // 
            // fig2Text
            // 
            fig2Text.AutoSize = true;
            fig2Text.Location = new Point(287, 14);
            fig2Text.Name = "fig2Text";
            fig2Text.Size = new Size(157, 20);
            fig2Text.TabIndex = 9;
            fig2Text.Text = "Фигура 2: Не создана\r\n";
            // 
            // Y
            // 
            Y.Location = new Point(409, 405);
            Y.Maximum = new decimal(new int[] { 999, 0, 0, 0 });
            Y.Minimum = new decimal(new int[] { 999, 0, 0, int.MinValue });
            Y.Name = "Y";
            Y.Size = new Size(67, 27);
            Y.TabIndex = 10;
            // 
            // X
            // 
            X.Location = new Point(332, 407);
            X.Maximum = new decimal(new int[] { 999, 0, 0, 0 });
            X.Minimum = new decimal(new int[] { 999, 0, 0, int.MinValue });
            X.Name = "X";
            X.Size = new Size(57, 27);
            X.TabIndex = 11;
            // 
            // angle
            // 
            angle.Location = new Point(409, 374);
            angle.Maximum = new decimal(new int[] { 360, 0, 0, 0 });
            angle.Minimum = new decimal(new int[] { 1, 0, 0, 0 });
            angle.Name = "angle";
            angle.Size = new Size(67, 27);
            angle.TabIndex = 12;
            angle.Value = new decimal(new int[] { 1, 0, 0, 0 });
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(365, 377);
            label1.Name = "label1";
            label1.Size = new Size(44, 20);
            label1.TabIndex = 13;
            label1.Text = "Угол:";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(314, 410);
            label2.Name = "label2";
            label2.Size = new Size(21, 20);
            label2.TabIndex = 14;
            label2.Text = "X:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(392, 410);
            label3.Name = "label3";
            label3.Size = new Size(20, 20);
            label3.TabIndex = 15;
            label3.Text = "Y:";
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(655, 450);
            Controls.Add(label1);
            Controls.Add(angle);
            Controls.Add(X);
            Controls.Add(Y);
            Controls.Add(fig2Text);
            Controls.Add(fig1Text);
            Controls.Add(button8);
            Controls.Add(button7);
            Controls.Add(button6);
            Controls.Add(button5);
            Controls.Add(button4);
            Controls.Add(button3);
            Controls.Add(button2);
            Controls.Add(button1);
            Controls.Add(label2);
            Controls.Add(label3);
            Name = "Form1";
            Text = "Лабараторная работа 6";
            Load += Form1_Load;
            ((System.ComponentModel.ISupportInitialize)Y).EndInit();
            ((System.ComponentModel.ISupportInitialize)X).EndInit();
            ((System.ComponentModel.ISupportInitialize)angle).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button button1;
        private Button button2;
        private Button button3;
        private Button button4;
        private Button button5;
        private Button button6;
        private Button button7;
        private Button button8;
        private Label fig1Text;
        private Label fig2Text;
        private NumericUpDown Y;
        private NumericUpDown X;
        private NumericUpDown angle;
        private Label label1;
        private Label label2;
        private Label label3;
    }
}
