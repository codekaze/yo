using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace YoInstaller
{
    public partial class Form1 : Form
    {
        bool flutterPathRegistered = false;
        bool pubCacheRegistered = false;
        bool dartSdkPathRegistered = false;
        List<String> arrPathList = new List<string>();

        String flutterBasePath = "";

        public Form1()
        {
            InitializeComponent();
        }

        void updateState()
        {
            flutterCb.Checked = flutterPathRegistered;
            pubCacheCb.Checked = pubCacheRegistered;
            dartSdkCb.Checked = dartSdkPathRegistered;

            //if(flutterPathRegistered && pubCacheRegistered && dartSdkPathRegistered)
            //{
            //    installBtn.Enabled = false;
            //}
            //else
            //{
            //    installBtn.Enabled = true;
            //}
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var name = "PATH";
            var scope = EnvironmentVariableTarget.User; // or User
            var oldValue = Environment.GetEnvironmentVariable(name, scope);
            var newValue = oldValue + @";C:\Program Files\MySQL\MySQL Server 5.1\bin\\";
            //Environment.SetEnvironmentVariable(name, newValue, scope);

            var arr = newValue.Split(';');
            for(var i = 0; i < arr.Length; i++)
            {
                var path = arr[i];
                if (path.Contains("flutter\\bin"))
                {
                    flutterBasePath = path.Replace("flutter\\bin", "flutter\\");
                    lblFlutterPath.Text = path;
                    lblFlutterBasePath.Text = flutterBasePath;
                    flutterPathRegistered = true;
                }
                else if (path.Contains(".pub-cache\\bin"))
                {
                    pubCacheRegistered = true;
                }
                else if (path.Contains("bin\\cache\\dart-sdk\\bin"))
                {
                    dartSdkPathRegistered = true;
                }
                arrPathList.Add(path);
            }
            pathList.Items.AddRange(arr);
            updateState();
        }

        private void installBtn_Click(object sender, EventArgs e)
        {
            this.Enabled = false;

            try
            {
                String strCmdText = "'/C flutter pub global activate yo";
                Process.Start("CMD.exe", strCmdText);

                var scope = EnvironmentVariableTarget.User;

                if (pubCacheRegistered == false)
                {
                    var newPath = flutterBasePath + ".pub-cache\\bin";
                    arrPathList.Add(newPath);
                }

                if (dartSdkPathRegistered == false)
                {
                    var newPath = flutterBasePath + "bin\\cache\\dart-sdk\\bin";
                    arrPathList.Add(newPath);
                }

                var newValue = String.Join(";", arrPathList);
                Environment.SetEnvironmentVariable("PATH", newValue, scope);

                MessageBox.Show("Yo has been installed successfully");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Install Failed!");
            }
            this.Enabled = true;
        }
    }
}
