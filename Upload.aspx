<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="MultipleFileUploader.Upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/jquery-3.4.1.js"></script>
    <script type="text/javascript">
        $(function () {
            debugger;

            var divElement = $('#MultipleFileUploader');
            var i = $('#MultipleFileUploader p').size() + 1;

            $('#AddAnotherUploader').on('click', function () {
                $('<p><input type="file" ID="FileUploader1' + i + '" name="FileUploader1' + i + '" class="form-control" /></p>').appendTo(divElement);
                i++;

                return false;
            });
        });
    </script>

    <div class="form-horizontal">
        <h4>Uploading Multiple Files</h4>
        <hr />

        <asp:ValidationSummary runat="server" CssClass="text-danger" />

        <div class="form-group">
            <asp:Label runat="server" CssClass="col-md-2 control-label">Choose File</asp:Label>
            <div class="col-md-10" id="MultipleFileUploader">
                <p>
                    <asp:FileUpload runat="server" ID="FileUploader" CssClass="form-control" />
                    <a href="#" id="AddAnotherUploader">Add Files</a>
                </p>
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" ID="BtnUploadFile" OnClick="BtnUploadFile_Click"
                            Text="Upload Files" CssClass="btn btn-primary btn-lg" />
            </div>
        </div>
        
              
        <h4>View Multiple Files</h4>
        <hr/>

        <div class="form-group">
            
            <div class="col-md-10">
                <asp:GridView runat="server" ID="DataGridView" AutoGenerateColumns="false"
                              OnRowCommand="DataGridView_RowCommand" CssClass="table table-striped table-bordered table-hover">
                    <Columns>
                        <asp:BoundField HeaderText="File Name" DataField="Name" />
                        <asp:BoundField HeaderText="File Size" DataField="Size" />
                        <asp:TemplateField HeaderText="Get File">
                            <ItemTemplate>
                                <asp:LinkButton ID="LbnDownload" runat="server" CommandName="DownloadFile"
                                                CommandArgument='<%# Eval("Id") %>'>Download</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>
