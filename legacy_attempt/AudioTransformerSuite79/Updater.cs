using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AudioTransformerSuite79
{
    public class Updater
    {
        // Base GitHub raw URL for your client files
        private readonly string rawBaseUrl = 
            "https://raw.githubusercontent.com/Naser507/Audio_Transformer_Suite_79/main/client/AudioTransformerSuite79/";

        // List of files to update
        private readonly string[] filesToUpdate = new string[]
        {
            "MainForm.cs",
            "Program.cs",
            "AudioTransformerSuite79.csproj"
        };

        public async void UpdateClient(TextBox log)
        {
            using HttpClient client = new HttpClient();

            foreach (var fileName in filesToUpdate)
            {
                try
                {
                    string fileUrl = rawBaseUrl + fileName;
                    string localPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, fileName);

                    log.AppendText($"Downloading {fileName}..." + Environment.NewLine);

                    // Download file content
                    string content = await client.GetStringAsync(fileUrl);

                    // Write to local file (overwrite)
                    File.WriteAllText(localPath, content);

                    log.AppendText($"{fileName} updated successfully." + Environment.NewLine);
                }
                catch (Exception ex)
                {
                    log.AppendText($"Failed to update {fileName}: {ex.Message}" + Environment.NewLine);
                }
            }

            log.AppendText("Update complete!" + Environment.NewLine);
        }
    }
}
