<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmPharmacy_StockSummary.aspx.cs" Inherits="PresentationApp.PharmacyDispense.frmPharmacy_StockSummary"
    EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<%@ Register Src="../ClinicalForms/UserControl/UserControl_Loading.ascx" TagName="UserControl_Loading"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <%--<asp:ScriptManager ID="mst" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
    </asp:ScriptManager>--%>
    <script type="text/javascript">
            function ace1_itemSelected(source, e) {
            var index = source._selectIndex;
            if (index != -1) {
                var hdCustID = $get('<%= hdCustID.ClientID %>');
                hdCustID.value = e.get_value();
            }
        }
    </script>
    <asp:HiddenField ID="hdCustID" runat="server" />
    <style type="text/css">
        #mainMaster
        {
            width: 100% !important;
        }
        #containerMaster
        {
            width: 1200px !important;
        }
        #ulAlerts
        {
            width: 1180px !important;
        }
        #divPatientInfo123
        {
            width: 1180px !important;
        }
        #Img2
        {
            height: 22px;
        }
        #Img3
        {
            height: 22px;
        }
        
        #blur
        {
            width: 100%;
            background-color: black;
            moz-opacity: 0.5;
            khtml-opacity: .5;
            opacity: .5;
            filter: alpha(opacity=50);
            z-index: 120;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
        }
        #progress
        {
            z-index: 200;
            background-color: White;
            position: absolute;
            top: 0pt;
            left: 0pt;
            border: solid 1px black;
            padding: 5px 5px 5px 5px;
            text-align: center;
        }
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=40);
            opacity: 0.4;
        }
        .FreezeHeader
        {
            top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop-2); 
            left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
            position: relative; 
            z-index: 20;
        }
    </style>
    <table cellspacing="6" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <table style="width: 100%">
                    <tr valign="top">
                        <td class="data-control">
                            <table style="width: 100%">
                                <tr>
                                    <td width="33%">
                                        <asp:Label ID="Label7" runat="server" CssClass="required" Font-Bold="True" Text="Store:"></asp:Label>&nbsp;
                                        <asp:DropDownList ID="ddlStore" runat="server" Width="235px" Height="16px" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlStore_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td width="5%">
                                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Text="Items:"></asp:Label>&nbsp;
                                    </td>
                                    <td>
