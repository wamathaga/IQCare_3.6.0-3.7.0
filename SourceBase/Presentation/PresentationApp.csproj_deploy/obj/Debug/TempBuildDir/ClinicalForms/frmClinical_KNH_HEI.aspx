<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true" 
    CodeBehind="frmClinical_KNH_HEI.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_KNH_HEI" %>
<%@ Register TagPrefix="UcVitalSign" TagName="Uc1" Src="~/ClinicalForms/UserControl/UserControlKNH_VitalSigns.ascx" %>
<%@ Register TagPrefix="UcHEIPrescomplaints" TagName="UcPC" Src="~/ClinicalForms/UserControl/UserControlKNHPresentingComplaints.ascx" %>
<%@ Register TagPrefix="UcNextAppointment" TagName="UcNxtAppt" Src="~/ClinicalForms/UserControl/UserControlKNH_NextAppointment.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script type="text/javascript" language="javascript">
        function fnPlaceofdelivery() {
            var e = document.getElementById("<%=ddlPlaceofDelivery.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other facility") {
                show('spnotherfacility');
                hide('spanotherdelivery');
            }
            else if (strtext == "Other Specify") {
                hide('spnotherfacility');
                show('spanotherdelivery');
            }
            else {
                hide('spnotherfacility');
                hide('spanotherdelivery');
            }
        }

        function fnPlan() {
            var e = document.getElementById("<%=ddlPlan.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Select") {
                hide('spnRegimen');
            }
            else {
                show('spnRegimen');
            }
        }

        function fnotherARVProphylaxis() {
            var e = document.getElementById("<%=ddlARVProphylaxis.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other Specify") {
                show('spnotherARVProphy');
            }
            else {
                hide('spnotherARVProphy');
            }
        }

        function fnotherfeedingoption() {
            var e = document.getElementById("<%=ddlIfeedingoption.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other") {
                show('spnotherfeedingoption');
            }
            else {
                hide('spnotherfeedingoption');
            }
        }

        function fnANCmotherfollowup() {
            var e = document.getElementById("<%=ddlmothersANCFU.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other Facility") {
                show('spnANCFollowup');
            }
            else {
                hide('spnANCFollowup');
            }
        }
        function fnreferredto() {
            var e = document.getElementById("<%=ddlReferred.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other") {
                show('spnReferredto');
            }
            else {
                hide('spnReferredto');
            }
        }
        function fnsetCollapseState() {
            var e = document.getElementById("<%=ddlVisitType.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Select") {
                alert('Please select visit type');
            }
        }

        function changeTab() {
            var tabBehavior = $get('<%=tabControl.ClientID%>').control;
            //Set the Currently Visible Tab 
            tabBehavior.set_activeTabIndex(1);
            document.getElementById('<%=btnHIVHistorySave.ClientID%>').disabled = false;
            document.getElementById('<%=btncloseHIVHistory.ClientID%>').disabled = false;
        }
       

    </script>
    <div style="padding-left: 8px; padding-right: 8px; padding-top: 2px; background-color: White">
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tr>
                    <td class="border pad5 whitebg" width="50%">
                        <label class="required margin20">
                            Visit date:
                        </label>
                        <input id="txtVisitDate" onblur="DateFormat(this,this.value,event,false,3)" onkeyup="DateFormat(this,this.value,event,false,3);"
                            onfocus="javascript:vDateType='3'" maxlength="11" size="11" runat="server" type="text" />
                        <img id="appDateimg1" onclick="w_displayDatePicker('<%=txtVisitDate.ClientID%>');"
                            height="22 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                            border="0" name="appDateimg" style="vertical-align: text-bottom;" /><span class="smallerlabel"
                                id="appDatespan1">(DD-MMM-YYYY)</span>
                    </td>
                    <td class="border pad5 whitebg" width="50%">
                        <label class="required margin20">
                            Visit Type:
                        </label>
                        <asp:DropDownList ID="ddlVisitType" runat="server" OnSelectedIndexChanged="ddlVisitType_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="border formbg">
            <br />
            <act:TabContainer ID="tabControl" runat="server" ActiveTabIndex="0" Width="100%">
                <act:TabPanel ID="TabPnlTriage" runat="server" Font-Size="Large" HeaderText="Triage and Neonatal History">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1VitalSigns" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImgPC" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblVitalSigns" runat="server" Text="Vital Signs"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2VitalSigns" runat="server">
                                            <div id="VitalSigns" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <%--<tr>
