<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmClinical_Nigeria_ARTCareSummary.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_Nigeria_ARTCareSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script language="javascript" type="text/javascript">
        function WindowPrint() {
            window.print();
        }
        function GetControl() {
            document.forms[0].submit();
        }
    </script>
    <div style="padding-left: 8px; padding-right: 8px;">
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                Cohort</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label>
                                Cohort Month:</label>
                            <input id="txtcohortmnth" size="10" name="CohortMonth" runat="server" readonly="readonly" />
                        </td>
                        <td class="form   center">
                            <label>
                                Cohort Year:</label>
                            <input id="txtcohortyear" size="10" name="CohortYear" runat="server" readonly="readonly" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                ART Start at Another Facility(Status at Start of ART)</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label class="right10" id="lblotherregimen" runat="server">
                                First ART Regimen:</label>
                            <input id="txtotherregimen" size="16" name="otherregimen" readonly="readonly" runat="server" />
                            <asp:Button ID="btnotherRegimen" runat="server" Text="..." OnClick="btnTransRegimen_Click" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label id="lblrARTdate" runat="server">
                                Date ART Started:</label>
                            <input id="txtotherRegimendate" runat="server" maxlength="11" size="10" name="txtotherRegimendate" />
                            <img id="imgdate" onclick="w_displayDatePicker('<%=txtotherRegimendate.ClientID%>');"
                                height="22" alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22"
                                border="0" style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel">(DD-MMM-YYYY)</span>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right10">
                                Clinical Stage:</label>
                            <asp:DropDownList ID="ddlotherFacilityClinicalStage" runat="server" Style="width: 100px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label id="lblotherweight" runat="server">
                                Weight :
                            </label>
                            <input id="txtotherwght" size="6" maxlength="3" name="otherwght" runat="server" />
                            <label>
                                Kgs</label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15" id="lblotherHeight" runat="server">
                                Height :</label>
                            <input id="txtotherheight" size="6" maxlength="3" name="otherheight" runat="server" />
                            <label>
                                cm</label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                Function :</label>
                            <asp:DropDownList ID="ddlotherFunction" runat="server" Style="width: 100px">
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15" id="lblotherCD4" runat="server">
                                CD4 :</label>
                            <input id="txtotherCD4" size="6" name="otherCD4" runat="server" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15" id="lblotherCD4Percent" runat="server">
                                CD4 Percent :</label>
                            <input id="txtotherCD4Percent" size="6" name="othercd4percent" runat="server" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                ART Start at This Facility(Status of Start of ART)</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label class="right10">
                                First ART Regimen:</label>
                            <input id="txtthisregimen" size="16" name="thisregimen" readonly="readonly" runat="server" />
                            <asp:Button ID="btnthisRegimen" runat="server" Text="..." Enabled="False" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label id="lblthisregi">
                                Date ART Started:</label>
                            <input id="txtthisRegimendate" runat="server" maxlength="11" size="10" name="txtthisRegimendate"
                                readonly="readonly" />
                            <img id="img1" height="22" alt="Date Helper" hspace="3" src="../images/cal_icon.gif"
                                width="22" border="0" style="vertical-align: bottom; margin-bottom: 2px;" /><span
                                    class="smallerlabel">(DD-MMM-YYYY)</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right10">
                                Clinical Stage:</label>
                            <asp:DropDownList ID="ddlthisfacilityClinicalStage" runat="server" Style="width: 100px"
                                Enabled="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label>
                                Weight :</label>
                            <input id="txtthiswght" size="6" name="thisweight" runat="server" readonly="readonly" />
                            Kgs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15" id="lblthisheight" runat="server">
                                Height :</label>
                            <input id="txtthisheight" size="6" name="thisheight" runat="server" readonly="readonly" />
                            cm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                Function:</label>
                            <asp:DropDownList ID="ddlthisFunction" runat="server" Style="width: 100px" Enabled="false">
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15" id="lblthisCD4" runat="server">
                                CD4 :</label>
                            <input id="txtthisCD4" size="6" name="thiscd4" runat="server" readonly="readonly" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15" id="lblthisCD4Percent" runat="server">
                                CD4 Percent :</label>
                            <input id="txtthisCDPercent" size="6" name="thiscd4percent" runat="server" readonly="readonly" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
        </div>
        <br />
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="pad5 formbg border">
                            <div class="grid">
                                <div class="rounded">
                                    <div class="top-outer">
                                        <div class="top-inner">
                                            <div class="top">
                                                <h2>
                                                    <center>
                                                        Substitutions and Switches
                                                    </center>
                                                </h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mid-outer">
                                        <div class="mid-inner">
                                            <div class="mid" style="height: 200px; overflow: auto">
                                                <div id="div-gridview" class="gridviewbackup whitebg">
                                                    <asp:GridView ID="grdSubsARVs" runat="server" AutoGenerateColumns="False" AllowSorting="true"
                                                        Width="100%" BorderColor="white" PageIndex="1" BorderWidth="0" GridLines="None"
                                                        CssClass="datatable" CellPadding="0" CellSpacing="0">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <RowStyle CssClass="row" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Date" DataField="ChangeDate" />
                                                            <asp:BoundField HeaderText="Regimen" DataField="regimentype" />
                                                            <asp:BoundField HeaderText="Line" DataField="RegimenLine" />
                                                            <asp:BoundField HeaderText="Why" DataField="ChangeReason" />
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
        <br />
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="pad5 formbg border">
                            <div class="grid">
                                <div class="rounded">
                                    <div class="top-outer">
                                        <div class="top-inner">
                                            <div class="top">
                                                <h2>
                                                    <center>
                                                        ART Treatment Interruptions</center>
                                                </h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mid-outer">
                                        <div class="mid-inner">
                                            <div class="mid" style="height: 200px; overflow: auto">
                                                <div id="div-gridview2" class="gridviewbackup whitebg">
                                                    <asp:GridView ID="grdInteruptions" runat="server" AutoGenerateColumns="False" AllowSorting="true"
                                                        Width="100%" BorderColor="white" PageIndex="1" BorderWidth="0" GridLines="None"
                                                        Height="20px" CssClass="datatable" CellPadding="0" CellSpacing="0">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <RowStyle CssClass="row" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Stop/Lost" DataField="StopLost" />
                                                            <asp:BoundField HeaderText="Date" DataField="ARTEndDate" />
                                                            <asp:BoundField HeaderText="Why" DataField="Reason" />
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
                    <tr>
                        <td class="form pad5 center" colspan="2">
                            <br />
                            <asp:Button ID="btn_save" Text="Save" runat="server" OnClick="btn_save_Click" />
                            <asp:Button ID="DQ_Check" Text="Data Quality check" runat="server" OnClick="DQ_Check_Click" />
                            <asp:Button ID="btn_close" Text="Close" runat="server" OnClick="btn_close_Click" />
                            <asp:Button ID="btn_print" Text="Print" runat="server" OnClientClick="WindowPrint()" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
