<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true" CodeBehind="frmPharmacyDispense_FindPatient.aspx.cs" Inherits="PresentationApp.PharmacyDispense.frmPharmacyDispense_FindPatient" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
<script src="../Incl/quicksearch.js" type="text/javascript" defer="defer"></script>
<script type="text/javascript">
    $(function () {
        $('.search_textbox').each(function (i) {
            $(this).quicksearch("[id*=grdPatientPrescriptions] tr:not(:has(th))", {
                'testQuery': function (query, txt, row) {
                    return $(row).children(":eq(" + i + ")").text().toLowerCase().indexOf(query[0].toLowerCase()) != -1;
                }
            });
        });
    });

    function fnGoToURL(url) {
        //var result = frmFindAddPatient.SetPatientIdFamily_Session(url).value;
        window.location.href = url;
    }
</script>
    <br />
    <div>
        <h2 class="forms" align="left">
            Patient Prescriptions</h2>
        <table cellspacing="6" cellpadding="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td class="form">
                        <table width="100%">
                            <tr>
                                <td align="left">
                                    <label style="padding-left: 10px" id="lblpurpose" runat="server">
                                        Search for:</label>
                                    <asp:RadioButtonList ID="rbtlst_findPrescription" runat="server" 
                                        AutoPostBack="True" RepeatDirection="Horizontal"
                                        OnSelectedIndexChanged="rbtlst_findBill_SelectedIndexChanged">
                                        <asp:ListItem id="rbt_prescriptions" Text="Prescriptions" Selected="True"></asp:ListItem>
                                        <asp:ListItem id="rbt_patients" Text="Patient"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                
                <tr>
                    <td class="pad5 formbg border" colspan="2">
                        <div class="grid" id="divBills" style="width: 100%;">
                            <div class="rounded">
                                <div class="mid-outer">
                                    <div class="mid-inner">
                                        <div class="mid" style="height: 200px; overflow: auto">
                                            <div id="div-gridview" class="GridView whitebg">
                                                <asp:GridView ID="grdPatientPrescriptions" runat="server" 
                                                    AutoGenerateColumns="False" AllowSorting="true"
                                                    Width="100%" BorderColor="white" PageIndex="1" BorderWidth="1" GridLines="None"
                                                    CssClass="datatable" CellPadding="0" CellSpacing="0" 
                                                    OnSelectedIndexChanged="grdPatientPrescriptions_SelectedIndexChanged" DataKeyNames="Ptn_pk, VisitID" 
                                                    onrowdatabound="grdPatientPrescriptions_RowDataBound" 
                                                    ondatabound="grdPatientPrescriptions_DataBound">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <RowStyle CssClass="row" />
                                                    <Columns>
                                                        <asp:BoundField HeaderText="PtnPK" DataField="Ptn_pk" Visible="False" />
                                                        <asp:BoundField HeaderText="Patient ID" DataField="PatientID" HeaderStyle-Width="120px"/>
                                                        <asp:BoundField HeaderText="Last Name" DataField="lname" HeaderStyle-Width="150px"/>
                                                        <asp:BoundField HeaderText="First Name" DataField="fname" HeaderStyle-Width="150px"/>
                                                        <asp:BoundField HeaderText="Age" DataField="Age" HeaderStyle-Width="80px"/>
                                                        <asp:BoundField HeaderText="Time Ordered" DataField="OrderedByDate" HeaderStyle-Width="100px"/>
                                                        <asp:BoundField HeaderText="Status" DataField="Status" HeaderStyle-Width="200px" />
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