<%--                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>--%>
                                                <asp:TextBox ID="txtSearch" runat="server" Width="90%"></asp:TextBox>
                                                <div id="divwidth">
                                                </div>
                                                <act:AutoCompleteExtender runat="server" ServiceMethod="SearchBorrower" MinimumPrefixLength="2"
                                                    CompletionInterval="20" EnableCaching="false" CompletionSetCount="10" TargetControlID="txtSearch"
                                                    ID="AutoCompleteSearchBorrower" FirstRowSelected="true" CompletionListElementID="divwidth"
                                                    OnClientItemSelected="ace1_itemSelected" UseContextKey="True">
                                                </act:AutoCompleteExtender>
                                           <%-- </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlStore" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>--%>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table width="100%">
                                <tr>
                                    <td width="33%">
                                        <asp:Label ID="Label22" runat="server" Font-Bold="True" Text="From:"></asp:Label>
                                        &nbsp;<asp:TextBox ID="dtFrom" runat="server" Width="125px"></asp:TextBox>
                                        <img id="Img2" onclick="w_displayDatePicker('<%=dtFrom.ClientID%>');" alt="Date Helper"
                                            hspace="5" src="../images/cal_icon.gif" width="22" border="0" name="appDateimg1"
                                            style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel"
                                                id="Span4"> (DD-MMM-YYYY)</span>
                                    </td>
                                    <td width="33%">
                                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="To:"></asp:Label>
                                        &nbsp;<asp:TextBox ID="dtTo" runat="server" Width="125px"></asp:TextBox>
                                        <span class="smallerlabel" id="Span3">
                                            <img id="Img3" onclick="w_displayDatePicker('<%=dtTo.ClientID%>');" alt="Date Helper"
                                                hspace="5" src="../images/cal_icon.gif" width="22" border="0" name="appDateimg2"
                                                style="vertical-align: bottom; margin-bottom: 2px;" />(DD-MMM-YYYY)</span>
                                    </td>
                                    <td align="right" width="34%">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" Font-Bold="True" OnClick="Button4_Click" />
                                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export to Excel" Font-Bold="True"
                                            OnClick="btnExportToExcel_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <hr />
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <uc1:UserControl_Loading ID="UserControl_Loading1" runat="server" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                         <%--   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>--%>
                                    <div class="GridView whitebg" style="cursor: pointer;">
                                        <div class="grid">
                                            <div class="rounded">
                                                <div class="top-outer">
                                                    <div class="top-inner">
                                                        <div class="top">
                                                            <h2 class="center">
                                                                Items</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mid-outer">
                                                    <div class="mid-inner">
                                                     <table>
                                                            <tr>
                                                            <th style="padding-right: 242px;">
                                                            Drug Name
                                                            </th>
                                                            <th style="padding-right: 28px;">
                                                            Unit
                                                            </th>
                                                            <th style="padding-right: 37px;">
                                                            Opening Stock
                                                            </th>
                                                            <th style="padding-right: 33px;">
                                                            Received Qty
                                                            </th>
                                                            <th style="padding-right: 41px;">
                                                            Interstore Issue
                                                            </th>
                                                            <th style="padding-right: 35px;">
                                                            Quantity Disp
                                                            </th>
                                                            <th style="padding-right: 33px;">
                                                            Adjusted Qty
                                                            </th>
                                                            <th style="padding-right: 30px;">
                                                            Closing Qty
                                                            </th>
                                                            <th>
                                                            Bin Card
                                                            </th>
                                                            </tr>
                                                            </table>
                                                        <div class="mid" style="height: 300px; overflow: auto">
                                                            <div id="div-gridview" class="GridView whitebg">
                                                            
                                                                <asp:GridView ID="grdStockSummary" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                                                                    Width="100%" BorderWidth="0px" CellPadding="0" CssClass="datatable" GridLines="None"
                                                                    OnRowCommand="grdStockSummary_RowCommand" DataKeyNames="ItemId"  ShowHeader="false">
                                                                    <RowStyle CssClass="row" />
                                                                    <HeaderStyle CssClass="FreezeHeader" />
                                                                    <Columns>
                                                                        <asp:BoundField ItemStyle-Width = "26.5%" HeaderText="Drug Name" DataField="ItemName" />
                                                                        <asp:BoundField ItemStyle-Width = "4.5%" HeaderText="Unit" DataField="DispensingUnit" />
                                                                        <asp:BoundField ItemStyle-Width = "11%" HeaderText="Opening Stock" DataField="OpeningStock" />
                                                                        <asp:BoundField ItemStyle-Width = "9%" HeaderText="Received Qty" DataField="QtyRecieved" />
                                                                        <asp:BoundField ItemStyle-Width = "12%" HeaderText="Interstore Issue" DataField="InterStoreIssueQty" />
                                                                        <asp:BoundField ItemStyle-Width = "10%" HeaderText="Quantity Disp" DataField="QtyDispensed" />
                                                                        <asp:BoundField ItemStyle-Width = "10%" HeaderText="Adjusted Qty" DataField="AdjustmentQuantity" />
                                                                        <asp:BoundField ItemStyle-Width = "9%" HeaderText="Closing Qty" DataField="ClosingQty" />
                                                                        <asp:TemplateField ItemStyle-Width = "7%" HeaderText="Bin Card">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/bincard.jpg"
                                                                                    CommandArgument="<%# Container.DataItemIndex %>"></asp:ImageButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
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
                                            </div>
                                        </div>
                                    </div>
                                <%--</ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlStore" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click"></asp:AsyncPostBackTrigger>
                                </Triggers>
                               
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
