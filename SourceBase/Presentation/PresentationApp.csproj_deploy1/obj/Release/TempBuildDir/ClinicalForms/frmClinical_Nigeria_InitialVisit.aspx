<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmClinical_Nigeria_InitialVisit.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_Nigeria_InitialVisit" %>

<%@ Register TagPrefix="UcDrugAllergies" TagName="Uc6" Src="~/ClinicalForms/UserControl/UserControlKNH_DrugAllergies.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <div style="padding-left: 8px; padding-right: 8px;">
        <script language="javascript" type="text/javascript">
            function ShowHide(theDiv, YN, theFocus) {
                $(document).ready(function () {

                    if (YN == "show") {
                        //                    $("#" + theDiv).slideDown();
                        $("#" + theDiv).show();

                    }
                    if (YN == "hide") {
                        //                    $("#" + theDiv).slideUp();
                        $("#" + theDiv).hide();


                    }

                });

            }
            function WindowPrint() {
                window.print();
            }
            //DropDown list
            function getSelectedValue(DivId, DDText, str) {
                var e = document.getElementById(DDText);
                var text = e.options[e.selectedIndex].innerText;
                var YN = "";
                if (text == str) {
                    YN = "show";
                }
                else {
                    YN = "hide";
                }
                ShowHide(DivId, YN);
            }
        </script>
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                Clinical Status</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad5 center whitebg" colspan="2" width="100%" id="tdFamilyPlanning"
                            runat="server">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <label id="lblFP" runat="server">
                                            Care Entry Point:</label>
                                        <asp:DropDownList ID="ddlCareEntryPoint" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <div id="divCareEntryPointOther" style="display: none;">
                                            <table width="100%">
                                                <tbody>
                                                    <tr>
                                                        <td align="right">
                                                            <label id="Label6" runat="server">
                                                                Other (Specify):</label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtCareEntryOther" runat="server" Width="200px">
                                                            </asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" width="50%">
                            <label class="margin20" id="lblFS" runat="server">
                                Date of Confirmed HIV Test:</label>
                            <input id="txtConfHIVdate" maxlength="11" size="11" runat="server" type="text" />
                            <img onclick="w_displayDatePicker('<%=txtConfHIVdate.ClientID%>');" height="22" alt="Date Helper"
                                hspace="3" src="../images/cal_icon.gif" width="22" border="0" />
                        </td>
                        <td class="border pad5 whitebg" width="50%">
                            <label id="lblTBStatus" runat="server">
                                Mode of HIV Test:</label>
                            <asp:DropDownList ID="ddlModeHIVTest" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" width="50%">
                            <label class="margin20">
                                Where:</label>
                            <asp:TextBox ID="txtmodetestwhere" runat="server"></asp:TextBox>
                        </td>
                        <td class="border pad5 whitebg" width="50%">
                            <label class="margin20">
                                Prior ART:</label>
                            <asp:DropDownList ID="ddlPriorART" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                ART Commencement</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad5 whitebg" width="50%">
                            <label class="margin20" id="Label4" runat="server">
                                Date Medically Elligible:</label>
                            <input id="txtMedElligDate" maxlength="11" size="11" runat="server" type="text" />
                            <img onclick="w_displayDatePicker('<%=txtMedElligDate.ClientID%>');" height="22"
                                alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22" border="0" />
                        </td>
                        <td class="border pad5 whitebg" width="50%">
                            <label id="Label5" runat="server">
                                Why Elligible:</label>
                            <asp:DropDownList ID="ddlwhyelligible" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 center whitebg" colspan="2" width="100%" id="td1" runat="server">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <label id="Label1" runat="server">
                                            Date Initial Adherence Counseling Completed :</label>
                                        <input id="txtIntAdhCounsling" maxlength="11" size="11" runat="server" type="text" />
                                        <img onclick="w_displayDatePicker('<%=txtIntAdhCounsling.ClientID%>');" height="22"
                                            alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22" border="0" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" width="50%">
                            <label class="margin20" id="Label2" runat="server">
                                Date Transferred In:</label>
                            <input id="txtTransferedIn" maxlength="11" size="11" runat="server" type="text" />
                            <img onclick="w_displayDatePicker('<%=txtTransferedIn.ClientID%>');" height="22" alt="Date Helper"
                                hspace="3" src="../images/cal_icon.gif" width="22" border="0" />
                        </td>
                        <td class="border pad5 whitebg" width="50%">
                            <label id="Label3" runat="server">
                                Facility Transferred From:</label>
                            <asp:DropDownList ID="ddlFacTransfFrom" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 id="H3" class="forms" align="left">
                Drug Allergies</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad5 whitebg" align="center" width="100%">
                            <UcDrugAllergies:Uc6 ID="UCDrugAllergies" runat="server" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table4" runat="server">
                <tr id="Tr2" runat="server" align="center">
                    <td id="Td3" runat="server" class="form">
                        <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" />
                        <asp:Button ID="btndataquality" Text="Data Quality check" runat="server" 
                            onclick="btndataquality_Click" />
                        <asp:Button ID="btnclose" runat="server" Text="Close" 
                            onclick="btnclose_Click" />
                        <asp:Button ID="btnPrint" runat="server" OnClientClick="WindowPrint()" 
                            Text="Print" onclick="btnPrint_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
