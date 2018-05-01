<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmBilling_PayBill.aspx.cs" Inherits="IQCare.Web.Billing.frmBilling_PayBill" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <style type="text/css" >
       
    </style>
    <script language="javascript" type="text/jscript">
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function openReportPage(path) {
            window.location.href = './frmBilling_ClientBill.aspx';
            window.open(path, 'popupwindow', 'toolbars=no,location=no,directories=no,dependent=yes,top=10,left=30,maximize=yes,resizable=no,width=950,height=650,scrollbars=yes');
        }
      
        function calculateSum() {
            var totalPrice = 0.0;
            var grdPayItems = document.getElementById('<%=grdPayItems.ClientID%>');
            for (i = 1; i < grdPayItems.rows.length - 1; i++) {
                if (grdPayItems.rows[i].cells[0].getElementsByTagName("input")[0].checked) {
                    totalPrice += parseFloat(grdPayItems.rows[i].cells[4].getElementsByTagName("span")[0].innerText.replace(/,/g, ''));
                }

            }
            $('#<%=lblTotal.ClientID%>').text("" + totalPrice.toFixed(2));

        }

        function CheckAll(Checkbox) {
            var grdPayItems = document.getElementById('<%=grdPayItems.ClientID%>');
            for (i = 1; i < grdPayItems.rows.length - 1; i++) {
                if (!(grdPayItems.rows[i].cells[0].getElementsByTagName("input")[0]).disabled) {
                    grdPayItems.rows[i].cells[0].getElementsByTagName("input")[0].checked = Checkbox.checked;
                    if (Checkbox.checked)
                 {
                 grdPayItems.rows[i].style.backgroundColor = "#EBEBEB";
                 }
                 else
                 {
                  grdPayItems.rows[i].style.backgroundColor = "white";
                 }
                }

            }

            calculateSum();
        }

        function OnChecked() {
            var grdPayItems = document.getElementById('<%=grdPayItems.ClientID%>');
            for (i = 1; i < grdPayItems.rows.length - 1; i++) {
                if (grdPayItems.rows[i].cells[0].getElementsByTagName("input")[0].checked) {
                    grdPayItems.rows[i].style.backgroundColor = "#EBEBEB";
                } else {
                    grdPayItems.rows[i].style.backgroundColor = "white";
                    grdPayItems.rows[0].cells[0].getElementsByTagName("input")[0].checked = false;

                }

            }
            calculateSum();

        }
    
    </script>   
    <div>
        <div style="padding-top: 18px;">
        </div>
        <table cellspacing="6" cellpadding="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td class="pad5 formbg border">
                        <div class="grid" style="width: 100%;">
                            <div class="rounded">
                                <div class="mid-outer">
                                    <div class="mid-inner">
                                        <div class="mid">
                                            <label>
                                                Patient Name:
                                                <asp:Label ID="lblname" runat="server"></asp:Label>
                                                <asp:HiddenField runat="server" ID="HLocationID" />
                                            </label>
                                            &nbsp;&nbsp;
                                            <label>
                                                Sex:
                                                <asp:Label ID="lblsex" runat="server"></asp:Label>
                                            </label>
                                            &nbsp;&nbsp;
                                            <label>
                                                DOB:
                                                <asp:Label ID="lbldob" runat="server"></asp:Label>
                                            </label>
                                            <label>
                                                Facility ID:
                                                <asp:Label ID="lblFacilityID" runat="server"></asp:Label>
                                            </label>
                                            &nbsp;&nbsp;
                                            <label>
                                                IQCare Reference Number:
                                                <asp:Label ID="lblIQno" runat="server"></asp:Label>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <h2 class="forms" align="left">
            Pay Bill</h2>
        <asp:UpdatePanel runat="server" ID="upBill" UpdateMode="Conditional">
            <ContentTemplate>
                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                    <tbody>
                        <asp:Panel ID="divError" runat="server" Style="padding: 5px" CssClass="background-color: #FFFFC0; border: solid 1px #C00000"
                            HorizontalAlign="Left" Visible="false">
                            <asp:Label ID="lblError" runat="server" Style="font-weight: bold; color: #800000"
                                Text=""></asp:Label>
                        </asp:Panel>
                        <tr>
                            <td>
                                <div>
                                    <h2 class="forms" align="left">
                                        Bill Number:
                                        <asp:Label ID="labelBillNumber" runat="server" Font-Bold="true" ForeColor="Black"></asp:Label></h2>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                    <tbody>
                        <tr>
                            <td class="form" style="width: 60%" valign="top">
                                <asp:HiddenField ID="HDBillAmount" runat="server" />
                                <asp:HiddenField ID="HDAmountDue" runat="server" />
                                <asp:HiddenField ID="HPayMode" runat="server" />
                                <asp:HiddenField ID="HDBillNumber" runat="server" />
                                <asp:HiddenField ID="HTran" runat="server" />
                                <asp:HiddenField ID="HDisplay" runat="server" Value="ITEMS" />
                                <div id="div-payItems" class="GridView whitebg">
                                    <asp:GridView ID="grdPayItems" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                        BorderColor="White" BorderWidth="1px" CellPadding="0" CssClass="datatable" GridLines="None"
                                        ShowHeaderWhenEmpty="True" Width="100%" DataKeyNames="billitemid,patientid,billitemdate,amount,ItemId"
                                        CellSpacing="2" ShowFooter="True" OnRowDataBound="grdPayItems_RowDataBound" OnPreRender="grdPayItems_PreRender">
                                        <Columns>
                                            <asp:TemplateField Visible="True">
                                                <HeaderTemplate>
                                                    <span style="display: <% = AllowSelect %>; white-space: nowrap">
                                                        <asp:CheckBox ID="chkBxHeader" runat="server" AutoPostBack="False" 
                                                         onclick="CheckAll(this);" />
                                                    </span>
                                                </HeaderTemplate>
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30px" Wrap="False" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30px" Wrap="False" />
                                                <ItemTemplate>
                                                    <span style='display: <% = AllowSelect %>; white-space: nowrap'>
                                                        <asp:CheckBox ID="chkBxItem" runat="server" AutoPostBack="False"   onclick="OnChecked();"
                                                        oncheckedchanged="chkBxItem_CheckedChanged"></asp:CheckBox></span>                                                        
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Description" DataField="ItemName" ItemStyle-Width="60%"
                                                HeaderStyle-HorizontalAlign="left">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle Width="60%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Quantity" DataField="Quantity" ItemStyle-Width="8%" HeaderStyle-HorizontalAlign="Center">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="false"></HeaderStyle>
                                                <ItemStyle Width="8%" HorizontalAlign="Center"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Price" DataField="SellingPrice" DataFormatString="{0:N}"
                                                ItemStyle-Width="8%" HeaderStyle-HorizontalAlign="Center">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="false"></HeaderStyle>
                                                <ItemStyle Width="8%" HorizontalAlign="Center"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:TemplateField FooterText="Total:" HeaderText="Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="labelItemCost" runat="server" Text='<%# Bind("Amount", "{0:N}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterStyle Font-Bold="True" HorizontalAlign="Right" Wrap="false" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right" Width="20%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <RowStyle CssClass="row" />
                                    </asp:GridView>
                                </div>
                            </td>
                            <td class="form" valign="top">
                                <asp:Panel ID="panelSummarry" runat="server" Style="display: block">
                                    <table width="100%">
                                        <tr>
                                            <td colspan="2">
                                                <div id="divBillAmount" style="text-align: left; white-space: nowrap; vertical-align: baseline">
                                                    <asp:Label ID="labelAmountDueCaption" runat="server" Height="30px" Style="white-space: nowrap;
                                                        vertical-align: middle; font-weight: bold">Total Amount Due:</asp:Label>
                                                    <asp:Label ID="labelAmountDue" runat="server" Height="30px" Style="white-space: nowrap;
                                                        vertical-align: middle; font-weight: bold"></asp:Label>&nbsp;&nbsp;&nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="display: <% = AllowSelect %>">
                                            <td colspan="2">
                                                <p id="total" style="text-align: left; white-space: nowrap; vertical-align: baseline">
                                                    <asp:Label ID="lblTotalCaption" runat="server" Height="30px" Style="white-space: nowrap;
                                                        vertical-align: middle; font-weight: bold">Total Amount (selected):</asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Height="30px" Style="white-space: nowrap;
                                                        vertical-align: middle; font-weight: bold"></asp:Label>&nbsp;&nbsp;&nbsp;
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="padding-left: 10px; font-weight: bold">
                                                Payment Mode:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPaymentMode" runat="server" Width="180px" ViewStateMode="Enabled">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="buttonProceed" runat="server" Text="Proceed to pay" Height="30px"
                                                    Style="white-space: nowrap; vertical-align: baseline" Font-Bold="True" ForeColor="InfoText"
                                                    OnClick="buttonProceed_Click" Enabled="True" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="panelPayment" runat="server" Style="display: block">
                                    <asp:PlaceHolder ID="phPayMethod" runat="server"></asp:PlaceHolder>
                                </asp:Panel>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="buttonProceed" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <table cellspacing="6" cellpadding="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td class="form pad5 center">
                        <h2 class="forms" align="left">
                            Bill Payment Transactions</h2>
                    </td>
                </tr>
                <tr>
                    <td class="pad5 formbg border">
                        <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div id="paidBills" class="grid" style="width: 100%;">
                                    <div class="rounded">
                                        <div class="mid-outer">
                                            <div class="mid-inner">
                                                <div class="mid" style="height: 180px; overflow: auto">
                                                    <div id="div-receiptgridview" class="GridView whitebg">
                                                        <asp:GridView ID="gridBillTransaction" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            BorderColor="White" BorderWidth="1px" CellPadding="0" CssClass="datatable" DataKeyNames="BillID,TransactionID,PatientID"
                                                            Enabled="true" EnableModelValidation="True" GridLines="None" HorizontalAlign="Left"
                                                            ShowFooter="True" ShowHeaderWhenEmpty="True" Width="100%" OnRowCommand="gridBillTransaction_RowCommand"
                                                            OnRowDataBound="gridBillTransaction_RowDataBound">
                                                            <Columns>
                                                                <asp:BoundField DataField="ReceiptNumber" HeaderText="Reference #" />
                                                                <asp:BoundField DataField="TransactionDate" DataFormatString="{0:dd-MMM-yyyy hh:mm:ss}"
                                                                    HeaderText="Transaction Date" />
                                                                <asp:BoundField DataField="TotalAmount" HeaderText="Amount" />
                                                                <asp:BoundField DataField="TransactionTypeName" HeaderText="Transaction Type" />
                                                                <asp:TemplateField HeaderText="Transaction Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="labelTransactionStatus" runat="server" Text='<%# Bind("TransactionStatus") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="CreatedBy" HeaderText="Transacted By" />
                                                                <asp:TemplateField InsertVisible="False" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <div style='text-align: center; padding: 10px; white-space: nowrap; display: <%# IsReversible(Eval("TransactionStatus"),Eval("Reversible")) %>'>
                                                                            <asp:Button ID="buttonReverse" runat="server" CausesValidation="false" CommandName="Reverse"
                                                                                Text="Reverse" CommandArgument="<%# Container.DataItemIndex %>" ForeColor="Black">
                                                                            </asp:Button>
                                                                            <asp:Button ID="receiptPrint" runat="server" CausesValidation="false" CommandName="PrintReceipt"
                                                                                Text="Print Receipt" CommandArgument="<%# Container.DataItemIndex %>" ForeColor="Black">
                                                                            </asp:Button>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle ForeColor="#3399FF" HorizontalAlign="Left" />
                                                            <RowStyle CssClass="row" />
                                                        </asp:GridView>
                                                    </div>
                                                    <asp:Button ID="btnRaiseReversal" runat="server" Style="display: none" />
                                                    <ajaxToolkit:ModalPopupExtender ID="mpeReverse" runat="server" PopupControlID="panelReversalPopup"
                                                        TargetControlID="btnRaiseReversal" CancelControlID="buttonCancelReversal" BackgroundCssClass="modalBackground">
                                                    </ajaxToolkit:ModalPopupExtender>
                                                    <asp:Panel ID="panelReversalPopup" runat="server" Style="display: none; background-color: #FFFFFF;
                                                        width: 300px; border: 3px solid #479ADA;">
                                                        <div style="background-color: #479ADA; height: 30px; color: Black; line-height: 30px;
                                                            text-align: center; font-weight: bold;">
                                                            Request For Reversal
                                                            <asp:Label ID="labelReceipt" runat="server" /></div>
                                                        <div style="min-height: 50px; line-height: 30px; text-align: center; font-weight: bold;">
                                                            Reason for reversal?<br />
                                                            <asp:TextBox runat="server" ID="textReason" Width="286px" TextMode="MultiLine" /><asp:HiddenField
                                                                ID="HTransactionID" runat="server" />
                                                        </div>
                                                        <div style="padding: 3px;" align="right">
                                                            <asp:Button ID="buttonRequestReversal" runat="server" Text="Send Request" ForeColor="Black"
                                                                OnClick="RequestReversal" />
                                                            <asp:Button ID="buttonCancelReversal" runat="server" Text="Cancel" ForeColor="Black" />
                                                        </div>
                                                    </asp:Panel>
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
                            </ContentTemplate>
                            <Triggers>
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td class="form pad5 center">
                        <br />
                        <asp:Button ID="buttonClose" runat="server" OnClick="btn_close_Click" Text="Close" />
                    </td>
                </tr>
            </tbody>
        </table>
        <asp:UpdatePanel ID="notificationPanel" runat="server">
            <ContentTemplate>
                <asp:Button ID="btn" runat="server" Style="display: none" />
                <asp:Panel ID="pnNotify" runat="server" Style="display: none; width: 460px; border: solid 1px #808080;
                    background-color: #E0E0E0; z-index: 15000">
                    <asp:Panel ID="pnPopup_Title" runat="server" Style="border: solid 1px #808080; margin: 0px 0px 0px 0px;
                        cursor: move; height: 18px">
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 18px">
                            <tr style="background-color: #479ADA;">
                                <td style="width: 5px; height: 19px;">
                                </td>
                                <td style="width: 100%; height: 19px;">
                                    <span style="font-weight: bold; color: Black">
                                        <asp:Label ID="lblNotice" runat="server">Pay Bill</asp:Label></span>
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
                        <asp:Button ID="btnOkAction" runat="server" Text="OK" Width="80px" Style="border: solid 1px #808080;"
                            OnClick="btnOkAction_Click" /></div>
                </asp:Panel>
                <ajaxToolkit:ModalPopupExtender ID="notifyPopupExtender" runat="server" TargetControlID="btn"
                    PopupControlID="pnNotify" BackgroundCssClass="modalBackground" DropShadow="True"
                    PopupDragHandleControlID="pnPopup_Title" Enabled="True" DynamicServicePath="">
                </ajaxToolkit:ModalPopupExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
