<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmPharmacy_StockManagement.aspx.cs" Inherits="PresentationApp.PharmacyDispense.frmPharmacy_StockManagement" %>

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<%@ Register Src="../ClinicalForms/UserControl/UserControl_Loading.ascx" TagName="UserControl_Loading"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <%--<asp:ScriptManager ID="scriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
    </asp:ScriptManager>--%>
    <script type="text/javascript">
        $(function () {
            $(".datePicker").datepicker({
                dateFormat: "dd-M-yy",
                changeMonth: true,
                changeYear: true,
                yearRange: '1900:2090'
            });

            //$("[id$=txtExpiryDate]").datepicker();
        });


        function ace1_itemSelected(source, e) {
            var index = source._selectIndex;
            if (index != -1) {
                var hdCustID = $get('<%= hdCustID.ClientID %>');
                hdCustID.value = e.get_value();
            }
        }

        function showHideTransactionType(controlID) {
            if (document.getElementById(controlID)[document.getElementById(controlID).selectedIndex].text == "Receive") {
                tblDestinationStore.style.display = "block";
                tblSourceStore.style.display = "block";
                lblSourceStore.innerHTML = "Source Store";
            }
            else if (document.getElementById(controlID)[document.getElementById(controlID).selectedIndex].text == "Opening Stock") {
                tblDestinationStore.style.display = "none";
                tblSourceStore.style.display = "block";
                lblSourceStore.innerHTML = "Store";
            }
            else if (document.getElementById(controlID)[document.getElementById(controlID).selectedIndex].text == "Adjustment") {
                tblDestinationStore.style.display = "none";
                tblSourceStore.style.display = "block";
                lblSourceStore.innerHTML = "Store";
            }
        }

        function DuplicateBatchNo(text, batches, controlID) {
            BatchesArray = batches.split(',');
            if (text != "") {
                if (BatchesArray.indexOf(text.toLowerCase()) > -1) {
                    alert('Batch Number exists.');
                    document.getElementById(controlID).value = "";
                    //this.value = "";
                }
            }
        }
        
    </script>
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
        
        .hide
        {
            display: none;
        }
        
        div.ajax__calendar_container, div.ajax__calendar_body
        {
            width: 225px;
        }
        
        .ajax__calendar_days td
        {
            padding: 2px 4px;
        }
    </style>
    <asp:HiddenField ID="hdCustID" runat="server" />
    <table cellspacing="6" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <table style="width: 100%">
                    <tr valign="top">
                        <td class="data-control">
                            <table style="width: 100%">
                                <tr>
                                    <td width="33%">
                                        <asp:Label ID="Label7" runat="server" Font-Bold="True" CssClass="required" Text="Transaction Type:"></asp:Label>
                                        &nbsp;<asp:DropDownList ID="ddlTransactionType"  runat="server" Width="150px" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlTransactionType_SelectedIndexChanged">
                                            <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Receive"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Opening Stock"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Adjustment"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:RequiredFieldValidator ID="TransactionTypeRequiredValidator" runat="server"
                                            ErrorMessage="Required" Display="Dynamic" ControlToValidate="ddlTransactionType"
                                            InitialValue="0"></asp:RequiredFieldValidator>--%>
                                    </td>
                                    <td width="33%">
                                        <asp:Label ID="Label9" runat="server" CssClass="required" Font-Bold="True" Text="Transaction Date:"></asp:Label>
                                        <asp:TextBox ID="txtTransactionDate" runat="server" Width="125px"></asp:TextBox>
                                        <img id="Img2" onclick="w_displayDatePicker('<%=txtTransactionDate.ClientID%>');"
                                            alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22" border="0"
                                            name="appDateimg1" style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel"
                                                id="Span2">(DD-MMM-YYYY)</span>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required"
                                            Display="Dynamic" ControlToValidate="txtTransactionDate"></asp:RequiredFieldValidator>--%>
                                    </td>
                                    <td width="34%">
                                        <asp:Label ID="Label21" runat="server" Font-Bold="True" Text="Order No:"></asp:Label>
                                        &nbsp;<asp:TextBox ID="txtOrderNumber" runat="server" Width="125px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table width="100%">
                                <tr>
                                    <td width="33%">
                                        <div id="tblSourceStore">
                                            <%--<asp:Label ID="Label1" runat="server" Font-Bold="True" 
                            Text="Source Store:"></asp:Label>--%>
                                            <label id="lblSourceStore" CssClass="required">
                                                Source Store</label>
                                            &nbsp;<asp:DropDownList ID="ddlSourceStore" runat="server" OnSelectedIndexChanged="ddlSourceStore_SelectedIndexChanged"
                                                AutoPostBack="true">
                                            </asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="sourceStoreRequiredValidator" runat="server" ErrorMessage="Required"
                                                Display="Dynamic" ControlToValidate="ddlSourceStore" InitialValue="0"></asp:RequiredFieldValidator>--%>
                                        </div>
                                    </td>
                                    <td>
                                        <div id="tblDestinationStore">
                                            <asp:Label ID="Label22" runat="server" Font-Bold="True" Text="Destination Store:" CssClass="required"></asp:Label>
                                            &nbsp;<asp:DropDownList ID="ddlDestinationStore" runat="server" Width="150px">
                                            </asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="destinationStoreRequiredValidator" runat="server"
                                                ErrorMessage="Required" Display="Dynamic" ControlToValidate="ddlDestinationStore"
                                                InitialValue="0"></asp:RequiredFieldValidator>--%>
                                        </div>
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
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
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
                                                        <div>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="width: 80px">
                                                                        &nbsp;<asp:Label ID="Label30" runat="server" Text="DrugName:" Font-Bold="True"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDrug" runat="server" Width="850px" AutoPostBack="True" OnTextChanged="txtDrug_TextChanged"
                                                                            Enabled="False"></asp:TextBox>
                                                                        <div id="divwidth">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <act:AutoCompleteExtender ServiceMethod="SearchDrugs" MinimumPrefixLength="2" CompletionInterval="30"
                                                                EnableCaching="false" CompletionSetCount="10" TargetControlID="txtDrug" OnClientItemSelected="ace1_itemSelected"
                                                                ID="AutoCompleteExtender1" runat="server" FirstRowSelected="false" CompletionListElementID="divwidth">
                                                            </act:AutoCompleteExtender>
                                                            <hr />
                                                        </div>
                                                        <div class="mid" style="height: 300px; overflow: auto">
                                                            <div id="div-gridview" class="GridView whitebg">
                                                                <asp:GridView ID="grdStockMngt" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                                                                    Width="100%" BorderWidth="0px" CellPadding="0" CssClass="datatable" GridLines="None"
                                                                    DataKeyNames="Drug_Pk" OnRowDataBound="grdStockMngt_RowDataBound" OnRowDeleting="grdStockMngt_RowDeleting">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Drug Name" HeaderStyle-Width="500px">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Unit" HeaderStyle-Width="90px">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblUnit" runat="server" Text='<%# Bind("Unit") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Batch No" HeaderStyle-Width="90px">
                                                                            <ItemTemplate>
                                                                                <span style="display: <%# ShowLabel() %>">
                                                                                    <asp:Label ID="lblBatchNo" runat="server" Text='<%# Bind("BatchNo") %>'></asp:Label></span>
                                                                                <span style="display: <%# ShowTextBox() %>">
                                                                                    <asp:TextBox ID="txtBatchNo" runat="server" Text='<%# Bind("BatchNo") %>'></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="BatchNoRequiredFieldValidator" runat="server" ErrorMessage="Required"
                                                                                        Display="Dynamic" ControlToValidate="txtBatchNo" Enabled="false"></asp:RequiredFieldValidator>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Expiry Date" HeaderStyle-Width="90px">
                                                                            <ItemTemplate>
                                                                                <span style="display: <%# ShowLabel() %>">
                                                                                    <asp:Label ID="lblExpiryDate" runat="server" Text='<%# Bind("ExpiryDate") %>'></asp:Label></span>
                                                                                <span style="display: <%# ShowTextBox() %>">
                                                                                    <asp:TextBox ID="txtExpiryDate" runat="server" Text='<%# Bind("ExpiryDate") %>' onkeyup="DateFormat(this,this.value,event,false,3);"></asp:TextBox>
                                                                                    <act:CalendarExtender ID="cal3" runat="server" TargetControlID="txtExpiryDate" Format="dd-MMM-yyyy">
                                                                                    </act:CalendarExtender>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Avail Qty" HeaderStyle-Width="90px">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblAvailQty" runat="server" Text='<%# Bind("AvailQty") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Quantity" ControlStyle-Width="90px">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("Quantity") %>' onkeypress='return (event.charCode >= 48 && event.charCode <= 57) || event.charCode == 46 || event.charCode == 45'></asp:TextBox>
                                                                                <asp:RangeValidator ID="qtyRangeValidator" runat="server" ErrorMessage="Error" MinimumValue="1"
                                                                                    MaximumValue="500000000" Enabled="false" ControlToValidate="txtQuantity" Type="Double"
                                                                                    Display="Dynamic"></asp:RangeValidator>
                                                                                <asp:RequiredFieldValidator ID="qtyRequiredValidator" runat="server" ErrorMessage="Required"
                                                                                    ControlToValidate="txtQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Comments" ControlStyle-Width="250px">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtComments" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Images/del.gif" ShowDeleteButton="true" />
                                                                        <asp:TemplateField HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblBatchID" runat="server" Text='<%# Bind("BatchID") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblPurchaseUnitPrice" runat="server" Text='<%# Bind("PurchaseUnitPrice") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblQtyPerPurchaseUnit" runat="server" Text='<%# Bind("QtyPerPurchaseUnit") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <RowStyle CssClass="row" />
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
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlSourceStore" EventName="SelectedIndexChanged" />
                                    <%--<asp:PostBackTrigger ControlID="txtDrug" />--%>
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
