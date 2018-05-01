<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true" CodeBehind="frmFacilityHome.aspx.cs" Inherits="IQCare.Web.frmFacilityHome2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <br />
<h1 class="nomargin" id="tHeading" runat="server" style="padding-left: 10px;">
            Select Service</h1>
<div class="border center formbg" id="maindiv" runat="server">
          
            <asp:Table  runat="server" id="mainTable"  cellspacing="6" cellpadding="0" width="100%" border="0" >
            
            </asp:Table>
       <%-- <asp:UpdatePanel ID="divDetailsCompnent" UpdateMode="Conditional" runat="server">--%>
            <ContentTemplate>
                <asp:Button ID="btnShowItems" runat="server" Text="Test popup" Width="100px" Style="display: none" />
                <asp:Panel ID="divItems" runat="server" Style="display: none; width: 680px; border: solid 1px #808080;
                    background-color: #205E8D">
                    <asp:Panel ID="divItemTitle" runat="server" Style="border: solid 1px #808080; margin: 0px 0px 0px 0px;
                        cursor: move; height: 18px">
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 18px">
                            <tr>
                                <td style="width: 5px; height: 19px;">
                                </td>
                                <td style="width: 100%; height: 19px;">
                                    <span style="font-weight: bold;">
                                        <asp:Label ID="labelItemTitle"  runat="server">Select Option</asp:Label></span>
                                </td>
                                <td style="width: 5px; height: 19px;">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table cellpadding="1" cellspacing="1" border="0" width="680px" style="border: solid 1px #808080;
                        background-color: #CCFFFF; margin-bottom: 10px">
                        <tr>
                            <td valign="top" colspan="1" style="font-weight: bold; padding: 3px" align="left">
                                <asp:Label ID="labelItemMainType" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Button ID="btnPatientBill" runat="server" Width="45%" Text="Patient Bill" OnClientClick="window.location = './Billing/frmBillingFindAddBill.aspx'; return false;"
                                    Visible="False" Font-Bold="True"></asp:Button>&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnBillReports" runat="server" Width="45%" Text="Billing Reports"
                                    OnClientClick="window.location = './Billing/frmBillingReportPage.aspx'; return false;"
                                    Visible="False" Font-Bold="True"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Button ID="btnBillReversal" runat="server" Width="45%" Text="Bill Reversals"
                                    OnClientClick="window.location = './Billing/frmBilling_ReversalApproval.aspx'; return false;"
                                    Visible="False" Font-Bold="True"></asp:Button>&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnConsumables" runat="server" Width="45%" Text="Consumables" OnClientClick="window.location = './Billing/frmFindPatient.aspx?FormName=Consumables&mnuClicked=Consumables'; return false;"
                                    Visible="False" Font-Bold="True"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Button ID="btnBillSettings" runat="server" Width="45%" Text="Payment Methods"
                                    OnClientClick="window.location = './Billing/frmBillingAdmin_PaymentType.aspx'; return false;"
                                    Visible="False" Font-Bold="True"></asp:Button>&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnPriceList" runat="server" Width="45%" Text="Price List" OnClientClick="window.location = './Billing/frmBilling_PriceList.aspx'; return false;"
                                    Visible="False" Font-Bold="True"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnCancel" runat="server" Width="45%" Text="Close" Font-Bold="True">
                                </asp:Button>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <ajaxToolkit:ModalPopupExtender ID="billingOptionsPopup" runat="server" BehaviorID="ptpBehavior"
                    PopupControlID="divItems" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
                    DropShadow="true" Enabled="true" PopupDragHandleControlID="divItemTitle" TargetControlID="btnShowItems">
                </ajaxToolkit:ModalPopupExtender>
            </ContentTemplate>
        <%--</asp:UpdatePanel>--%>
        </div>
</asp:Content>
