<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmployeeRegister.aspx.cs" Inherits="Crud.View.EmployeeRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ChildContent1" runat="server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>Employee Register</h2>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="../../View/Admin/AdminHome.aspx">Admin</a>
                </li>
                 <li class="breadcrumb-item">
                   System Settings
                </li>
                <li class="breadcrumb-item active">
                    <strong>Employee</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox">
                    <div class="ibox-content">
                        <div class="panel-group" style="margin-bottom: 0 !important">
                            <div class="panel">
                                <div class="row">
                                    <div class="col-md-12 " id="divAddButtonPanel">
                                        <div class="row form-group">
                                            <div class="col-md-12">
                                                <asp:Button ID="btnAdd" runat="server" Text="Add New Employee" CssClass="btn btn-success n-btn-add-search-success" />
                                               </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 " id="divAddPanel" style="display: none">
                                        <div class="row form-group">
                                            <div class="col-md-12">

                                                <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Full name</label>
                                                            <input type="text" name="txtFullName" id="txtFullName" runat="server" class="form-control" placeholder="Enter Full Name" />
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                                <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">SLMC Number</label>
                                                            <input type="text" name="txtSLMC" id="txtSLMC" runat="server" class="form-control" placeholder="Enter SLMC Number" />
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                               
                                                  <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Position</label>
                                                            <asp:DropDownList ID="txtPosition" runat="server" class="form-control" >
                                                                <asp:ListItem>Position 1</asp:ListItem>
                                                                <asp:ListItem>Position 3</asp:ListItem>
                                                                <asp:ListItem>Position 2</asp:ListItem>
                                                                <asp:ListItem>Position 4</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>

                                                  <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Email</label>
                                                           <input type="text" name="txtEmail" id="txtEmail" runat="server" class="form-control" placeholder="Enter Email" />
                                                        
                                                        </div>
                                                    </div>
                                                </div>

                                                  <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Contact Number</label>
                                                           <input type="text" name="txtContact" id="txtContact" runat="server" class="form-control" placeholder="Enter Contact" />
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                                  <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Username</label>
                                                           <input type="text" name="txtUsername" id="txtUsername" runat="server" class="form-control" placeholder="Enter Username" />
                                                       
                                                        </div>
                                                    </div>
                                                </div>
                                                  <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Password</label>
                                                           <input type="text" name="txtPassword" id="txtPassword" runat="server" class="form-control" placeholder="Enter Password" />
                                                       
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <asp:Button ID="btnSave" type="submit" runat="server" Text="Save" CssClass="btn btn-success n-btn-add-search-success" />
                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" />


                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row " style="margin: 0; margin-top: 10px;">
                            <div id="divMsg"></div>
                        </div>
                        <div class="row" id="gridPanel">
                            <div class="form-horizontal">
                                <div class="row n-row-margin-bottom">
                                    <div class="col-sm-12 ">
                                        <div class="col-sm-12 n-style" id="Printcont">
                                            <span id="gridView"></span>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>



                    
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script lang="javascript" type="text/javascript">
        $(document).ready(function () {
            pageload();
        });


        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {
            pageload();
        });


        function pageload() {

            $(document).ready(function () {
                get_skill_list();
            });

        $("#divAddPanel").hide();

         //click event for new user role button
         $("#<%=btnAdd.ClientID%>").click(function () {
             $("#divAddPanel").show();
             $("#divAddButtonPanel").hide();
             $("#gridPanel").hide();
             $("#<%=txtFullName.ClientID%>").prop('disabled', false);
             $("#<%=txtFullName.ClientID%>").focus();
             $("#<%=txtFullName.ClientID%>").parent().parent().removeClass('has-error');
             $("#<%=txtFullName.ClientID%>").parent().parent().removeClass('has-success');
             $("#<%=txtFullName.ClientID%>").parent().find("small").remove();
            
             $("#divMsg").append('');
          
           
             return false;
         });

         //click event for Delete button


            $("#<%=btnSave.ClientID%>").click(function () {
                save_language();
            
                  $("#divMsg").append('');


              });


           

         //click event for Cancel button
         $("#<%=btnCancel.ClientID%>").click(function () {
             $("#divAddPanel").hide();
             $("#divAddButtonPanel").show();
             $("#<%=txtFullName.ClientID%>").parent().parent().removeClass('has-error');
             $("#<%=txtFullName.ClientID%>").parent().parent().removeClass('has-success');
             $("#<%=txtFullName.ClientID%>").parent().find("small").remove();
             $("#<%=txtFullName.ClientID%>").val("");
           
             $("#gridList").show();
             $("#gridPanel").show();
             return false;
         });

       

         //click event for save button
        



         // click event of table row link
     $(document).on("click", "#gridList tr td a", function (e) {

         var skillTypeId = $(this).parent().find('input[type=hidden]').val();
         var skillTypeName = $(this).text();
         var desc = ($(this).parent().parent().find('td').eq(2).text());
         $("#divAddPanel").show();
         $("#divAddButtonPanel").hide();
         $("#<%=txtFullName.ClientID%>").focus();
             $("#divMsg").append('');
             $("#<%=txtFullName.ClientID%>").val(skillTypeName);
             $("#<%=txtFullName.ClientID%>").prop('disabled', true);
             $("#txtDesc").val(desc);
             $("#txtDesc").prop('disabled', true);
             $("#<%=btnSave.ClientID%>").prop('disabled', false);
             $("#<%=btnSave.ClientID%>").val('Edit');
             $("#gridList").hide();
             $("#skillTypeId").val(skillTypeId);
             return false;

         });
     }

     function get_skill_list() {
       
     }


        function save_language(btnType) {
         //  txtFullName,txtSLMC,txtPosition,txtEmail,txtContact,txtUsername,txtPassword
             var FULL_NAME = $("#<%=txtFullName.ClientID%>").val();
            var SLMCNO = $("#<%=txtSLMC.ClientID%>").val();
            var POSITION = $("#<%=txtPosition.ClientID%>").val();
            var EMAIL = $("#<%=txtEmail.ClientID%>").val();
            var CONTACT_NO = $("#<%=txtContact.ClientID%>").val();
            var USERNAME = $("#<%=txtUsername.ClientID%>").val();
            var PASSWORD = $("#<%=txtPassword.ClientID%>").val();
         //var SLMCNO = $("#skillTypeId").val();

         $("#divMsg").empty();
         $("#divMsg").show();
         $.ajax({
             type: "POST",
             url: "EmployeeRegister.aspx/SaveEmployee", //URL should be fully qualified
             data: "{'FULL_NAME':'" + FULL_NAME + "','SLMCNO':'" + SLMCNO + "','POSITION':'" + POSITION + "','EMAIL':'" + EMAIL + "','CONTACT_NO':'" + CONTACT_NO + "','USERNAME':'" + USERNAME + "','PASSWORD':'" + PASSWORD + "'}",
             dataType: "json",
             contentType: "application/json; charset=utf-8",
             success: function (data) {
                 var returnMsg = data.d;
                 if (returnMsg == "OK") {
                     $("#<%=txtFullName.ClientID%>").val('');
                     $("#divAddPanel").hide();
                     $("#divAddButtonPanel").show();
                    
                     $("#divMsg").append('<div class="alert alert-success" style ="margin-bottom: 0"><strong>Success! </strong>Employee Successfully saved.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                     get_skill_list();
                     $("#gridPanel").show();
                 }
                 else if (returnMsg == "Duplicate") {
                     $("#<%=txtFullName.ClientID%>").focus();
                     $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Duplicate! </strong>Employee type already exits.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                 }
                 else {
                     $("#<%=txtFullName.ClientID%>").focus();
                     $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Error! </strong>' + returnMsg + '.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                 }
             },
             error: function (a)
             { alert(a.responseText); }
         });
 }


    </script>



</asp:Content>

