using MultipleFileUploader.Models;
using System;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace MultipleFileUploader
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Form.Enctype = "multipart/form-data";

            if (!IsPostBack)
                GetUploadedFiles();

        }

        private void GetUploadedFiles()
        {
            using (var sampleDb = new FileUploadEntities())
            {
                DataGridView.DataSource = sampleDb.UploadFiles.ToList();
                DataGridView.DataBind();
            }
        }

        protected void DataGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "DownloadFile") return;

            var fileId = Convert.ToInt32(e.CommandArgument.ToString());

            using (var sampleDb = new FileUploadEntities())
            {
                var file = sampleDb.UploadFiles.FirstOrDefault(f => f.Id.Equals(fileId));

                if (file == null) return;

                Response.ContentType = file.ContentType;
                Response.AddHeader("content-disposition", "attachment; filename=" + file.Name);
                Response.BinaryWrite(file.Content);
                Response.Flush();
                Response.End();
            }
        }

        protected void BtnUploadFile_Click(object sender, EventArgs e)
        {
            var fileCollection = Request.Files;

            using (var sampleDb = new FileUploadEntities())
            {
                foreach (string fileUploader in fileCollection)
                {
                    var postedFile = fileCollection[fileUploader];

                    if (postedFile == null || postedFile.ContentLength <= 0) continue;

                    var binaryReader = new BinaryReader(postedFile.InputStream);
                    var fileBuffer = binaryReader.ReadBytes(postedFile.ContentLength);

                    sampleDb.UploadFiles.Add(new UploadFile
                    {
                        Name = postedFile.FileName,
                        ContentType = postedFile.ContentType,
                        Extension = Path.GetExtension(postedFile.FileName),
                        Size = postedFile.ContentLength,
                        Content = fileBuffer
                    });
                }

                sampleDb.SaveChanges();
            }

            GetUploadedFiles();
        }
    }
}