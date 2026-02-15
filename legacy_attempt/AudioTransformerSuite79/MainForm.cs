using System;
using System.Drawing;
using System.Windows.Forms;

namespace AudioTransformerSuite79
{
    public class MainForm : Form
    {
        // ----------------------------
        // UI Elements
        // ----------------------------
        private Button connectButton;
        private TextBox logTextBox;
        private MenuStrip menuStrip;
        private ToolStripMenuItem fileMenu;
        private ToolStripMenuItem settingsMenu;
        private ToolStripMenuItem updateMenuItem;

        // ----------------------------
        // External modules
        // ----------------------------
        private Updater updater;

        public MainForm()
        {
            updater = new Updater(); // Initialize updater
            InitializeComponents();
        }

        private void InitializeComponents()
        {
            // ----------------------------
            // Basic Form Setup
            // ----------------------------
            this.Text = "Audio Transformer Suite 79 - Client";
            this.Size = new Size(800, 500);
            this.StartPosition = FormStartPosition.CenterScreen;

            // ----------------------------
            // Connect Button
            // ----------------------------
            connectButton = new Button();
            connectButton.Text = "Connect to Server";
            connectButton.Size = new Size(150, 40);
            connectButton.Location = new Point(20, 50);
            connectButton.Click += ConnectButton_Click;

            // ----------------------------
            // Log TextBox
            // ----------------------------
            logTextBox = new TextBox();
            logTextBox.Multiline = true;
            logTextBox.ScrollBars = ScrollBars.Vertical;
            logTextBox.Location = new Point(20, 110);
            logTextBox.Size = new Size(740, 350);

            // ----------------------------
            // MenuStrip Setup
            // ----------------------------
            menuStrip = new MenuStrip();

            // File menu placeholder
            fileMenu = new ToolStripMenuItem("File");

            // Settings menu
            settingsMenu = new ToolStripMenuItem("Settings");

            // Update menu item
            updateMenuItem = new ToolStripMenuItem("Update");
            updateMenuItem.Click += UpdateMenuItem_Click;

            settingsMenu.DropDownItems.Add(updateMenuItem);
            menuStrip.Items.Add(fileMenu);
            menuStrip.Items.Add(settingsMenu);

            this.MainMenuStrip = menuStrip;

            // ----------------------------
            // Add controls
            // ----------------------------
            this.Controls.Add(connectButton);
            this.Controls.Add(logTextBox);
            this.Controls.Add(menuStrip);
        }

        // ----------------------------
        // Event Handlers
        // ----------------------------
        private void ConnectButton_Click(object? sender, EventArgs e)
        {
            logTextBox.AppendText("Attempting to connect to server..." + Environment.NewLine);
        }

        private void UpdateMenuItem_Click(object? sender, EventArgs e)
        {
            DialogResult confirm = MessageBox.Show(
                "Are you sure you want to update the client application?",
                "Confirm Update",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Warning
            );

            if (confirm == DialogResult.Yes)
            {
                logTextBox.AppendText("Starting update..." + Environment.NewLine);

                // Call the modular updater
                updater.UpdateClient(logTextBox);
            }
        }
    }
}


