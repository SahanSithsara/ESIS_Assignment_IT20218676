<%@ Page Language="C#" MasterPageFile="Site1.Master" AutoEventWireup="true" CodeBehind="Crud.aspx.cs" Inherits="Crud.Crud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ChildContent1" runat="server">
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>Skills</h2>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="../../View/Admin/AdminHome.aspx">Admin</a>
                </li>
                 <li class="breadcrumb-item">
                   System Settings
                </li>
                <li class="breadcrumb-item active">
                    <strong>Skills</strong>
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
                                                <asp:Button ID="btnAdd" runat="server" Text="Add New Skill Type" CssClass="btn btn-success n-btn-add-search-success" />
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 " id="divAddPanel" style="display: none">
                                        <div class="row form-group">
                                            <div class="col-md-12">

                                                <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Skill Type name</label>
                                                            <input type="text" name="txtSkillType" id="txtSkillType" runat="server" class="form-control" placeholder="Enter skill type name" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <input type="hidden" id="skillTypeId" value="0" />

                                                    </div>
                                                </div>
                                                <div class="row form-group">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label ">Description</label>
                                                            <textarea id="txtDesc" rows="4" cols="50" class="form-control">  </textarea>
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



                        <!-- Modal -->
                        <div class="modal inmodal" id="modelDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document" style="width: auto; margin-left: 30%; margin-right: 30%;">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <div class="row">
                                            <div class="col-sm-10">
                                                <h4>Confirmation to delete</h4>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure to delete selected skill type/s ?
                                    </div>
                                    <div class="modal-footer">

                                        <button type="button" id="btnDeleteFinal" class="btn btn-danger n-btn-delete">Yes</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>

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

            $("#<%=btnSave.ClientID%>").prop('disabled', true);
         $("#divAddPanel").hide();

         //click event for new user role button
         $("#<%=btnAdd.ClientID%>").click(function () {
             $("#divAddPanel").show();
             $("#divAddButtonPanel").hide();
             $("#gridPanel").hide();
             $("#<%=txtSkillType.ClientID%>").prop('disabled', false);
             $("#<%=txtSkillType.ClientID%>").focus();
             $("#<%=txtSkillType.ClientID%>").parent().parent().removeClass('has-error');
             $("#<%=txtSkillType.ClientID%>").parent().parent().removeClass('has-success');
             $("#<%=txtSkillType.ClientID%>").parent().find("small").remove();
             $("#txtDesc").val('');
             $("#divMsg").append('');
             $("#<%=btnSave.ClientID%>").val('Save');
             $("#skillTypeId").val("0");
             return false;
         });

         //click event for Delete button
         $("#<%=btnDelete.ClientID%>").click(function () {
             $('#modelDelete').modal('show');
             return false;
         });

         //click event for confirm Delete button
         $("#btnDeleteFinal").click(function () {
             $("#divMsg").empty();
             $("#divMsg").show();
             //Declare array for selected rows
             var deleteList = new Array();

             $('#gridList tr').each(function () {
                 var val = $(this).find(":checkbox").is(":checked");
                 if (val) {
                     deleteList.push($(this).find('td').eq(1).find('input[type=hidden]').val());
                 }
             });

             if (deleteList.length > 0) {
                 $.ajax({
                     type: "POST",
                     url: "Crud.aspx/DeleteSkillType",
                     data: "{deleteList:" + JSON.stringify(deleteList) + "}",
                     dataType: "json",
                     contentType: "application/json; charset=utf-8",
                     success: function (data) {
                         var returnMsg = data.d;
                         if (returnMsg == "OK") {
                             $("#divMsg").append('<div class="alert alert-success" style ="margin-bottom: 0"><strong>Success! </strong>Skill Type deleted.</div>');
                             $("#divMsg").delay(3000).fadeOut(2000);
                             get_skill_list();
                         }
                         else {
                             $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Error! </strong>cannot delete this record.</div>');
                             $("#divMsg").delay(3000).fadeOut(2000);
                         }
                     },
                     error: function (a) {
                         $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Error! </strong>' + returnMsg + '.</div>');
                         $("#divMsg").delay(3000).fadeOut(2000);
                     }
                 });
             }
             else {
                 $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Error! </strong>Please select at least one record to delete.</div>');
                 $("#divMsg").delay(3000).fadeOut(2000);
             }
             $('#modelDelete').modal('hide');
         });


         //click event for Cancel button
         $("#<%=btnCancel.ClientID%>").click(function () {
             $("#divAddPanel").hide();
             $("#divAddButtonPanel").show();
             $("#<%=txtSkillType.ClientID%>").parent().parent().removeClass('has-error');
             $("#<%=txtSkillType.ClientID%>").parent().parent().removeClass('has-success');
             $("#<%=txtSkillType.ClientID%>").parent().find("small").remove();
             $("#<%=txtSkillType.ClientID%>").val("");
             $("#<%=btnSave.ClientID%>").prop('disabled', true);
             $("#gridList").show();
             $("#gridPanel").show();
             return false;
         });

         $("#<%=txtSkillType.ClientID%>").on("keyup", function () {
             checkTextFileTypeNamevalidity();
         });

         //click event for save button
         $("#<%=btnSave.ClientID%>").click(function () {
             var btnVal = $("#<%=btnSave.ClientID%>").val();
             if (btnVal == "Save") {
                 save_language(btnVal);
             }
             else if (btnVal == "Edit") {
                 $("#<%=btnSave.ClientID%>").val('Update');
                 $("#<%=txtSkillType.ClientID%>").prop('disabled', false);
                 $("#txtDesc").prop('disabled', false);
                 $("#<%=txtSkillType.ClientID%>").focus();
             }
             else if (btnVal == "Update") {
                 save_language(btnVal);
             }
             return false;
         });



         // click event of table row link
     $(document).on("click", "#gridList tr td a", function (e) {

         var skillTypeId = $(this).parent().find('input[type=hidden]').val();
         var skillTypeName = $(this).text();
         var desc = ($(this).parent().parent().find('td').eq(2).text());
         $("#divAddPanel").show();
         $("#divAddButtonPanel").hide();
         $("#<%=txtSkillType.ClientID%>").focus();
             $("#divMsg").append('');
             $("#<%=txtSkillType.ClientID%>").val(skillTypeName);
             $("#<%=txtSkillType.ClientID%>").prop('disabled', true);
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
         $.ajax({
             type: "POST",
             url: "Crud.aspx/get_skill_list",
             dataType: "json",
             contentType: "application/json; charset=utf-8",
             success: function (data) {
                 var returnMsg = data.d;
                 $('#gridView').html(returnMsg);
             },
             error: function (a)
             { alert(a.responseText); }
         });
     }


     function save_language(btnType) {
         var Name = $("#<%=txtSkillType.ClientID%>").val();
         var skillTypeId = $("#skillTypeId").val();
         var desc = $("#txtDesc").val();
         $("#divMsg").empty();
         $("#divMsg").show();
         $.ajax({
             type: "POST",
             url: "Crud.aspx/InsertSkillType", //URL should be fully qualified
             data: "{'skillTypeName':'" + Name + "','ClickType':'" + btnType + "','skillTypeId':'" + skillTypeId + "','desc':'" + desc + "'}",
             dataType: "json",
             contentType: "application/json; charset=utf-8",
             success: function (data) {
                 var returnMsg = data.d;
                 if (returnMsg == "OK") {
                     $("#<%=txtSkillType.ClientID%>").val('');
                     $("#divAddPanel").hide();
                     $("#divAddButtonPanel").show();
                     $("#<%=btnSave.ClientID%>").prop('disabled', true);
                     $("#divMsg").append('<div class="alert alert-success" style ="margin-bottom: 0"><strong>Success! </strong>Skill type Successfully saved.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                     get_skill_list();
                     $("#gridPanel").show();
                 }
                 else if (returnMsg == "Duplicate") {
                     $("#<%=txtSkillType.ClientID%>").focus();
                     $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Duplicate! </strong>skill type already exits.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                 }
                 else {
                     $("#<%=txtSkillType.ClientID%>").focus();
                     $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Error! </strong>' + returnMsg + '.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                 }
             },
             error: function (a)
             { alert(a.responseText); }
         });
 }


 function checkTextFileTypeNamevalidity() {
     var isValid = false;
     var val = $("#<%=txtSkillType.ClientID%>").val();
         $("#<%=txtSkillType.ClientID%>").parent().parent().removeClass('has-error');
         $("#<%=txtSkillType.ClientID%>").parent().parent().removeClass('has-success');
         $("#<%=txtSkillType.ClientID%>").parent().find("small").remove();
         if (val == '') {
             $("#<%=txtSkillType.ClientID%>").parent().parent().addClass('has-error');
             $("#<%=txtSkillType.ClientID%>").parent().append('<small class="help-block">Skill type name required and cannot be a empty.</small>');
             $("#<%=btnSave.ClientID%>").prop('disabled', true);
             isValid = false;
         }
         else {
             $("#<%=txtSkillType.ClientID%>").parent().parent().addClass('has-success');
             $("#<%=btnSave.ClientID%>").prop('disabled', false);
             isValid = true;

         }
         return isValid;
     }
    </script>



</asp:Content>


