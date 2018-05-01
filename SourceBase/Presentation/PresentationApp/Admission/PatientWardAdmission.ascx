<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PatientWardAdmission.ascx.cs"
    Inherits="IQCare.Web.Admission.PatientWardAdmission" %>
<%@ Register Assembly="AjaxControlToolkit" TagPrefix="ajaxToolkit" Namespace="AjaxControlToolkit" %>
<link href="../Style/bootstrap-3.3.6-dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="../Style/bootstrap-3.3.6-dist/css/bootstrap-theme.css" rel="stylesheet"
    type="text/css" />
<script src="../Style/bootstrap-3.3.6-dist/html5Shiv/html5shiv.js" type="text/javascript"></script>
<div class="container-fluid">
    <asp:Panel ID="panelPopup" runat="server" Style="display: none; width: 680px; border: solid 1px #808080;
        background-color: #479ADA;" Width="680px" DefaultButton="buttonAdmit">
        <asp:Panel ID="divTitle" runat="server" Style="border: solid 1px #808080; cursor: move;
            height: 30px; text-align: center;">
            <h5 class=" h5 forms" style="color: White;">
                Admission Form
            </h5>
        </asp:Panel>
        <table width="680px" style="margin-bottom: 10px" class="table-condensed border left whitebg">
            <tr>
                <td colspan="2">
                    <table style="width: 100%" class="table-condensed">
                        <tbody>
                            <tr>
                                <td style="width: 170px; font-weight: bold">
                                    Patient Name:
                                </td>
                                <td style="width: 170">
                                    <asp:Label ID="lblname" runat="server"></asp:Label>
                                </td>
                                <td style="width: 380; white-space: nowrap" colspan="2">
                                    <b>Age:</b>&nbsp;&nbsp;&nbsp;<asp:Label ID="lblAge" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                                    <b>Sex:</b> &nbsp;&nbsp;&nbsp;<asp:Label ID="lblSex" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">
                                    Patient Facility ID:
                                </td>
                                <td>
                                    <asp:Label ID="lblFacilityID" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Panel ID="panelError" runat="server" Style="padding: 5px" CssClass="background-color: #FFFFC0; border: solid 1px #C00000"
                        HorizontalAlign="Left" Visible="true">
                        <asp:Label ID="errorLabel" runat="server" Style="font-weight: bold; color: #800000"
                            Text=""></asp:Label>
                        <asp:HiddenField ID="HPatientID" runat="server" />
                        <asp:HiddenField ID="HAdmissionID" runat="server" Value="-1" />
                        <asp:HiddenField ID="HMode" runat="server" Value="New" />
                        <asp:HiddenField ID="HLocationID" runat="server" />
                        <asp:HiddenField ID="HUserID" runat="server" />
                        <asp:HiddenField ID="HPatientGender" runat="server" />
                        <asp:HiddenField ID="HPatientAge" runat="server" />
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr class="forms" />
                </td>
            </tr>
            <tr>
                <td align="right" class="required">
                    <b>Select Ward:</b>
                </td>
                <td align="left" style="white-space: nowrap; vertical-align: text-top" nowrap="nowrap"
                    valign="top">
                    <span style="display: <% = sVid %>">
                        <asp:UpdatePanel ID="divWardPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlPatientWard" runat="server" Width="235px" AutoPostBack="true"
                                    OnSelectedIndexChanged="SelectedWardChanged">
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="labelAvailablity" Font-Bold="true" ForeColor="Red"
                                    Style="text-align: right; margin-bottom: 10px;" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </span>
                    <asp:Label ID="labelWard" runat="server" Visible="false" Font-Bold="true" />
                </td>
            </tr>
            <tr>
                <td align="right" height="25px;" class="required">
                    <b>Referred From:</b>
                </td>
                <td align="left" height="18px;">
                    <span style="color: #FF0000; display: <% = sVid %>">
                        <asp:DropDownList ID="ddlReferral" runat="server" Width="235px" AutoPostBack="false"
                            AppendDataBoundItems="true">
                        </asp:DropDownList>
                    </span>
                    <asp:Label ID="labelReferred" runat="server" Visible="false" Font-Bold="true" />
                </td>
            </tr>
            <tr id="trOtherSource" style="display: none">
                <td align="left" style="white-space: nowrap">
                    &nbsp;&nbsp;Other Source:
                </td>
                <td align="left">
                    <asp:TextBox ID="textReferral" runat="server" MaxLength="50" Width="230px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" style="white-space: nowrap" class="required">
                    <b>Bed Number:</b>
                </td>
                <td align="left">
                    <span style="color: #FF0000; display: <% = sVid %>">
                        <asp:TextBox ID="textBedNumber" runat="server" MaxLength="10" Width="230px"></asp:TextBox>
                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                            FilterType="Numbers, UppercaseLetters, LowercaseLetters,Custom" TargetControlID="textBedNumber"
                            ValidChars="-/\"></ajaxToolkit:FilteredTextBoxExtender>
                    </span>
                    <asp:Label ID="labelBedNumber" runat="server" Visible="false" Font-Bold="true" />
                </td>
            </tr>
            <tr>
                <td align="right" class="required">
                    <b>Admission Date:</b>
                </td>
                <td align="left" style="white-space: nowrap; vertical-align: middle">
                    <span style="color: #FF0000; display: <% = sVid %>">
                        <asp:TextBox ID="textAdmissionDate" runat="server" Width="230px" MaxLength="12" AutoComplete="false"></asp:TextBox>
                        <asp:ImageButton runat="Server" ID="Image1" Height="22" Style="hspace: 3; width: 22;
                            vertical-align: bottom; height: 22" ImageUrl="~/Images/cal_icon.gif" AlternateText="Click to show calendar" />
                        <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" TargetControlID="textAdmissionDate"
                            PopupButtonID="Image1" Format="dd-MMM-yyyy" OnClientDateSelectionChanged="disable_future_dates" />
                    </span>
                    <asp:Label ID="labelAdmissionDate" runat="server" Visible="false" Font-Bold="true" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span style="display: <% = sVid %>">&nbsp;&nbsp;</span><b>Expected Discharge:</b>
                </td>
                <td align="left" style="white-space: nowrap; vertical-align: middle">
                    <span style="color: #FF0000; display: <% = sVid %>">
                        <asp:TextBox ID="textExpectedDOD" runat="server" Width="230px" MaxLength="12" AutoComplete="false"></asp:TextBox>
                        <asp:ImageButton runat="Server" ID="ImageButton1" Height="22" Style="width: 22; height: 22;
                            vertical-align: bottom;" ImageUrl="~/Images/cal_icon.gif" AlternateText="Click to show calendar" />
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="textExpectedDOD"
                            PopupButtonID="ImageButton1" Format="dd-MMM-yyyy" />
                    </span>
                    <asp:Label ID="labelExpectedDOD" runat="server" Visible="false" Font-Bold="true" />
                </td>
            </tr>
            <tr style="display: <% = sEdit %>">
                <td align="left">
                    <span style="display: <% = sVid %>">&nbsp;&nbsp;</span>Admitted By:
                </td>
                <td align="left" style="white-space: nowrap; vertical-align: middle">
                    <asp:Label ID="labelAdmittedBy" runat="server" Visible="true" Font-Bold="true" />
                </td>
            </tr>
            <tr style="display: <% = inversNew %>">
                <td align="left">
                    <span style="display: <% = sVid %>">&nbsp;&nbsp;</span>Discharge
                </td>
                <td align="left" style="white-space: nowrap; vertical-align: middle">
                    <asp:Label ID="labelDischarge" runat="server" Visible="true" Font-Bold="true" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr class="forms" />
                </td>
            </tr>
            <tr>
                <td class="form pad5 center" style="white-space: nowrap; text-align: center; border: 0"
                    colspan="2">
                    <div id="divAction" style="white-space: nowrap; border: 0; text-align: center;">
                        <span style="display: <% = sVid %>">&nbsp;&nbsp;&nbsp;<asp:Button ID="buttonAdmit"
                            runat="server" Text="Save Admission" Width="120px" OnClick="buttonAdmit_Click"
                            CssClass="btn btn-info" Height="30px" />
                            &nbsp;&nbsp;&nbsp;</span>
                        <asp:Button ID="buttonCancelAddWard" runat="server" Text="Cancel" Width="80px" OnClick="buttonCancelAddWard_Click"
                            CssClass="btn btn-info" Height="30px" />
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Button ID="buttonRaiseItemPopup" runat="server" Style="display: none" />
    <ajaxToolkit:ModalPopupExtender ID="AdmissionDialog" runat="server" TargetControlID="buttonRaiseItemPopup"
        PopupControlID="panelPopup" BackgroundCssClass="modalBackground" DropShadow="True"
        BehaviorID="admisionx572" PopupDragHandleControlID="divTitle" Enabled="True"
        CancelControlID="buttonCancelAddWard" DynamicServicePath="">
    </ajaxToolkit:ModalPopupExtender>
</div>
