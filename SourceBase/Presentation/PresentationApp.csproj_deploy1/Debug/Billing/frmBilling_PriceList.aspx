<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="frmBilling_PriceList.aspx.cs" Inherits="IQCare.Web.Billing.frmBilling_PriceList" %>

<%@ MasterType VirtualPath="~/MasterPage/IQCare.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="ctMain" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script language="javascript" type="text/javascript">
        function PrintReport() {

            var _priceDate = $('#<%=textPriceListDate.ClientID%>').val();

            var url = "PrintPriceList.aspx?print=true";
            OpenNewWindow(url, "PrintPriceList");
        }
        function OpenNewWindow(pageurl, pgname) {
            var w = screen.width - 60;
            var h = screen.height - 60;
            var winprops = "location=no,scrollbars=yes,resizable=yes,status=no";
            var frmwin = window.open(pageurl, pgname, winprops);
            if (parseInt(navigator.appVersion) >= 4) {
                frmwin.window.focus();
            }
        }
             
    </script>
    <style>
        div.ajax__calendar_container, div.ajax__calendar_body
        {
            width: 225px;
        }
        
        .ajax__calendar_days td
        {
            padding: 2px 4px;
        }
    </style>
    <div>
        <h2 class="forms" align="left" style="margin-top:10px">
            Price List</h2>
        <asp:UpdatePanel runat="server" ID="divFilterComponent" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Panel ID="panelFilter" runat="server" DefaultButton="btnFilter">
                    <table cellspacing="6" cellpadding="0" width="100%" border="0" class="form pad5 center">
                        <tbody>
                            <tr>
                                <td style="text-align: left; margin-left: 3px;" >
                                    <asp:Button ID="btnPrint" runat="server" Text="Print Price List" Width="120px" Style="display: block;
                                        margin-bottom: 5px" OnClick="btnPrint_Click" />
                                    <ajaxToolkit:ConfirmButtonExtender ID="cbePrint" runat="server" DisplayModalPopupID="mpePrintPriceList"
                                        TargetControlID="btnPrint">
                                    </ajaxToolkit:ConfirmButtonExtender>
                                    <ajaxToolkit:ModalPopupExtender ID="mpePrintPriceList" runat="server" PopupControlID="pnlPopup"
                                        TargetControlID="btnPrint" OkControlID="btnYes" CancelControlID="btnNo" BackgroundCssClass="modalBackground">
                                    </ajaxToolkit:ModalPopupExtender>
                                    <asp:Panel ID="pnlPopup" runat="server" Style="display: none; background-color: #FFFFFF;
                                        width: 350px; border: 3px solid #479ADA;">
                                        <div style="background-color: #479ADA; height: 30px; color: White; line-height: 30px;
                                            text-align: center; font-weight: bold;">
                                            Confirmation
                                        </div>
                                        <div style="min-height: 30px; line-height: 20px; text-align: center; font-weight: bold;">
                                            The full price list will be printed.<br />
                                            Only items whose price has been set will be printed.
                                        </div>
                                        <div style="min-height: 30px; line-height: 20px; text-align: center; font-weight: bold;">
                                            Effective Date:&nbsp;&nbsp;
                                            <asp:TextBox ID="textPriceListDate" runat="server" Text="" MaxLength="11" Width="70px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="textPriceListDate"
                                                ErrorMessage="*" Display="None" ValidationExpression="^(0?[1-9]|[12][0-9]|3[01])-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-(19|20)\d\d$"></asp:RegularExpressionValidator><br />
                                            <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" TargetControlID="textPriceListDate"
                                                Format="dd-MMM-yyyy" />
                                            <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="textPriceListDate"
                                                Enabled="True" UserDateFormat="DayMonthYear" CultureDateFormat="dd-MMM-yyyy"
                                                ClearMaskOnLostFocus="False" CultureName="en-GB" Mask="99-LLL-9999">
                                            </ajaxToolkit:MaskedEditExtender>
                                        </div>
                                        <div style="min-height: 30px; line-height: 20px; text-align: center; font-weight: bold;">
                                            Do you want to proceed?
                                        </div>
                                        <div style="padding: 3px;" align="right">
                                            <asp:Button ID="btnYes" runat="server" Text="OK"  /><asp:Button
                                                ID="btnNo" runat="server" Text="Cancel"  /></div>
                                    </asp:Panel>
                                </td>
                                <td style="text-align: left; margin-left: 3px;width: 80px;">
                                    Item Type: 
                                </td>
                                <td style="text-align: left; white-space: nowrap">
                                    <asp:DropDownList ID="ddlItemType" runat="server" AutoPostBack="false">
                                    </asp:DropDownList>
                                </td>
                                <td style="text-align: left; margin-left: 3px; width: 80px;">
                                   Item Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="textSearchText" runat="server" MaxLength="25" Width="200px"></asp:TextBox>
                                    <ajaxToolkit:FilteredTextBoxExtender ID="fteSearchText" runat="server" FilterType="Numbers, UppercaseLetters, LowercaseLetters,Custom"
                                        TargetControlID="textSearchText" ValidChars="-/\* ">
                                    </ajaxToolkit:FilteredTextBoxExtender>
                                </td>
                                <td style="text-align: left; margin-left: 3px;width: 250px;">
                                    Show priced only
                                    <asp:RadioButtonList ID="rblOption" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Selected="True" Value="No">No </asp:ListItem>
                                        <asp:ListItem Value="Yes">Yes </asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td style="text-align: left; white-space: nowrap">
                                    <asp:Button ID="btnFilter" runat="server" Text="View" Width="80px" OnClick="btnFilter_Click"
                                        CausesValidation="false" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnFilter" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel runat="server" ID="divErrorCompenent" UpdateMode="Always">
            <ContentTemplate>
                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                    <tbody>
                        <tr>
                            <td align="left" style="padding-left: 10px; padding-right: 15px">
                                <asp:Panel ID="divError" runat="server" Style="padding: 5px" CssClass="background-color: #FFFFC0; border: solid 1px #C00000"
                                    HorizontalAlign="Left" Visible="true">
                                    <asp:Label ID="lblError" runat="server" Style="font-weight: bold; color: #800000"
                                        Text=""></asp:Label>
                                </asp:Panel>
                                <asp:HiddenField ID="HPageIndex" runat="server" />
                                <asp:HiddenField ID="HSearchText" runat="server" />
                                <asp:HiddenField ID="HItemType" runat="server" />
                                <asp:HiddenField ID="HPerm" runat="server" />
                                <asp:HiddenField ID="HPages" runat="server" />
                                <asp:HiddenField ID="HPriced" runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="divGridComponent" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                    <tbody>
                        <tr>
                            <td class="pad5 formbg border">
                                <div id="divPriceList" class="grid" style="width: 100%;">
                                    <div class="rounded">
                                        <div class="top-outer">
                                            <div class="top-inner">
                                                <div class="top">
                                                    <h2>
                                                        <asp:Label runat="server" ID="labelNote"></asp:Label></h2>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mid-outer">
                                            <div class="mid-inner">
                                                <div class="mid" style="height: 280px; overflow: auto">
                                                    <div id="div-PricelistGridview" class="GridView whitebg">
                                                        <asp:GridView ID="gridPriceList" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            BorderColor="White" BorderWidth="1px" CellPadding="0" GridLines="None" CssClass="datatable"
                                                            EmptyDataText="No Data to display" ShowHeaderWhenEmpty="True" Width="100%" BorderStyle="Solid"
                                                            DataKeyNames="ItemID,ItemTypeID,VersionStamp" OnRowCommand="gridPriceList_RowCommand"
                                                            OnRowDataBound="gridPriceList_RowDataBound" PageSize="50" OnRowCreated="gridPriceList_RowCreated"
                                                            AllowPaging="false" Visible="true">
                                                            <Columns>
                                                                <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-Width="40%">
                                                                    <ItemStyle Width="40%" />
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Selling Price">
                                                                    <ItemTemplate>
                                                                        <span style='display: <%# HideEdit() %>; white-space: nowrap'>
                                                                            <asp:Label ID="labelPrice" runat="server" Text='<%# Bind("SellingPrice", "{0:N}") %>'></asp:Label>
                                                                        </span><span style='display: <%# ShowInEdit() %>; white-space: nowrap'>
                                                                            <asp:TextBox ID="textPrice" runat="server" Text='<%# Bind("SellingPrice", "{0:N}") %>'
                                                                                MaxLength="11" Width="70px"></asp:TextBox>
                                                                            <ajaxToolkit:FilteredTextBoxExtender ID="ftePrice" runat="server" TargetControlID="textPrice"
                                                                                FilterType="Numbers, Custom" ValidChars="." />
                                                                        </span>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="15%" />
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Pricing Type">
                                                                    <ItemTemplate>
                                                                        <span style='display: <%# HideEdit() %>; white-space: nowrap'>
                                                                            <asp:Label ID="labelPriceType" runat="server"></asp:Label>
                                                                        </span><span style='display: <%# ShowInEdit() %>; white-space: nowrap'>
                                                                            <asp:DropDownList runat="server" ID="ddlPriceType" AutoPostBack="false">
                                                                                <asp:ListItem Value="Item">Item</asp:ListItem>
                                                                                <asp:ListItem Value="Dose">Dose</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </span>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="10%" />
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Effective Date">
                                                                    <ItemTemplate>
                                                                        <span style='display: <%# HideEdit() %>; white-space: nowrap'>
                                                                            <asp:Label ID="labelPriceDate" runat="server" Text='<%# Bind("PriceDate", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                                                        </span>
                                                                        <div style='display: <%# ShowInEdit() %>; white-space: nowrap'>
                                                                            <asp:TextBox ID="textPriceDate" runat="server" Text='<%# Bind("PriceDate", "{0:dd-MMM-yyyy}") %>'
                                                                                MaxLength="11" Width="70px"></asp:TextBox>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="textPriceDate"
                                                                                ErrorMessage="*" Display="None" ValidationExpression="^(0?[1-9]|[12][0-9]|3[01])-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-(19|20)\d\d$"></asp:RegularExpressionValidator><br />
                                                                            <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" TargetControlID="textPriceDate"
                                                                                Format="dd-MMM-yyyy" OnClientDateSelectionChanged="disable_past_dates" />
                                                                            <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="textPriceDate"
                                                                                Enabled="True" UserDateFormat="DayMonthYear" CultureDateFormat="dd-MMM-yyyy"
                                                                                ClearMaskOnLostFocus="False" CultureName="en-GB" Mask="99-LLL-9999">
                                                                            </ajaxToolkit:MaskedEditExtender>
                                                                        </div>
                                                                        <asp:HiddenField ID="hdVersionStamp" runat="server" Value="" />
                                                                        <asp:HiddenField ID="HFlag" runat="server" Value="" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="15%" />
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Delete">
                                                                    <ItemTemplate>
                                                                        <span style='display: <%# ShowInEdit() %>; white-space: nowrap'>
                                                                            <asp:CheckBox runat="server" ID="chkDelete" AutoPostBack="false" TextAlign="Left" />
                                                                        </span>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="10%" />
                                                                    <HeaderStyle HorizontalAlign="Left" />
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
                                        <div class="bottom" style="text-align: center">
                                            <br />
                                            <div id="divAction" style="white-space: nowrap; text-align: center;">
                                                <asp:Button ID="buttonSave" runat="server" Text="Save" Width="80px" OnClick="buttonSave_Click"
                                                    CausesValidation="false" />
                                                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnClose" runat="server" Text="Close"  Width="80px" /></div>
                                            <br />
                                            
                                            <asp:Repeater ID="rptPager" runat="server" Visible="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                                                        Enabled='<%# Eval("Enabled") %>' OnClick="Page_Changed"></asp:LinkButton>
                                                       
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="form pad5 center" style="white-space: nowrap; text-align: center">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnOkAction" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnFilter" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="notificationPanel" runat="server">
            <ContentTemplate>
                <asp:Button ID="btn" runat="server" Style="display: none" />
                <asp:Panel ID="pnNotify" runat="server" Style="display: none; width: 460px; border: solid 1px #808080;
                    background-color: #E0E0E0; z-index: 15000">
                    <asp:Panel ID="pnPopup_Title" runat="server" Style="border: solid 1px #808080; margin: 0px 0px 0px 0px;
                        cursor: move; height: 18px">
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 18px;
                            background-color: #6699FF">
                            <tr>
                                <td style="width: 5px; height: 19px;">
                                </td>
                                <td style="width: 100%; height: 19px;">
                                    <span style="font-weight: bold; color: White">
                                        <asp:Label ID="lblNotice" runat="server">Price</asp:Label></span>
                                </td>
                                <td style="width: 5px; height: 19px;">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table border="0" cellpadding="15" cellspacing="0" style="width: 100%;">
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
