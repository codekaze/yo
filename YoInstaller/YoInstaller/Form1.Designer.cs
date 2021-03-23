namespace YoInstaller
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.flutterCb = new System.Windows.Forms.CheckBox();
            this.pubCacheCb = new System.Windows.Forms.CheckBox();
            this.dartSdkCb = new System.Windows.Forms.CheckBox();
            this.installBtn = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.pathList = new System.Windows.Forms.ListBox();
            this.lblFlutterPath = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lblFlutterBasePath = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(462, 37);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(116, 108);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // flutterCb
            // 
            this.flutterCb.AutoSize = true;
            this.flutterCb.Location = new System.Drawing.Point(12, 32);
            this.flutterCb.Name = "flutterCb";
            this.flutterCb.Size = new System.Drawing.Size(71, 17);
            this.flutterCb.TabIndex = 1;
            this.flutterCb.Text = "flutter\\bin";
            this.flutterCb.UseVisualStyleBackColor = true;
            // 
            // pubCacheCb
            // 
            this.pubCacheCb.AutoSize = true;
            this.pubCacheCb.Location = new System.Drawing.Point(12, 55);
            this.pubCacheCb.Name = "pubCacheCb";
            this.pubCacheCb.Size = new System.Drawing.Size(130, 17);
            this.pubCacheCb.TabIndex = 2;
            this.pubCacheCb.Text = "flutter\\.pub-cache\\bin";
            this.pubCacheCb.UseVisualStyleBackColor = true;
            // 
            // dartSdkCb
            // 
            this.dartSdkCb.AutoSize = true;
            this.dartSdkCb.Location = new System.Drawing.Point(12, 78);
            this.dartSdkCb.Name = "dartSdkCb";
            this.dartSdkCb.Size = new System.Drawing.Size(171, 17);
            this.dartSdkCb.TabIndex = 3;
            this.dartSdkCb.Text = "flutter\\.bin\\cache\\dart-sdk\\bin";
            this.dartSdkCb.UseVisualStyleBackColor = true;
            // 
            // installBtn
            // 
            this.installBtn.Location = new System.Drawing.Point(474, 164);
            this.installBtn.Name = "installBtn";
            this.installBtn.Size = new System.Drawing.Size(104, 42);
            this.installBtn.TabIndex = 4;
            this.installBtn.Text = "Install";
            this.installBtn.UseVisualStyleBackColor = true;
            this.installBtn.Click += new System.EventHandler(this.installBtn_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(446, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(132, 25);
            this.label1.TabIndex = 5;
            this.label1.Text = "Yo Installer";
            // 
            // pathList
            // 
            this.pathList.FormattingEnabled = true;
            this.pathList.Location = new System.Drawing.Point(12, 215);
            this.pathList.Name = "pathList";
            this.pathList.Size = new System.Drawing.Size(566, 290);
            this.pathList.TabIndex = 6;
            // 
            // lblFlutterPath
            // 
            this.lblFlutterPath.AutoSize = true;
            this.lblFlutterPath.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFlutterPath.Location = new System.Drawing.Point(130, 109);
            this.lblFlutterPath.Name = "lblFlutterPath";
            this.lblFlutterPath.Size = new System.Drawing.Size(10, 13);
            this.lblFlutterPath.TabIndex = 7;
            this.lblFlutterPath.Text = "-";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(12, 109);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(67, 13);
            this.label2.TabIndex = 8;
            this.label2.Text = "Flutter Path: ";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(12, 131);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(88, 13);
            this.label3.TabIndex = 10;
            this.label3.Text = "Flutter Base Path";
            // 
            // lblFlutterBasePath
            // 
            this.lblFlutterBasePath.AutoSize = true;
            this.lblFlutterBasePath.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFlutterBasePath.Location = new System.Drawing.Point(130, 131);
            this.lblFlutterBasePath.Name = "lblFlutterBasePath";
            this.lblFlutterBasePath.Size = new System.Drawing.Size(10, 13);
            this.lblFlutterBasePath.TabIndex = 9;
            this.lblFlutterBasePath.Text = "-";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(591, 521);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.lblFlutterBasePath);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.lblFlutterPath);
            this.Controls.Add(this.pathList);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.installBtn);
            this.Controls.Add(this.dartSdkCb);
            this.Controls.Add(this.pubCacheCb);
            this.Controls.Add(this.flutterCb);
            this.Controls.Add(this.pictureBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Yo Installer";
            this.TopMost = true;
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.CheckBox flutterCb;
        private System.Windows.Forms.CheckBox pubCacheCb;
        private System.Windows.Forms.CheckBox dartSdkCb;
        private System.Windows.Forms.Button installBtn;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ListBox pathList;
        private System.Windows.Forms.Label lblFlutterPath;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblFlutterBasePath;
    }
}

