﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmAdmissionHome.aspx.cs" EnableEventValidation="false" Inherits="IQCare.Web.Admission.frmAdmissionHome" %>

<%@ MasterType VirtualPath="~/MasterPage/IQCare.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="PatientWardAdmission.ascx" TagName="PatientWardAdmission" TagPrefix="paf" %>
<asp:Content ID="ctMain" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <%-- <script src="../Incl/quicksearch.js" type="text/javascript" defer="defer"></script>
    <script type="text/javascript">
        $(function () {
            $('.search_textbox').each(function (i) {
                $(this).quicksearch("[id*=gridAdmission] tr:not(:has(th))", {
                    'testQuery': function (query, txt, row) {
                        return $(row).children(":eq(" + i + ")").text().toLowerCase().indexOf(query[0].toLowerCase()) != -1;
                    }
                });
            });
        });

    </script>--%>
    <div class="container-fluid">
        <h4 class="forms h4" align="left">
            Wards Admission</h4>
        <asp:UpdatePanel runat="server" ID="divWardComponent">
            <ContentTemplate>
                <table class="table-condensed" width="100%">
                    <tbody>
                        <tr>
                            <td class="form">
                                <center>
                                    <asp:Button ID="btnNewAdmission" runat="server" Text="New Admission" CssClass="btn btn-success"
                                        Height="30px" Width="80%" Style="text-align: left;" />
                                    <label class="glyphicon glyphicon-plus-sign" style="margin-left: -15%; vertical-align: -webkit-baseline-middle;
                                        color: #fff;">
                                    </label>
                                </center>
                            </td>
                            <td class="form" style="text-align: right; vertical-align: top; elevation: above;
                                white-space: nowrap">
                                <asp:Panel ID="panelFilter" runat="server" DefaultButton="btnFilter">
                                    Wards: &nbsp;&nbsp;&nbsp;
                                    <asp:DropDownList ID="ddlPatientWard" runat="server" Width="235px" AutoPostBack="false"
                                        OnSelectedIndexChanged="SelectedWardChanged">
                                    </asp:DropDownList>
                                    &nbsp;&nbsp;&nbsp;&nbsp; Show Discharged: &nbsp;&nbsp;&nbsp;<asp:RadioButtonList
                                        ID="rblOption" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Selected="True">No</asp:ListItem>
                                        <asp:ListItem>Yes</asp:ListItem>
                                    </asp:RadioButtonList>
                                    &nbsp;&nbsp;&nbsp;<asp:Button ID="btnFilter" runat="server" Text="View" OnClick="btnFilter_Click"
                                        CssClass="btn btn-primary" Height="30px" Width="9%" Style="text-align: left;" />
                                    <label class="glyphicon glyphicon-list" style="margin-left: -3%; vertical-align: -webkit-baseline-middle;
                                        color: #fff;">
                                    </label>
                                </asp:Panel>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="buttonDischarge" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <table width="100%" class="table-condensed">
            <tbody>
                <tr>
                    <td align="left" style="padding-left: 10px; padding-right: 15px">
                        <asp:UpdatePanel runat="server" ID="divErrorCompenent" UpdateMode="Always">
                            <ContentTemplate>
                                <asp:Panel ID="divError" runat="server" Style="padding: 5px" CssClass="background-color: #FFFFC0; border: solid 1px #C00000"
                                    HorizontalAlign="Left" Visible="true">
                                    <asp:Label ID="lblError" runat="server" Style="font-weight: bold; color: #800000"
                                        Text=""></asp:Label>
                                </asp:Panel>
                                <asp:HiddenField ID="HSelectedID" runat="server" />
                                <asp:HiddenField ID="HDate" runat="server" />
                                <asp:HiddenField ID="HStatus" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </tbody>
        </table>
        <asp:UpdatePanel ID="divGridComponent" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table class="table-condensed" width="100%">
                    <tbody>
                        <tr>
                            <td class="pad5 formbg border">
                                <div id="divAdmissions" class="grid" style="width: 100%;">
                                    <div class="rounded">
                                        <div class="mid-outer">
                                            <div class="mid-inner">
                                                <div class="mid" style="height: 280px; overflow: auto">
                                                    <div id="div-AdmissionsGridview" class="GridView whitebg">
                                                        <asp:GridView ID="gridAdmission" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            BorderColor="White" BorderWidth="1px" CellPadding="0" GridLines="None" CssClass="datatable"
                                                            EmptyDataText="No Data to display" ShowHeaderWhenEmpty="True" Width="100%" BorderStyle="Solid"
                                                            DataKeyNames="AdmissionID,PatientID,WardID" OnRowCommand="gridAdmission_RowCommand"
                                                            OnRowDataBound="gridAdmission_RowDataBound" OnDataBound="gridAdmission_DataBound">
                                                            <Columns>
                                                                <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient #" />
                                                                <asp:BoundField DataField="WardName" HeaderText="Ward" />
                                                                <asp:BoundField DataField="BedNumber" HeaderText="Bed #" />
                                                                <asp:BoundField DataField="AdmissionDate" HeaderText="Date Admitted" DataFormatString="{0:dd-MMM-yyyy}" />
                                                                <asp:BoundField DataField="ReferredFrom" HeaderText="Referred From" />
                                                                <asp:BoundField HeaderText="Discharged?" DataField="Discharged" InsertVisible="False">
                                                                </asp:BoundField>
                                                                <asp:TemplateField InsertVisible="False" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <div style="white-space: nowrap">
                                                                            <asp:Button ID="buttonDetails" runat="server" CausesValidation="false" CommandName="ViewEdit"
                                                                                Text="View/Edit" CommandArgument="<%# Container.DataItemIndex %>" ForeColor="White"
                                                                                CssClass="btn btn-primary" Height="30px"></asp:Button>
                                                                            <span style='display: <%# ShowDischarge(Eval("Discharged")) %>; white-space: nowrap'>
                                                                                <asp:Button ID="buttonDischarge" runat="server" CausesValidation="false" CommandName="Discharge"
                                                                                    Text="Discharge" CommandArgument="<%# Container.DataItemIndex %>" Visible="true"
                                                                                    ForeColor="White" CssClass="btn btn-primary" Height="30px" />
                                                                            </span>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <RowStyle CssClass="row" />
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="bottom-outer">
                                    <div class="bottom-inner">
                                        <div class="bottom">
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlPatientWard" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="gridAdmission" EventName="RowCommand" />
                <asp:AsyncPostBackTrigger ControlID="btnOkAction" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnFilter" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="buttonDischarge" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="divAdmitComponent" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <paf:PatientWardAdmission ID="AdmitPatient" runat="server" OpenMode="VIEW" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gridAdmission" EventName="RowCommand" />
                <asp:AsyncPostBackTrigger ControlID="btnOkAction" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="divDischargeComponent" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnCal" runat="server" Style="display: none" />
                <asp:Panel ID="panelDischarge" runat="server" Style="display: none; width: 350px;
                    border: solid 1px #808080; background-color: #6699FF" Width="320px" DefaultButton="buttonDischarge">
                    <asp:Panel ID="divTitle" runat="server" Style="cursor: move; height: 18px">
                        <h5 class=" h5" align="center">
                            Discharge Patient Form
                        </h5>
                    </asp:Panel>
                    <table width="350px" style="margin-bottom: 10px" class="table-condensed border left whitebg">
                        <tr>
                            <td style="width: 48px" valign="middle" align="center">
                                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/mb_information.gif" Height="32px"
                                    Width="32px" />
                            </td>
                            <td style="width: 100%;" valign="middle" align="center">
                                <div style="line-height: 30px; text-align: center; font-weight: bold;">
                                    Please note that this action cannot be reversed.
                                </div>
                                Discharge Date:&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="textDischargeDate" runat="server" Width="80px" MaxLength="12" AutoComplete="false"></asp:TextBox>
                                <img id="Img4" onclick="w_displayDatePicker('<%=textDischargeDate.ClientID%>');"
                                    height="24" alt="Date Helper" src="../images/cal_icon.gif" width="22" border="0"
                                    name="appDateimg" style="vertical-align: bottom;" />
                                <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" TargetControlID="textDischargeDate"
                                    PopupButtonID="Image1" Format="dd-MMM-yyyy" OnClientDateSelectionChanged="disable_future_dates" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form pad5 center" style="white-space: nowrap; text-align: center; border: 0"
                                colspan="2">
                                <div id="divAction" style="white-space: nowrap">
                                    <asp:Button ID="buttonDischarge" runat="server" Text="Discharge" Width="80px" OnClick="buttonDischarge_Click"
                                        CssClass="btn btn-info" Height="30px" Style="text-align: center" />
                                    <asp:Button ID="buttonCancel" runat="server" Text="Cancel" Width="80px" CssClass="btn btn-info"
                                        Height="30px" Style="text-align: center" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <ajaxToolkit:ModalPopupExtender ID="modalDischarge" runat="server" TargetControlID="btnCal"
                    PopupControlID="panelDischarge" BackgroundCssClass="modalBackground" DropShadow="True"
                    PopupDragHandleControlID="divTitle" Enabled="True" DynamicServicePath="" BehaviorID="mpeBID32803"
                    CancelControlID="buttonCancel">
                </ajaxToolkit:ModalPopupExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="notificationPanel" runat="server">
            <ContentTemplate>
                <asp:Button ID="btn" runat="server" Style="display: none" />
                <asp:Panel ID="pnNotify" runat="server" Style="display: none; width: 460px; border: solid 1px #808080;
                    background-color: #E0E0E0; z-index: 15000">
                    <asp:Panel ID="pnPopup_Title" runat="server" Style="border: solid 1px #808080; margin: 0px 0px 0px 0px;
                        cursor: move; height: 18px">
                        <table class="table-condensed" style="width: 100%; height: 18px; background-color: #6699FF">
                            <tr>
                                <td style="width: 5px; height: 19px;">
                                </td>
                                <td style="width: 100%; height: 19px;">
                                    <span style="font-weight: bold; color: Black">
                                        <asp:Label ID="lblNotice" runat="server">Admission</asp:Label></span>
                                </td>
                                <td style="width: 5px; height: 19px;">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="table-condensed" style="width: 100%;">
                        <tr>
                            <td style="width: 48px" valign="middle" align="center">
                                <asp:Image ID="imgNotice" runat="server" ImageUrl="~/images/mb_information.gif" Height="32px"
                                    Width="32px" />
                            </td>
                            <td style="width: 100%;" valign="middle" align="center">
                                <asp:Label ID="lblNoticeInfo" runat="server" Font-Bold="True"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <div style="background-color: #FFFFFF; border-top: solid 1px #808080; width: 100%;
                        text-align: center; padding-top: 5px; padding-bottom: 5px">
                        <asp:Button ID="btnOkAction" runat="server" Text="Close" Width="120px" Style="border: solid 1px #808080;"
                            OnClick="btnOkAction_Click" />&nbsp;&nbsp;&nbsp;<asp:Button ID="btnExit" runat="server"
                                Text="Close" Width="80px" Style="border: solid 1px #808080; display: none" /></div>
                </asp:Panel>
                <ajaxToolkit:ModalPopupExtender ID="notifyPopupExtender" runat="server" TargetControlID="btn"
                    PopupControlID="pnNotify" BackgroundCssClass="modalBackground" DropShadow="True"
                    PopupDragHandleControlID="pnPopup_Title" Enabled="True" DynamicServicePath=""
                    OkControlID="btnOkAction">
                </ajaxToolkit:ModalPopupExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="sProgress" runat="server" DisplayAfter="5">
            <ProgressTemplate>
                <div style="width: 100%; height: 100%; position: fixed; top: 0px; left: 0px; vertical-align: middle;
                    background-color: Gray; filter: alpha(opacity=50); opacity: 0.7; z-index: 120;
                    moz-opacity: 0.5; khtml-opacity: .5">
                    <table style="position: relative; top: 45%; left: 45%; border: solid 1px #808080;
                        background-color: #FFFFC0; width: 110px; height: 24px;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="right" valign="middle" style="width: 30px; height: 22px;">
                                <img src="../Images/loading.gif" height="16px" width="16px" alt="" />
                            </td>
                            <td align="left" valign="middle" style="font-weight: bold; color: #808080; width: 80px;
                                height: 22px; padding-left: 5px">
                                Processing....
                            </td>
                        </tr>
                    </table>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</asp:Content>
