using System;
using System.Windows.Forms;

namespace AudioTransformerSuite79
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            // Initialize Windows Forms application configuration
            ApplicationConfiguration.Initialize();

            // Run the main form (opens the window)
            Application.Run(new MainForm());
        }
    }
}

