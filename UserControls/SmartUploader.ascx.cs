using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace UserControls
{
    public partial class SmartUploader : System.Web.UI.UserControl
    {
        public string UploadFolder { get; set; } = "SmartUploader_Files";

        public FileFilter UploadFilter { get; set; } = FileFilter.Any;

        protected string HtmlUploadFilter = "*/*";

        public delegate void FileUploadedEventHandler(object sender, SmartUploaderFileUploadedArgs e);

        public event FileUploadedEventHandler FileUploaded;

        public delegate void FileUploadErrorEventHandler(object sender, SmartUploaderFileUploadErrorArgs e);

        public event FileUploadErrorEventHandler FileUploadError;

        public enum FileFilter {
            Any,
            Audio,
            Video,
            Images,
            Documents
        }

        private string[] documentMIMETypes = {
            ".doc",
            "docx",
            "application/msword",
            "application / vnd.openxmlformats - officedocument.wordprocessingml.document",
            "application/vnd.oasis.opendocument.presentation",
            "application/vnd.oasis.opendocument.spreadsheet",
            "application/vnd.oasis.opendocument.text",
            "application/pdf",
            "application/vnd.ms-powerpoint",
            "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            "application/rtf",
            "text/plain",
            "application/vnd.ms-excel",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            switch (UploadFilter)
            {
                case FileFilter.Audio: {
                        HtmlUploadFilter = "audio/*";
                        break;
                }
                case FileFilter.Video:{
                        HtmlUploadFilter = "video/*";
                        break;
                }
                case FileFilter.Images:{
                        HtmlUploadFilter = "image/*";
                        break;
                }
                case FileFilter.Documents: {
                        HtmlUploadFilter = String.Join(", ", documentMIMETypes);
                        break;
                }
                default: {
                        HtmlUploadFilter = "*/*";
                        break;
                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {  
            resetMessages();

            if (Request.Files[0] != null)
            {
                doFileUpload(Request.Files[0]);
            }
            else
            {
                lblUploadError.Text = "Please select file to upload";
            }
        }

        private void doFileUpload(HttpPostedFile httpPostedFile)
        {
            string fileUploadFolder = Server.MapPath($"~/{UploadFolder}");
            string fileName = httpPostedFile.FileName;
            
            try
            {
                //TODO: Remove after testing
                throw new Exception("Test Exception");

                if (!Directory.Exists(fileUploadFolder))
                {
                    Directory.CreateDirectory(fileUploadFolder);
                }

                if (File.Exists(Path.Combine(fileUploadFolder, fileName)))
                {
                    fileName = Path.GetFileNameWithoutExtension(fileName)
                        + "_" + DateTime.Now.Ticks.ToString()
                        + Path.GetExtension(fileName);
                }

                filePicker.SaveAs(Path.Combine(fileUploadFolder, fileName));

                lblUploadResult.Text = "Upload complete";

                OnUploadComplete(new SmartUploaderFileUploadedArgs { 
                    UploadPath = fileUploadFolder,
                    FileName = fileName
                });

            }
            catch (Exception ex)
            {
                lblUploadError.Text = ex.Message;

                if (FileUploadError != null)
                    FileUploadError(this, new SmartUploaderFileUploadErrorArgs { UploadError = ex });
            }
        }

        private void resetMessages()
        {
            lblUploadError.Text = "";
            lblUploadResult.Text = "";
        }

        public virtual void OnUploadComplete(SmartUploaderFileUploadedArgs e)
        {
            //Если у события есть подписчики
            //if event has subscribers
            if (FileUploaded != null)
            {
                //Публикуем событие для подписчиков
                FileUploaded(this, e);
            }
        }
             
    }

    public class SmartUploaderFileUploadedArgs : EventArgs
    {
        public string UploadPath { get; set; }

        public string FileName { get; set; }
    }

    public class SmartUploaderFileUploadErrorArgs : EventArgs
    {
        public Exception UploadError { get; set; }
    }
}