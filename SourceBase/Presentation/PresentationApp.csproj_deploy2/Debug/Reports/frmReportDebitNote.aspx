<%@ Page Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    Inherits="frmReportDebitNote" Title="Untitled Page" CodeBehind="frmReportDebitNote.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<%@ MasterType VirtualPath="~/MasterPage/IQCare.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="Server">
    <head>
        <%--  <link type="text/css" href="../Style/_assets/css/grid.css" rel="stylesheet" />--%>
        <%-- <link rel="stylesheet" type="text/css" href="../Style/StyleSheet.css" />--%>
        <%--   <link type="text/css" href="../Style/_assets/css/round.css" rel="stylesheet" />--%>
        <script type="text/javascript" language="javascript">
            function fnOpenWin(url) {
                //var result=frmFindAddPatient.SetPatientId_Session(url).value;
                //alert(url);
                window.open(url, 'ab', 'toolbars=no,location=no,directories=no,dependent=yes,top=10,left=30,scrollbars=yes');

            }
        </script>
    </head>
    <%--    <link type="text/css" href="Style/_assets/css/grid.css" rel="stylesheet" />--%>
    <div style="padding-left: 8px; padding-right: 8px;">
        <%-- <form id="DebitNote" method="post" runat="server">--%>
        <h1 class="nomargin">
            Debit Note</h1>
        <div id="divshow" class="border center formbg">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="border pad5 whitebg">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%">
                            <tr>
                                <td valign="top" align="left" style="width: 100%; height: 100%">
                                    <table width="100%" border="0" style="height: 100%; border: #666699 1px solid; left: 0px;
                                        background-color: #ffffff">
                                        <tr style="height: 100%">
                                            <td>
                                                <table width="100%">
                                                    <tr>
                                                        <td colspan="5">
                                                            <asp:Label ID="LabelRange" runat="server" Text="No Open Transaction"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>
                                                                From:</label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="TxtFromDate" MaxLength="11" Width="75px" runat="server"></asp:TextBox>
                                                            <img src="../Images/cal_icon.gif" height="22" alt="Date Helper" border="0" onclick="w_displayDatePicker('<%= TxtFromDate.ClientID%>');"
                                                                style="vertical-align: bottom; margin-bottom: 2px;" />
                                                            <span class="smallerlabel">(DD-MMM-YYYY)</span>
                                                        </td>
                                                        <td>
                                                            <label>
                                                                To:</label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="TxtToDate" MaxLength="11" Width="75px" runat="server" EnableViewState="true"></asp:TextBox>
                                                            <img id="img2" src="../Images/cal_icon.gif" height="22" alt="Date Helper" border="0"
                                                                onclick="w_displayDatePicker('<%= TxtToDate.ClientID%>');" style="vertical-align: bottom;
                                                                margin-bottom: 2px;" />
                                                            <span class="smallerlabel">(DD-MMM-YYYY)</span>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="ButtonShow" runat="server" Text="Show transactions for date range"
                                                                OnClick="ButtonShow_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5">
                                                            <div class="grid">
                                                                <div class="mid" style="cursor: pointer; height: 280px; overflow: auto; border: 1px solid #666699;">
                                                                    <div id="div-gridview" class="gridView whitebg">
                                                                        <asp:GridView ID="GridViewTran" runat="server" AutoGenerateColumns="False" CssClass="datatable"
                                                                            GridLines="None" AllowSorting="True">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="TransactionDateFmt" HeaderText="Transaction Date" ReadOnly="True" />
                                                                                <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True" />
                                                                                <asp:BoundField DataField="Cost" HeaderText="Cost" ReadOnly="True" />
                                                                                <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" />
                                                                            </Columns>
                                                                            <RowStyle CssClass="row" />
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div class="border center formbg">
                <table width="100%">
                    <tr>
                        <td class="alert" style="background:none">
                            **Warning: By submitting this report you will be creating a bill for the transactions shown above.
                        </td>
                    </tr>
                    <tr style="margin-top:1%;">
                        <td align="center">
                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                            <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