<td class="border pad5 whitebg" width="100%">
<table width="100%" border="0">
<tr>
<td align="center" style="width: 33%;">
<label id="lblTemp" runat="server">
Temp 0c:</label>
<asp:TextBox ID="txtTemp" runat="server" MaxLength="5" Columns="4"></asp:TextBox>
<span class="smallerlabel">c</span>
</td>
<td align="center" style="width: 33%;">
<label id="lblRR" runat="server">
RR (bpm):</label>
<asp:TextBox ID="txtRR" runat="server" MaxLength="3" Columns="4"></asp:TextBox>
<span class="smallerlabel">bpm</span>
</td>
<td align="center" style="width: 34%;">
<label id="lblHR" runat="server">
HR (Bpm):</label>
<asp:TextBox ID="txtHR" runat="server" MaxLength="6" Columns="4"></asp:TextBox>
<span class="smallerlabel">bpm</span>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td class="border pad5 whitebg" width="100%">
<table width="100%" border="0">
<tr>
<td align="center" style="width: 50%;">
<label id="lblHeight" runat="server">
Height (cms):</label>
<asp:TextBox ID="txtHeight" runat="server" MaxLength="5" Columns="4"></asp:TextBox>
<span class="smallerlabel">cm</span>
</td>
<td align="center" style="width: 50%;">
<label id="lblWeight" runat="server">
Weight (kgs):</label>
<asp:TextBox ID="txtWeight" runat="server" MaxLength="3" Columns="4"></asp:TextBox>
<span class="smallerlabel">kg</span>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td class="border pad5 whitebg" width="100%">
<table width="100%" border="0">
<tr>
<td align="center" style="width: 50%;">
<label id="lblWeightforHeight" runat="server">
Weight for Height:</label>
<label id="lblDisplayWeightforHeight" runat="server">
</label>
</td>
<td align="center" style="width: 50%;">
<label id="lblWeightforAge" runat="server">
Weight for age:</label>
<label id="lblDisplayWeightforAge" runat="server">
</label>
</td>
</tr>
</table>
</td>
</tr>--%>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <UcVitalSign:Uc1 ID="idVitalSign" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1NNHistory" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgNigeriaMedical" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblNNHistory" runat="server" Text="Neo Natal History"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnl2NNHistory" runat="server">
                                            <div id="NNHistory" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="50%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label1" runat="server">
                                                                            Source of Referral:</label>
                                                                        <asp:TextBox ID="txtSourceofReferral" runat="server" MaxLength="50" Columns="50"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label class="margin10" align="center" id="Label2" runat="server">
                                                                            Place of Delivery:</label>
                                                                        <asp:DropDownList ID="ddlPlaceofDelivery" onchange="fnPlaceofdelivery();" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 50%;" align="center">
                                                                    </td>
                                                                    <td style="width: 50%;" align="left">
                                                                        <span id="spnotherfacility" style="display: none">
                                                                            <label class="margin10" align="center" id="Label26" runat="server">
                                                                                Other Facility:</label>
                                                                            <asp:TextBox ID="txtOtherFacility" runat="server" MaxLength="45" Columns="45"></asp:TextBox>
                                                                        </span><span id="spanotherdelivery" style="display: none">
                                                                            <label class="margin10" align="center" id="Label27" runat="server">
                                                                                Specify Other:</label>
                                                                            <asp:TextBox ID="txtOtherDelivery" runat="server" MaxLength="45" Columns="45"></asp:TextBox>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%; margin-left: 20px">
                                                                        <label id="Label5" runat="server">
                                                                            Mode of delivery:</label>
                                                                        <asp:DropDownList ID="ddlModeofDelivery" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label6" runat="server">
                                                                            Birth Weight (kgs):</label>
                                                                        <asp:TextBox ID="txtBirthWeight" runat="server" MaxLength="3" Columns="4"></asp:TextBox>
                                                                        <span class="smallerlabel">kg</span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label8" runat="server">
                                                                            ARV Prophylaxis:</label>
                                                                        <asp:DropDownList ID="ddlARVProphylaxis" onchange="fnotherARVProphylaxis();" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label11" runat="server">
                                                                            Infant feeding option:</label>
                                                                        <asp:DropDownList ID="ddlIfeedingoption" onchange="fnotherfeedingoption();" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left" style="width: 50%;">
                                                                        <span id="spnotherARVProphy" style="display: none">
                                                                            <label id="Label28" style="margin-left: 51px;" runat="server">
                                                                                Specify Other:</label>
                                                                            <asp:TextBox ID="txtOtherARVProphylaxis" runat="server" MaxLength="25" Columns="25"></asp:TextBox>
                                                                        </span>
                                                                    </td>
                                                                    <td align="center" style="width: 50%;">
                                                                        <span id="spnotherfeedingoption" style="display: none">
                                                                            <label id="Label29" style="margin-left: 10px;" runat="server">
                                                                                Specify Other:</label>
                                                                            <asp:TextBox ID="txtOtherFeedingoption" runat="server" MaxLength="25" Columns="25"></asp:TextBox>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <caption>
                                                        <br />
                                                        <tr>
                                                            <td class="border pad5 whitebg" width="100%">
                                                                <table border="0" width="100%">
                                                                    <tr>
                                                                        <td style="width: 50%;">
                                                                            <label id="Label9" runat="server" class="margin50">
                                                                                Type of Test:</label>
                                                                            <asp:DropDownList ID="ddlTypeofTest" runat="server">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td style="width: 50%; padding-left: 33px;">
                                                                            <label id="Label4" runat="server" style="margin-left: 70px">
                                                                                Results:</label>
                                                                            <asp:TextBox ID="txtTestResults" runat="server" Columns="30" MaxLength="30"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br />
                                                                <table border="0" width="100%">
                                                                    <tr>
                                                                        <td style="width: 50%;">
                                                                            <label id="Label7" runat="server" class="margin35">
                                                                                Date results given to guardian:
                                                                                <input id="txttestresultsgiven" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,3)"
                                                                                    onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,3);"
                                                                                    size="11" type="text" />
                                                                                <img id="Img1" onclick="w_displayDatePicker('<%=txttestresultsgiven.ClientID%>');"
                                                                                    height="20 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                                                                                    border="0" name="appDateimg" style="vertical-align: text-bottom;" /><span id="Span3"
                                                                                        class="smallerlabel">(DD-MMM-YYYY)</span></label>
                                                                        </td>
                                                                        <td align="center" style="width: 50%; padding-left: 33px;">
                                                                            <label id="Label10" runat="server" class="margin50">
                                                                                Comments:</label>
                                                                            <asp:TextBox ID="txtcomments" runat="server" Columns="30" MaxLength="30"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="border pad5 formbg" width="100%">
                                                                <div id="divbtnPriorART" align="center" class="whitebg">
                                                                    <asp:Button ID="btAddNNatal" runat="server" OnClick="btAddNNatal_Click" Text="Add" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="pad5 formbg border" colspan="2">
                                                                <div id="divDrugAllergyMedicalAlr" class="grid" style="width: 100%;">
                                                                    <div class="rounded">
                                                                        <div class="top-outer">
                                                                            <div class="top-inner">
                                                                                <div class="top">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="mid-outer">
                                                                            <div class="mid-inner">
                                                                                <div class="mid" style="height: 100px; overflow: auto">
                                                                                    <div id="div-gridview" class="GridView whitebg">
                                                                                        <asp:GridView ID="GrdNNHistory" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                            BorderWidth="1px" CellPadding="0" CssClass="datatable" GridLines="None" Height="25px"
                                                                                            OnRowDataBound="GrdNNHistory_RowDataBound" OnRowDeleting="GrdNNHistory_RowDeleting"
                                                                                            OnSelectedIndexChanging="GrdNNHistory_SelectedIndexChanging" Width="100%">
                                                                                            <HeaderStyle HorizontalAlign="Center" />
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
                                                            </td>
                                                        </tr>
                                                    </caption>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:Panel ID="pnl1MHistory" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgDAToxities" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                Maternal History</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:Panel ID="pnl2MHistory" runat="server">
                                            <div id="MHistory" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label12" runat="server">
                                                                            Mother Registered at this Clinic:</label>
                                                                        <input id="rdoMotherRegisYes" type="radio" value="Yes" runat="server" name="MotherRegister" />

                                                                        <label for="rdoMotherRegisYes">
                                                                            Yes</label>
                                                                        <input id="rdoMotherRegisNo" runat="server" name="MotherRegister" type="radio" value="No" />
                                                                        
                                                                        <label for="rdoMotherRegisNo">
                                                                            No</label>
                                                                    </td>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label13" runat="server">
                                                                            Place of mothers ANC follow up:</label>
                                                                        <asp:DropDownList ID="ddlmothersANCFU" onchange="fnANCmotherfollowup();" runat="server">
                                                                        </asp:DropDownList>
                                                                        <br />
                                                                        <span id="spnANCFollowup" style="display: none">
                                                                            <label id="Label30" runat="server">
                                                                                Specify other Facility:</label>
                                                                            <asp:TextBox ID="txtmotherANCfollowup" runat="server" Columns="30" MaxLength="30"></asp:TextBox>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label14" runat="server">
                                                                            Mother received drugs for PMTCT:</label>
                                                                        <input id="rdMotherRDrugYes" type="radio" runat="server" name="MotherRDrug" />
                                                                        <label for="rdMotherRDrugYes">
                                                                            Yes</label>
                                                                        <input id="rdMotherRDrugNo" runat="server" name="MotherRDrug" type="radio" />
                                                                        <label for="rdMotherRDrugNo">
                                                                            No</label>
                                                                    </td>
                                                                    <td align="center" style="width: 50%;">
                                                                        <label id="Label15" runat="server">
                                                                            State of mother:</label>
                                                                        <asp:DropDownList ID="ddlStateofMother" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td align="left" style="width: 100%;">
                                                                        <label style="margin-left: 80px" id="Label16" runat="server">
                                                                            On ART at enrollment of infant:</label>
                                                                        <input id="rdoARTEnrolYes" type="radio" value="Yes" runat="server" name="ARTEnrol" />
                                                                        <label for="rdoARTEnrolYes">
                                                                            Yes</label>
                                                                        <input id="rdoARTEnrolNo" runat="server" name="ARTEnrol" type="radio" value="No" />
                                                                        <label for="rdoARTEnrolNo">
                                                                            No</label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label style="margin-left: 70px" id="Label17" runat="server">
                                                                            Test done:</label>
                                                                        <asp:DropDownList ID="ddlTestDone" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label18" style="margin-left: 29px" runat="server">
                                                                            Test results:</label>
                                                                        <asp:TextBox ID="txtresultmother" runat="server" MaxLength="44" Columns="43"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label style="margin-left: 22px" id="Label19" runat="server">
                                                                            Date results given:
                                                                            <input id="txtresultmothergiven" onblur="DateFormat(this,this.value,event,false,3)"
                                                                                onkeyup="DateFormat(this,this.value,event,false,3);" onfocus="javascript:vDateType='3'"
                                                                                maxlength="11" size="11" runat="server" type="text" />
                                                                                <label for="txtresultmothergiven"><img id="Img4"
                                                                                onclick="w_displayDatePicker('<%=txtresultmothergiven.ClientID%>');" height="22 "
                                                                                alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22" border="0"
                                                                                name="appDateimg" style="vertical-align: text-bottom;" /><span class="smallerlabel"
                                                                                    id="Span4">(DD-MMM-YYYY)</span></label></label>
                                                                    </td>
                                                                    <td align="left" style="width: 50%;">
                                                                        <label style="margin-left: 44px; vertical-align: super" id="Label20" runat="server">
                                                                            Remarks:</label>
                                                                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="60%"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 formbg" width="100%">
                                                            <div id="div1" class="whitebg" align="center">
                                                                <asp:Button ID="btnMMother" Text="Add" runat="server" OnClick="btnMMother_Click" /></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="pad5 formbg border" colspan="2">
                                                            <div class="grid" id="div2" style="width: 100%;">
                                                                <div class="rounded">
                                                                    <div class="top-outer">
                                                                        <div class="top-inner">
                                                                            <div class="top">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="mid-outer">
                                                                        <div class="mid-inner">
                                                                            <div class="mid" style="height: 100px; overflow: auto">
                                                                                <div id="div3" class="GridView whitebg">
                                                                                    <asp:GridView Height="25px" ID="GrdMMHistory" runat="server" AutoGenerateColumns="False"
                                                                                        Width="100%" AllowSorting="True" BorderWidth="1px" GridLines="None" CssClass="datatable"
                                                                                        CellPadding="0" OnRowDataBound="GrdMMHistory_RowDataBound" OnRowDeleting="GrdMMHistory_RowDeleting"
                                                                                        OnSelectedIndexChanging="GrdMMHistory_SelectedIndexChanging">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
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
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <act:CollapsiblePanelExtender ID="CPEVitalSigns" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2VitalSigns" CollapseControlID="pnl1VitalSigns"
                                ExpandControlID="pnl1VitalSigns" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="ImgPC" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPENNHistory" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2NNHistory" CollapseControlID="pnl1NNHistory"
                                ExpandControlID="pnl1NNHistory" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imgNigeriaMedical" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEMHistory" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2MHistory" CollapseControlID="pnl1MHistory"
                                ExpandControlID="pnl1MHistory" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imgDAToxities" Enabled="True">
                            </act:CollapsiblePanelExtender>
                        </div>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table4" runat="server">
                                <tr id="Tr2" runat="server" align="center">
                                    <td id="Td2" runat="server" class="form">
                                        <asp:Button ID="btnClinicalHistorySave" runat="server" Text="Save" OnClick="btnClinicalHistorySave_Click" />
                                        <asp:Button ID="btncloseClinicalHist" runat="server" Text="Close" />
                                        <asp:Button ID="btnClinicalHistoryPrint" runat="server" Text="Print" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <act:TabPanel ID="TabClinicalHistory" runat="server" Font-Size="Large" HeaderText="Clinical Review">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1IHistory" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imghivrelhistory" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblIHistory" runat="server" Text="Immunization History"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2IHistory" runat="server" Visible="True">
                                            <div id="IHistory" style="display: none">
                                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <table width="100%" class="border center pad5 whitebg">
                                                                <tr>
                                                                    <td width="40%" align="left">
                                                                        <asp:Label ID="lblDateImmunised" runat="server" Font-Bold="True" Text="Date Immunised:"></asp:Label><label>
                                                                            <input id="txtDateImmunised" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                                                                onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,'3')"
                                                                                size="11" type="text" />
                                                                            </input><img id="Img5" alt="Date Helper" border="0" height="22 " hspace="5" name="appDateimg"
                                                                                onclick="w_displayDatePicker('<%=txtDateImmunised.ClientID%>');" src="../images/cal_icon.gif"
                                                                                style="vertical-align: text-bottom;" width="22" /><span class="smallerlabel" id="Span5">(DD-MMM-YYYY)</span></label>
                                                                    </td>
                                                                    <td width="30%" align="center" style="padding-left: 50px;">
                                                                        <asp:Label ID="lblImmunisationPeriod" runat="server" Font-Bold="True" Text="Immunization Period:"></asp:Label>
                                                                        <asp:DropDownList ID="ddlImmunisationPeriod" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td width="30%" align="right">
                                                                        <asp:Label ID="lblImmunisationGiven" runat="server" Font-Bold="True" Text="Immunizations Given:"></asp:Label>
                                                                        <asp:DropDownList ID="ddImmunisationgiven" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PComplaints" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgpriorart" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblPComplaints" runat="server" Text="Presenting Complaints"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnl2PComplaints" runat="server" Visible="True">
                                            <div id="PComplaints" style="display: none">
                                                <table width="100%">
                                                    <tr>
                                                        <td>
                                                            <UcHEIPrescomplaints:UcPC ID="UcHEIPcomplaints" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="Pnl1Examination" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgAdherence" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label3" runat="server" Text="Examination"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <asp:Panel ID="Pnl2Examination" runat="server" Visible="True">
                                            <div id="Examination" style="display: none">
                                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <table width="100%" class="border center pad5 whitebg">
                                                                <tr>
                                                                    <td width="25%" align="left">
                                                                        <asp:Label ID="Label21" runat="server" Font-Bold="True" Text="Examination:"></asp:Label><br />
                                                                        <asp:TextBox ID="txtExamination" TextMode="MultiLine" runat="server" Width="99%"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnl1MileStones" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImgARVSideEffect" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                Milestones</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2MileStones" runat="server" Visible="True">
                                            <div id="MileStones" style="display: none">
                                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <table width="100%" class="border center pad5 whitebg">
                                                                <tr>
                                                                    <td width="100%" align="left">
                                                                        <asp:Label ID="lblMilestones" runat="server" Font-Bold="True" Text="Milestones assessment:"></asp:Label>
                                                                        <asp:DropDownList ID="ddlMilestones" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="Pnl1Diagnosis" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                Diagnosis</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="Pnl2Diagnosis" runat="server" Visible="True">
                                            <div id="Diagnosis" style="display: none">
                                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <table width="100%" class="border center pad5 whitebg">
                                                                <tr>
                                                                    <td width="25%" align="left">
                                                                        <asp:Label ID="lblDiagnosis" runat="server" Font-Bold="True" Text="Diagnosis:"></asp:Label>
                                                                        <div class="divborder checkbox" id="divdiagnosis">
                                                                            <asp:Panel ID="PnlDiagnosis" runat="server">
                                                                            </asp:Panel>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="Pnl1ManagementPlan" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton2" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                Management Plan</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="Pnl2ManagementPlan" runat="server" Visible="True">
                                            <div id="ManagementPlan" style="display: none">
                                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <table width="100%" class="border center pad5 whitebg">
                                                                <tr>
                                                                    <td width="50%" align="left">
                                                                        <asp:Label ID="Label22" runat="server" Font-Bold="True" Text="TB Assesment Outcome:"></asp:Label>
                                                                        <asp:DropDownList ID="ddlTBAssesment" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td width="100%" align="left">
                                                                        <asp:Label ID="Label23" runat="server" Font-Bold="True" Text="Has Vitamin A been given?:"></asp:Label>
                                                                        <input id="rdoHasVitaminGivenYes" name="Vitamingiven" type="radio" runat="server" /></input><label>Yes</label>
                                                                        <input id="rdoHasVitaminGivenNo" name="Vitamingiven" type="radio" runat="server" /></input><label>No</label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <table width="100%" class="border center pad5 whitebg">
                                                                <tr>
                                                                    <td width="50%" align="left">
                                                                        <asp:Label ID="Label24" runat="server" Font-Bold="True" Text="Plan:"></asp:Label>
                                                                        <asp:DropDownList ID="ddlPlan" onchange="fnPlan();" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td width="50%" align="left">
                                                                        <span id="spnRegimen" style="display: none">
                                                                            <asp:Label ID="Label25" runat="server" Font-Bold="True" Text="Regimen:"></asp:Label>
                                                                            <asp:DropDownList ID="ddlRegimen" runat="server">
                                                                            </asp:DropDownList>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="Pnl1RefAdminAppointment" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton3" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                Referral, Admission and Appointments</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="Pnl2RefAdminAppointment" runat="server" Visible="True">
                                            <div id="AdminAppointment" style="display: none">
                                                <table width="100%" class="formbg" cellspacing="6" cellpadding="0" border="0">
                                                    <tr>
                                                        <td width="50%" class="border pad5 whitebg">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="center">
                                                                        <label>
                                                                            Referred to?:</label>
                                                                        <asp:DropDownList ID="ddlReferred" onchange="fnreferredto();" runat="server">
                                                                        </asp:DropDownList>
                                                                        <span id="spnReferredto" style="display: none">
                                                                            <br />
                                                                            <br />
                                                                            <label>
                                                                                Specify Other:</label>
                                                                            <asp:TextBox ID="txtOtherReferredto" runat="server" MaxLength="30" Columns="30"></asp:TextBox>
                                                                        </span>
                                                                    </td>
                                                                    <td align="center">
                                                                        <label>
                                                                            Admit to ward?:</label>
                                                                        <label>
                                                                            <input id="rdoadmittowardyes" type="radio" name="Ward" runat="server" />Yes</label>
                                                                        <label>
                                                                            <input id="rdoadmittowardno" type="radio" name="Ward" runat="server" />No</label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="100%" class="border pad5 whitebg">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="left" colspan="2" width="100%">
                                                                        <UcNextAppointment:UcNxtAppt ID="UserControlKNH_NextAppointment" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <act:CollapsiblePanelExtender ID="CPEIHistory" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2IHistory" CollapseControlID="pnl1IHistory"
                                ExpandControlID="pnl1IHistory" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imghivrelhistory" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEPComplaints" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PComplaints" CollapseControlID="pnl1PComplaints"
                                ExpandControlID="pnl1PComplaints" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imgpriorart" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEExamination" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="Pnl2Examination" CollapseControlID="Pnl1Examination"
                                ExpandControlID="Pnl1Examination" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imgAdherence" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEMileStones" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2MileStones" CollapseControlID="pnl1MileStones"
                                ExpandControlID="pnl1MileStones" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="ImgARVSideEffect" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEDisgonsis" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="Pnl2Diagnosis" CollapseControlID="Pnl1Diagnosis"
                                ExpandControlID="Pnl1Diagnosis" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="ImgARVSideEffect" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEManagmentPlan" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="Pnl2ManagementPlan" CollapseControlID="Pnl1ManagementPlan"
                                ExpandControlID="Pnl1ManagementPlan" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="ImgARVSideEffect" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEREfAppointment" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="Pnl2RefAdminAppointment"
                                CollapseControlID="Pnl1RefAdminAppointment" ExpandControlID="Pnl1RefAdminAppointment"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgARVSideEffect"
                                Enabled="True">
                            </act:CollapsiblePanelExtender>
                        </div>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table1" runat="server">
                                <tr id="Tr4" runat="server" align="center">
                                    <td id="Td4" runat="server" class="form">
                                        <asp:Button ID="btnHIVHistorySave" runat="server" Text="Save" Enabled="false" OnClick="btnHIVHistorySave_Click" />
                                        <asp:Button ID="btncloseHIVHistory" runat="server" Text="Close" Enabled="false" OnClick="btncloseHIVHistory_Click" />
                                        <asp:Button ID="btnHIVHistoryPrint" runat="server" OnClientClick="WindowPrint()"
                                            Text="Print" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
            </act:TabContainer>
        </div>
    </div>
</asp:Content>
