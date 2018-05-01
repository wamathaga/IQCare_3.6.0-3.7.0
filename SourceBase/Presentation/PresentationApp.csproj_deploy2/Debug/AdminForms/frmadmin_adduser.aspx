<%@ Page Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="True"
    Inherits="frmadmin_adduser" Title="Untitled Page" CodeBehind="frmadmin_adduser.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="Server">
    <div id="unique_id" style="display: none;">
        The Password must meet the following Requirements:</br>&nbsp; Minimum of 6 character
        length. Atleast one upper case letter.</br>&nbsp; Atleast one numeric character.</br>&nbsp;
        Atleast one non alpha character.</br>&nbsp; No more than 3 consecutive characters
        e.g '1234' or 'abcd'.</br>&nbsp; You may not use the word 'password',firstname,lastname,username.
    </div>
    <script language="javascript" type="text/javascript">

        $(document).ready(function () {
            $('#chkIsEmployee').change(function () {
                if ($('#chkIsEmployee').is(":checked")) {
                    Add_Remove_Class(true);
                } else {
                    Add_Remove_Class(false);
                }
            });

        });

        function Add_Remove_Class(state) {
            if (!state) {
                $('#lblPassword').removeClass('right required').addClass('right');
                $('#lblConfirmPassword').removeClass('right required').addClass('right');
                $('#lblUserGroup').removeClass('right required').addClass('right');
            }
            else {
                $('#lblPassword').removeClass('right').addClass('right required');
                $('#lblConfirmPassword').removeClass('right').addClass('right required');
                $('#lblUserGroup').removeClass('right').addClass('right required');
            }
        }

        function validstrngpwd(fname, lname, uname) {
            //var txtnewpwdid = badword.value;
            if (!validateStrongPassword('ctl00_IQCareContentPlaceHolder_txtPassword', { length: [6, Infinity], lower: 1, upper: 1, numeric: 1, alpha: 1, special: 1, badWords: ['password', fname, lname, uname], badSequenceLength: 4 })) {
                //alert(badword.toString());
                return true;
            }
            else {
                return false;
            }
        }
        function validnewuserstrngpwd() {
            //var txtnewpwdid = badword.value;
            if (!validateStrongPassword('ctl00_IQCareContentPlaceHolder_txtPassword', { length: [6, Infinity], lower: 1, upper: 1, numeric: 1, alpha: 1, special: 1, badWords: ['password'], badSequenceLength: 4 })) {
                //alert(badword.toString());
                return true;
            }
            else {
                return false;
            }
        }

        function phonenumber(LabelId) {
            var lbl = document.getElementById(LabelId);
            var phoneno = /^\d{10}$/;

            if (document.getElementById('<%= txtPhone.ClientID%>').value == "") {
                lbl.innerHTML = '';
                return true;
            }
            else if (document.getElementById('<%= txtPhone.ClientID%>').value.match(phoneno)) {
                lbl.innerHTML = '';
                return true;
            }

            else {

                lbl.innerHTML = 'Not a valid Phone Number';
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                return false;
            }
        }

        function ValidateEmail(inputText, LabelId) {
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            var lbl = document.getElementById(LabelId);
            if (document.getElementById('<%= txtEmail.ClientID%>').value == "") {
                lbl.innerHTML = '';
                return true;
            }
            else if (inputText.value.match(mailformat)) {
                lbl.innerHTML = '';
                return true;
            }
            else {
                lbl.innerHTML = 'You have entered an invalid email address!';
                //alert("You have entered an invalid email address!");
                document.getElementById('<%= txtEmail.ClientID%>').focus();
                return false;
            }
        }  


    </script>
    <div>
        <%--  <form id="adduser" method="post" runat="server">--%>
        <h3 class="margin" align="left" style="padding-left: 10px;">
            <asp:Label ID="lblh2" runat="server" Text="Add User"></asp:Label></h3>
        <div class="center" style="padding: 5px;">
            <div class="border center formbg">
                <br />
                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                    <tbody>
                        <tr>
                            <td style="width: 50%">
                            </td>
                            <td align="right" style="width: 50%">
                                <label for="LastName" style="color: red">
                                    *New users will be required to change their password upon login.</label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="border pad5 whitebg center" align="center" style="width: 173%;">
                                <input type="checkbox" id="chkIsEmployee" runat="server" clientidmode="Static" />
                                <label class="right required" for="IsEmployee">
                                    Is an Employee</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="border pad5 whitebg center" align="center" style="width: 50%">
                                <label class="right required" for="LastName">
                                    Last Name:</label>
                                <asp:TextBox ID="txtlastname" runat="server"></asp:TextBox>
                            </td>
                            <td class="border pad5 whitebg center" align="center" width="50%">
                                <label class="right required" for="FirstName">
                                    First Name:</label>
                                <asp:TextBox ID="txtfirstname" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="border pad5 whitebg center" align="center" style="width: 50%">
                                <label class="right required" for="UserName">
                                    User Name:</label>
                                <asp:TextBox ID="txtusername" runat="server"></asp:TextBox>
                            </td>
                            <td class="border pad5 whitebg" align="center" nowrap="noWrap">
                                <label class="right required" for="UserName">
                                    Designation:</label>
                                <asp:DropDownList ID="dddesignation" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="border pad5 whitebg center" align="center" style="width: 50%">
                                <label class="right required" for="passverification" id="lblPassword" clientidmode="Static"
                                    runat="server">
                                    Password:</label>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                            <td class="border pad5 whitebg center" align="center" width="50%">
                                <label class="right required" for="password" id="lblConfirmPassword" runat="server"
                                    clientidmode="Static">
                                    Confirm Password:</label>
                                <asp:TextBox ID="txtConfirmpassword" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="border pad5 whitebg center" align="center" style="width: 50%">
                                <label class="right" for="email">
                                    Email:</label>
                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                            </td>
                            <td class="border pad5 whitebg center" align="center" width="50%">
                                <label class="right" for="phone">
                                    Phone Number:</label>
                                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="border pad5 whitebg center" align="center" style="width: 50%">
                                <div class="center">
                                    <label class="left required" for="usergroup" style="vertical-align: top;" runat="server"
                                        id="lblUserGroup" clientidmode="Static">
                                        User Group:</label></div>
                                <div id="grdchkboldugrp" style="width: 90%; padding-left: 35px">
                                    <div nowrap='nowrap' class="divborder">
                                        <asp:CheckBoxList ID="lstUsergroup" runat="server" Width="90%" CausesValidation="True"
                                            CssClass="margin10">
                                        </asp:CheckBoxList>
                                    </div>
                                </div>
                            </td>
                            <td class="border pad5 whitebg center" colspan="2" align="center">
                                <div class="center">
                                    <label class="left" for="usergroup" style="vertical-align: top;">
                                        Stores:</label></div>
                                <div id="grdchkboldstore" style="width: 90%; padding-left: 35px">
                                    <div nowrap='nowrap' class="divborder">
                                        <asp:CheckBoxList ID="chklistStores" runat="server" Width="90%" CausesValidation="True"
                                            CssClass="margin10">
                                        </asp:CheckBoxList>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <%--<td class="border pad5 whitebg center" colspan="2" align="center">
                                <label class="right">
                                    Employee:</label>
                                <asp:DropDownList ID="DropDownList1" runat="server">
                                </asp:DropDownList>
                            </td>--%>
                            <td class="center" colspan="2" style="height: 31px">
                                &nbsp;
                                <asp:Button ID="btnDelete" runat="server" Text="Remove" OnClick="btnDelete_Click" />
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Reset" OnClick="btnCancel_Click" />
                                <asp:Button ID="btnExit" runat="server" Text="Back" OnClick="btnExit_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
