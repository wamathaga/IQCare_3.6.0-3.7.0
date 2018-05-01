<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="frmBillingAdmin_PaymentType.aspx.cs"
    Inherits="IQCare.Web.Billing.BillingAdmin_PaymentType" %>

<%@ MasterType VirtualPath="~/MasterPage/IQCare.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <h5 class="margin" style="padding-left: 10px;">
            <asp:Label ID="lblHeader" runat="server" Text=""></asp:Label></h5>
        <div class="center" style="padding: 5px;">
            <div class="border center">
                <table width="100%" border="0" cellpadding="0" cellspacing="6">
                    <tbody>
                        <asp:Panel ID="divError" runat="server" Style="padding: 5px" CssClass="background-color: #FFFFC0; border: solid 1px #C00000"
                            HorizontalAlign="Left" Visible="true">
                            <tr>
                                <td>
                                    <asp:Label ID="lblError" runat="server" Style="font-weight: bold; color: #800000"
                                        Text=""></asp:Label>
                                </td>
                            </tr>
                        </asp:Panel>
                        <tr>
                            <td class="pad5 formbg border" style="vertical-align: top">
                                <div class="grid">
                                    <div class="rounded">
                                        <asp:UpdatePanel runat="server" ID="updatePanelMasterItem">
                                            <ContentTemplate>
                                                <div class="mid-outer">
                                                    <div class="mid-inner">
                                                        <div class="mid">
                                                            <div id="grd_payment" class="GridView whitebg" style="cursor: pointer; height: 280px;
                                                                overflow: auto">
                                                                <asp:GridView ID="gridPaymentType" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                                                                    Width="100%" PageIndex="1" BorderWidth="0px" GridLines="None" CssClass="datatable"
                                                                    CellPadding="0" OnRowDataBound="gridPaymentType_RowDataBound" OnSelectedIndexChanging="gridPaymentType_SelectedIndexChanging"
                                                                    OnSorting="gridPaymentType_Sorting" DataKeyNames="ID,Name">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Payment Type" SortExpression="Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="labelPayMethod" runat="server" Text='<%# Bind("Name") %>' ToolTip='<%# Bind("MethodDescription") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle CssClass="textstyle" />
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="MethodDescription" HeaderText="Description" ReadOnly="true"
                                                                            SortExpression="MethodDescription">
                                                                            <ItemStyle CssClass="textstyle" />
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Payment Plugin" SortExpression="Handler">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="labelHandler" runat="server" Text='<%# Bind("Handler") %>' ToolTip='<%# Bind("HandlerDescription") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle CssClass="textstyle" />
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Status" SortExpression="Active">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="labelStatus" runat="server" Text='<%# (Boolean.Parse(Eval("Active").ToString())) ? "Active" : "InActive" %>' />
                                                                            </ItemTemplate>
                                                                            <ItemStyle CssClass="textstyle" />
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <RowStyle CssClass="row" />
                                                                </asp:GridView>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="buttonSubmit" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="btnOkAction" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <div class="bottom-outer">
                                            <div class="bottom-inner">
                                                <div class="bottom">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="pad5 center">
                                <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" CssClass="btn btn-primary"
                                    Height="30px" Width="8%" Style="text-align: left;" />
                                <label class="glyphicon glyphicon-plus" style="margin-left: -3%; margin-right: 1%;
                                    vertical-align: sub; color: #fff;">
                                </label>
                                <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn btn-primary"
                                    Height="30px" Width="8%" Style="text-align: left; margin-left:2%;" />
                                <label class="glyphicon glyphicon-remove" style="margin-left: -3%; margin-right: 2%;
                                    vertical-align: sub; color: #fff;">
                                </label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <asp:UpdatePanel ID="ItemPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <asp:Button ID="btnShowItems" runat="server" Text="" Width="60px" Style="display: none" />
                    <asp:Panel ID="divItems" runat="server" Style="display: none; width: 680px; border: solid 1px #808080;
                        background-color: #479ADA" DefaultButton="buttonSubmit">
                        <asp:Panel ID="divItemTitle" runat="server" Style="border: solid 0px #808080; margin: 0px 0px 0px 0px;
                            cursor: move; height: 18px">
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 18px">
                                <tr>
                                    <td style="width: 5px; height: 19px;">
                                    </td>
                                    <td style="width: 100%; height: 19px;">
                                        <span style="font-weight: bold; color: White;">
                                            <asp:Label ID="labelItemTitle" runat="server">Payment Type Details</asp:Label></span>
                                    </td>
                                    <td style="width: 5px; height: 19px;">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table class= "table-condensed" width="680px" style="border: solid 0px #808080;
                            background-color: #EBEBEB; margin-bottom: 10px">
                            <tr>
                                <td colspan="2" align="left">
                                    <i>All of the fields in this section are required.</i>
                                </td>
                            </tr>
                            <asp:Panel ID="panelError" runat="server" Style="padding: 5px" CssClass="background-color: #FFFFC0; border: solid 1px #C00000"
                                HorizontalAlign="Left" Visible="true">
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="errorLabel" runat="server" Style="font-weight: bold; color: #800000"
                                            Text=""></asp:Label>
                                    </td>
                                </tr>
                            </asp:Panel>
                            <tr>
                                <td colspan="2">
                                    <hr class="forms">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                </td>
                                <td valign="top" colspan="1" style="font-weight: bold; padding: 3px" align="left">
                                    <asp:Label ID="labelItemMainType" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="font-weight: bold; float: right; margin-right: 50px;">
                                    Name:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="textPaymentTypeName" runat="server" Width="200px" AutoComplete="false"
                                        MaxLength="100"></asp:TextBox>
                                    <asp:HiddenField ID="prevPaymentName" runat="server" />
                                    <asp:HiddenField ID="currentID" runat="server" Value="-1" />
                                    <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server"
                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters,Custom" TargetControlID="textPaymentTypeName"
                                        ValidChars="&-, " />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td align="left" style="font-weight: bold; float: right; margin-right: 50px;">
                                    Short Code:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="textPaymentTypeCode" runat="server" Width="180px" AutoComplete="false"></asp:TextBox>
                                    <asp:HiddenField ID="prevTypeCode" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="font-weight: bold; float: right; margin-right: 50px;">
                                    Description:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="textDescription" runat="server" Width="200px" AutoComplete="false"
                                        TextMode="MultiLine" Rows="2" MaxLength="255"></asp:TextBox>
                                    <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters,Custom" TargetControlID="textDescription"
                                        ValidChars="&-, " />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td align="left" style="font-weight: bold; float: right; margin-right: 50px;">
                                    Priority :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSeqNo" Width="40px" runat="server"></asp:TextBox>
                                    <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                                        TargetControlID="txtSeqNo" FilterType="Numbers" FilterMode="ValidChars" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="font-weight: bold; float: right; margin-right: 50px;">
                                    Handler Name :
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlHandler" runat="server" Width="200px">
                                    </asp:DropDownList>
                                    <asp:HiddenField ID="prevhandlerName" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="font-weight: bold; float: right; margin-right: 50px;">
                                    Status:
                                </td>
                                <td align="left">
                                    <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1" Selected="True">Active</asp:ListItem>
                                        <asp:ListItem Value="0">InActive</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr style="height: 2px; color: #C0C0C0; margin: 1px; padding: 0px" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="white-space: nowrap; padding: 5px; text-align: center; padding-top: 5px;
                                    padding-bottom: 5px">
                                    <asp:Button ID="buttonSubmit" runat="server" Text="Save" OnClick="buttonSubmit_Click"
                                        CssClass="btn btn-primary" Height="30px" Width="10%" Style="text-align: left;" />
                                    <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -3%; margin-right: 1%;
                                        vertical-align: sub; color: #fff;">
                                    </label>
                                    <asp:Button ID="buttonClose" runat="server" Text="Close" CssClass="btn btn-primary"
                                        Height="30px" Width="10%" Style="text-align: left;" />
                                    <label class="glyphicon glyphicon-remove-circle" style="margin-left: -2.5%; margin-right: 2%;
                                        vertical-align: sub; color: #fff;">
                                    </label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajaxToolkit:ModalPopupExtender ID="paymentTypePopup" runat="server" BehaviorID="ptpBehavior"
                        TargetControlID="btnShowItems" PopupControlID="divItems" BackgroundCssClass="modalBackground"
                        CancelControlID="buttonClose" DropShadow="true" PopupDragHandleControlID="divItemTitle">
                    </ajaxToolkit:ModalPopupExtender>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gridPaymentType" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="gridPaymentType" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnOkAction" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdatePanel ID="notificationPanel" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="pnNotify" runat="server" Style="display: none; width: 460px; border: solid 1px #808080;
                        background-color: #E0E0E0; z-index: 15000">
                        <asp:Panel ID="pnPopup_Title" runat="server" Style="border: solid 1px #808080; margin: 0px 0px 0px 0px;
                            cursor: move; height: 18px">
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 18px">
                                <tr>
                                    <td style="width: 5px; height: 19px;">
                                    </td>
                                    <td style="width: 100%; height: 19px; background-color: #479ADA">
                                        <span style="font-weight: bold; color: Black">
                                            <asp:Label ID="lblNotice" runat="server">Add Editing Item</asp:Label></span>
                                    </td>
                                    <td style="width: 5px; height: 19px;">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table border="0" cellpadding="15" cellspacing="0" style="width: 100%;">
                            <tr>
                                <td style="width: 48px" valign="middle" align="center">
                                    <asp:Image ID="imgNotice" runat="server" ImageUrl="~/Images/mb_information.gif" Height="32px"
                                        Width="32px" />
                                </td>
                                <td style="width: 100%;" valign="middle" align="center">
                                    <asp:Label ID="lblNoticeInfo" runat="server" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div style="background-color: #FFFFFF; border-top: solid 1px #808080; width: 100%;
                            text-align: center; padding-top: 5px; padding-bottom: 5px">
                            <asp:Button ID="btnOkAction" runat="server" Text="OK" Width="80px" Style="border: solid 1px #808080;"
                                OnClick="btnOkAction_Click" />
                        </div>
                    </asp:Panel>
                    <asp:Button ID="btn" runat="server" Style="display: none" />
                    <ajaxToolkit:ModalPopupExtender ID="notifyPopupExtender" runat="server" TargetControlID="btn"
                        PopupControlID="pnNotify" BackgroundCssClass="modalBackground" DropShadow="True"
                        PopupDragHandleControlID="pnPopup_Title" Enabled="True" DynamicServicePath="">
                    </ajaxToolkit:ModalPopupExtender>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <asp:UpdateProgress ID="sProgress" runat="server" DisplayAfter="5">
            <ProgressTemplate>
                <div style="width: 100%; height: 100%; position: fixed; top: 0px; left: 0px; vertical-align: middle;">
                    <table style="position: relative; top: 45%; left: 45%; border: solid 1px #808080;
                        background-color: #FFFFC0; width: 120px; height: 24px;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="right" valign="middle" style="width: 30px; height: 22px;">
                                <img src="../Images/loading.gif" height="16px" width="16px" alt="" />
                            </td>
                            <td align="left" valign="middle" style="font-weight: bold; color: #808080; width: 90px;
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
