<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmBillingFindAddBill.aspx.cs" Inherits="IQCare.Web.Billing.frmBillingFindAddBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <br />
    <div>
        <h2 class="forms" align="left">
            Patient Billing</h2>
        <table cellspacing="6" cellpadding="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td class="form">
                        <table width="100%">
                            <tr>
                                <td colspan="4" align="left">
                                    <label style="padding-left: 10px" id="lblpurpose" runat="server">
                                        Search for:</label>
                                    <asp:RadioButtonList ID="rbtlst_findBill" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                        OnSelectedIndexChanged="rbtlst_findBill_SelectedIndexChanged">
                                        <asp:ListItem id="rbt_openbills" Text="Open Bills" Selected="True"></asp:ListItem>
                                        <asp:ListItem id="rbt_patients" Text="Patient"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <asp:Panel ID="divsearch" runat="server">
                                <tr>
                                    <td colspan="4">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%" align="right">
                                        <label class="" id="Label1" runat="server">
                                            Search Criteria:</label>
                                        <asp:DropDownList ID="ddlSearchCriteria" runat="server" Width="110px" Style="z-index: 2">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 20%" align="left">
                                        <label class="">
                                            Value:</label>
                                        <asp:TextBox ID="txtSearchValue" MaxLength="50" runat="server" Enabled="False"></asp:TextBox>
                                        <asp:Button ID="btnAdd" MaxLength="20" runat="server" Text="Add" OnClick="btnAdd_Click">
                                        </asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <label class="" id="label2" runat="server">
                                            Search Filter</label>
                                        <asp:TextBox ID="txtSearchQuery" runat="server" Enabled="False" Style="width: 99%"
                                            TextMode="MultiLine" Columns="1" Rows="4"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btnSearch" MaxLength="20" runat="server" Text="Search" OnClick="btnSearch_Click">
                                        </asp:Button>
                                        <asp:Button ID="btnClear" MaxLength="20" runat="server" Text="Clear" OnClick="btnClear_Click">
                                        </asp:Button>
                                    </td>
                                </tr>
                            </asp:Panel>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="pad5 formbg border" colspan="2">
                        <div id="divbtnPriorART" class="whitebg" align="center">
                        </div>
                    </td>
                </tr>
                <br />
                <tr>
                    <td class="pad5 formbg border" colspan="2">
                        <div class="grid" id="divBills" style="width: 100%;">
                            <div class="rounded">
                                <div class="mid-outer">
                                    <div class="mid-inner">
                                        <div class="mid" style="height: 200px; overflow: auto">
                                            <div id="div-gridview" class="GridView whitebg">
                                                <asp:GridView ID="grdPatienBill" runat="server" AutoGenerateColumns="False" AllowSorting="true"
                                                    Width="100%" BorderColor="white" PageIndex="1" BorderWidth="1" GridLines="None"
                                                    CssClass="datatable" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="grdPatienBill_SelectedIndexChanged"
                                                    AutoGenerateSelectButton="True" DataKeyNames="PatientID" 
                                                    onrowdatabound="grdPatienBill_RowDataBound">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <RowStyle CssClass="row" />
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Patient ID" DataField="ID" />
                                                        <asp:BoundField HeaderText="Last Name" DataField="LastName" />
                                                        <asp:BoundField HeaderText="First Name" DataField="FirstName" />
                                                        <asp:BoundField HeaderText="DOB" DataField="DOB" DataFormatString="{0:dd-MMM-yyyy}"/>
                                                        <asp:BoundField HeaderText="Bill Date" DataField="BillDate" DataFormatString="{0:dd-MMM-yyyy}"/>
                                                        <asp:BoundField HeaderText="Bill Amount" DataField="BillAmount" DataFormatString="{0:N}"/>
                                                        <asp:BoundField HeaderText="Outstanding Amount" DataField="OutStandingAmount" DataFormatString="{0:N}"/>
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
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
