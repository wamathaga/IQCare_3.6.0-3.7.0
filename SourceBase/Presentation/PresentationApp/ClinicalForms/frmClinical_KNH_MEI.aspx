﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmClinical_KNH_MEI.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_KNH_MEI" %>

<%@ Register TagPrefix="UcVitalSign" TagName="Uc1" Src="~/ClinicalForms/UserControl/UserControlKNH_VitalSigns.ascx" %>
<%@ Register TagPrefix="UcWhoStaging" TagName="Uc2" Src="~/ClinicalForms/UserControl/UserControlKNH_WHOStaging.ascx" %>
<%@ Register TagPrefix="UcTBScreening" TagName="Uc1" Src="~/ClinicalForms/UserControl/UserControlKNH_TBScreening.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script type="text/javascript" language="javascript">
        function WindowPrintAll() {
            window.print();
        }
        function SelectAllCheckboxes() {
            $('#<%=grdLatestResults.ClientID%>').find("input:checkbox").removeAttr("disabled");
        }
        function fnsetCollapseState() {
            var e = document.getElementById("<%=ddlFieldVisitType.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Select") {
                alert('Please select visit type');
            }
        }
        function fnotherHMHealth() {
            var e = document.getElementById("<%=ddlHMHealth.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other (specify)") {
                show('divHMentalHealth');
            }
            else {
                hide('divHMentalHealth');
            }
        }
        function fnotherCMHealth() {
            var e = document.getElementById("<%=ddlCMHealth.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other") {
                show('divCMentalHealth');
            }
            else {
                hide('divCMentalHealth');
            }
        }

        function fnotherCTXStopreason() {
            var e = document.getElementById("<%=ddlCTX.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Stop CTX") {
                show('divctx');
            }
            else {
                hide('divctx');
            }
        }

        function fnotherCurrentRegimen() {
            var e = document.getElementById("<%=ddlSpecifyCurrentRegmn.ClientID%>");
            var strtext = e.options[e.selectedIndex].text;
            if (strtext == "Other") {
                show('tdothercurrentregimen');
            }
            else {
                hide('tdothercurrentregimen');
            }

        }

        function checkNone(searchEles, Id_None) {
            for (var i = 0; i < searchEles.length; i++) {
                if (searchEles[i].children.length > 0) {
                    for (var ii = 0; ii < searchEles[i].children.length; ii++) {
                        if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].htmlFor != Id_None) {
                            document.getElementById(searchEles[i].children[ii].htmlFor).checked = false;
                        }
                        else if (searchEles[i].children[ii].textContent == "Other" && searchEles[i].children[ii].tagName == 'SPAN') {
                            for (var iii = 0; iii < searchEles[i].children[ii].children.length; iii++) {
                                for (var iv = 0; iv < searchEles[i].children[ii].children.length; iv++) {
                                    if (searchEles[i].children[ii].children[iii].children[iv].tagName == 'LABEL' && searchEles[i].children[ii].children[iii].children[iv].htmlFor != Id_None) {
                                        document.getElementById(searchEles[i].children[ii].children[iii].children[iv].htmlFor).checked = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        function checkNotNone(searchEles, Id_None) {
            for (var i = 0; i < searchEles.length; i++) {
                if (searchEles[i].children.length > 0) {
                    for (var ii = 0; ii < searchEles[i].children.length; ii++) {
                        if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].textContent == "None") {
                            document.getElementById(searchEles[i].children[ii].htmlFor).checked = false;
                        }
                    }
                }
            }
        }


        function GetCheckboxId(Id) {
            var searchEles = document.getElementById("<%=pnlBarriertoadherence.ClientID %>").children;
            for (var i = 0; i < searchEles.length; i++) {
                if (searchEles[i].children.length > 0) {
                    for (var ii = 0; ii < searchEles[i].children.length; ii++) {
                        if (searchEles[i].children[ii].textContent == "Other" && searchEles[i].children[ii].tagName == 'SPAN') {
                            for (var iii = 0; iii < searchEles[i].children[ii].children.length; iii++) {
                                for (var iv = 0; iv < searchEles[i].children[ii].children.length; iv++) {
                                    if (searchEles[i].children[ii].children[iii].children[iv].tagName == 'LABEL' && searchEles[i].children[ii].children[iii].children[iv].htmlFor == Id) {
                                        checkNotNone(searchEles, Id);
                                    }
                                }
                            }
                        }
                        else if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].textContent == "None" && searchEles[i].children[ii].htmlFor == Id) {
                            checkNone(searchEles, Id);
                        }
                        else if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].htmlFor == Id) {
                            checkNotNone(searchEles, Id);
                        }
                    }
                }
            }
        }

        function showHideControls() {
            var radioYes = document.getElementById('<%=rdotetanustoxoidyes.ClientID%>');
            if (radioYes.checked == true) {
                var ddl = document.getElementById('<%=ddlTTVaccine.ClientID%>');
                ddl.style.display = 'block';
            }
            else {
                var ddl = document.getElementById('<%=ddlTTVaccine.ClientID%>');
                ddl.style.display = 'none';
            }

            var radioNo = document.getElementById('<%= rdotetanustoxoidno.ClientID%>');
            if (radioNo.checked == true) {
                var txt = document.getElementById('<%=txtNoTTReason.ClientID%>');
                txt.style.display = 'block';
            }
            else {
                var txt = document.getElementById('<%=txtNoTTReason.ClientID%>');
                txt.style.display = 'none';
            }
        }
    </script>
    <div class="container-fluid">
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
                        <asp:DropDownList ID="ddlFieldVisitType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFieldVisitType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="border formbg">
            <br />
            <act:TabContainer ID="tabControl" runat="server" ActiveTabIndex="0" Width="100%">
                <%--Client Information--%>
                <act:TabPanel ID="TabPnlTriage" runat="server" Font-Size="Large" HeaderText="Triage">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1ClientInformation" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton4" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label31" runat="server" Text="Client Information"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2ClientInformation" runat="server">
                                            <div id="ClientInformation" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label id="lblLMP" runat="server" class="required margin35">
                                                                            LMP:</label>
                                                                        <input id="txtLMPDate" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,3)"
                                                                            onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,3);"
                                                                            size="11" type="text" />
                                                                        </input><img id="Img2" onclick="w_displayDatePicker('<%=txtLMPDate.ClientID%>');"
                                                                            height="20 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                                                                            border="0" name="appDateimg" style="vertical-align: text-bottom;" /><span id="Span1"
                                                                                class="smallerlabel">(DD-MMM-YYYY)</span>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="lblEDD" runat="server" class="required margin35">
                                                                            EDD:</label>
                                                                        <input id="txtEDD" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,3)"
                                                                            onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,3);"
                                                                            size="11" type="text" /><img id="Img3" onclick="w_displayDatePicker('<%=txtEDD.ClientID%>');"
                                                                                height="20 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                                                                                border="0" name="appDateimg" style="vertical-align: text-bottom;" /><span id="Span2"
                                                                                    class="smallerlabel">(DD-MMM-YYYY)</span>
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
                                                                        <label id="lblparity" runat="server" class="required margin35">
                                                                            Parity:</label>
                                                                        <asp:DropDownList ID="ddlparity" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="lblGravidae" runat="server" class="required margin35">
                                                                            Gravidae:</label>
                                                                        <asp:DropDownList ID="ddlGravidae" runat="server">
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
                                                                    <td style="width: 50%;">
                                                                        <label id="lblGestation" runat="server" class="required margin35">
                                                                            Gestation:</label>
                                                                        <asp:TextBox ID="txtGestation" runat="server" Width="20%" Columns="30" MaxLength="8"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="lblVisitNumber" runat="server" class="required margin35">
                                                                            Visit Number:</label>
                                                                        <asp:DropDownList ID="ddlVisitNumber" runat="server">
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
                                        <asp:Panel ID="pnl1VitalSigns" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImgPC" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblVitalSigns" runat="server" Text="Vital Signs"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2VitalSigns" runat="server">
                                            <div id="VitalSigns" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
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
                            <act:CollapsiblePanelExtender ID="CPEClientInformation" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2ClientInformation"
                                CollapseControlID="pnl1ClientInformation" ExpandControlID="pnl1ClientInformation"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEClientInformation"></act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEVitalSigns" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2VitalSigns" CollapseControlID="pnl1VitalSigns"
                                ExpandControlID="pnl1VitalSigns" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="ImgPC" BehaviorID="_content_CPEVitalSigns"></act:CollapsiblePanelExtender>
                        </div>
                        <br />
                        <div class="border center formbg">
                            <table id="Table1" cellspacing="6" cellpadding="0" width="100%" border="0" runat="server">
                                <tr id="Tr2" runat="server" align="center">
                                    <td id="Td2" runat="server" class="form">
                                        <asp:Button ID="btnTriageSave" runat="server" Text="Save" OnClick="btnTriageSave_Click"
                                            CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <asp:Label ID="lblSave" CssClass="glyphicon glyphicon-floppy-disk" Style="margin-left: -3%;
                                            margin-right: 2%; vertical-align: sub; color: #fff;" runat="server"></asp:Label>
                                        <asp:Label ID="lblDelete" CssClass="glyphicon glyphicon-floppy-remove" Style="margin-left: -3%;
                                            margin-right: 2%; vertical-align: sub; color: #fff;" runat="server" Visible="false"></asp:Label>
                                        <asp:Button ID="btnTriageClose" runat="server" Text="Close" OnClick="btnTriageClose_Click"
                                            CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-remove-circle" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnTriagePrint" runat="server" Text="Print" OnClientClick="WindowPrint()"
                                            CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-print" style="margin-left: -3%; vertical-align: sub;
                                            color: #fff;">
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <%--HTC--%>
                <act:TabPanel ID="TabPnlHTC" runat="server" Font-Size="Large" HeaderText="HTC">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1HTC" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="imgMHT" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblMHT" runat="server" Text="Maternal HIV Testing"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2HTC" runat="server">
                                            <div id="MHT" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label2" runat="server" class="margin5">
                                                                            Previous HIV Status:
                                                                            <asp:DropDownList ID="ddlPrevHIVStatus" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label3" runat="server" class="margin5">
                                                                            Previous Point of HIV Testing:
                                                                            <asp:DropDownList ID="ddlPrevPointHIVTesting" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 40%;">
                                                                        <label id="Label1" runat="server" class="margin5">
                                                                            Date of last HIV Test:
                                                                            <input id="txtLastHIVTest" onblur="DateFormat(this,this.value,event,false,3)" onkeyup="DateFormat(this,this.value,event,false,3);"
                                                                                onfocus="javascript:vDateType='3'" maxlength="11" size="11" runat="server" type="text" />
                                                                            <img id="Img1" onclick="w_displayDatePicker('<%=txtLastHIVTest.ClientID%>');" height="22 "
                                                                                alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22" border="0"
                                                                                name="appDateimg" style="vertical-align: text-bottom;" /><span class="smallerlabel"
                                                                                    id="Span3">(DD-MMM-YYYY)</span>
                                                                        </label>
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
                                                                        <label id="Label5" runat="server" class="margin20">
                                                                            Pre test counselling and testing:
                                                                            <asp:DropDownList ID="ddlPreTestCounselling" runat="server" Width="20%">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label9" runat="server" class="margin20">
                                                                            Post test counselling and testing:
                                                                            <asp:DropDownList ID="ddlPosttestcounselling" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
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
                                <%-- </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1MaternalTesting" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton2" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label8" runat="server" Text="Maternal Testing"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2MaternalTesting" runat="server">
                                            <div id="MT" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 100%;">
                                                                        <label id="lblHIVTesting" runat="server" class="margin20">
                                                                            Is client due for HIV Testing Today?:
                                                                            <input id="rdoHIVTestingTodayYes" type="radio" value="Yes" runat="server" name="HIVTestingToday" />
                                                                            <label for="rdoHIVTestingTodayYes">
                                                                                Yes</label>
                                                                            <input id="rdoHIVTestingTodayNo" type="radio" value="No" runat="server" name="HIVTestingToday" />
                                                                            <label for="rdoHIVTestingTodayNo">
                                                                                No</label>
                                                                        </label>
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
                                <%--</table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1HIVTestResultsToday" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label4" runat="server" Text="HIV Test Results Today"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2HIVTestResultsToday" runat="server">
                                            <div id="HTRT" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 100%;">
                                                                        <label id="Label6" runat="server" class="margin20">
                                                                            Final HIV result:
                                                                            <asp:DropDownList ID="ddlFinalHIVResult" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                        </label>
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
                                        <asp:Panel ID="pnl1PartnerHIVStatus" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton3" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label7" runat="server" Text="Partners HIV Status"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PartnerHIVStatus" runat="server">
                                            <div id="PHS" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 40%;">
                                                                        <label id="Label10" runat="server" class="margin20">
                                                                            Is Patient accompanied by partner?
                                                                            <input id="rdoPatientaccPartnerYes" type="radio" value="Yes" runat="server" name="Patientaccompaniedbypartner" />
                                                                            <label for="rdodiscordantcoupleYes">
                                                                                Yes</label>
                                                                            <input id="rdoPatientaccPartnerNo" type="radio" value="No" runat="server" name="Patientaccompaniedbypartner" />
                                                                            <label for="rdodiscordantcoupleNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr id="pap1" style="display: none">
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 10%;" colspan="3" class="margin20">
                                                                        <label id="Label11" runat="server">
                                                                            Pre Test Counselling:
                                                                            <asp:DropDownList ID="ddlpartnerPreTestCounselling" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <label id="Label15" runat="server" class="margin20">
                                                                            HIV Test done to partner:
                                                                            <asp:DropDownList ID="ddlHIVTestdonetopartner" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 10%;" class="margin20">
                                                                        <label id="Label12" runat="server">
                                                                            Final HIV result for partner:
                                                                            <asp:DropDownList ID="ddlPartnerFinalHIVresult" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr id="pap2" style="display: none">
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 10%;" class="margin20">
                                                                        <label id="Label13" runat="server">
                                                                            Post Test Counselling:
                                                                            <asp:DropDownList ID="ddlPartnerPostTestCounselling" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 10%;" colspan="3">
                                                                        <label id="Label14" runat="server" class="margin20">
                                                                            Is the couple discordant?
                                                                            <input id="rdodiscordantcoupleYes" type="radio" value="Yes" runat="server" name="discordantcouple" />
                                                                            <label for="rdodiscordantcoupleYes">
                                                                                Yes</label>
                                                                            <input id="rdodiscordantcoupleNo" type="radio" value="No" runat="server" name="discordantcouple" />
                                                                            <label for="rdodiscordantcoupleNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <label id="Label16" runat="server" class="margin20">
                                                                            Partners DNA PCR result?:
                                                                            <asp:DropDownList ID="ddlPartnerDNA" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
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
                                        <asp:Panel ID="pnl1FamilyHIVinformation" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton5" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label17" runat="server" Text="Family HIV information"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2FamilyHIVinformation" runat="server">
                                            <div id="FHI" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label18" runat="server" class="margin5">
                                                                            Has the family information form been filled?
                                                                            <input id="rdofamilyinformationFilledYes" type="radio" value="Yes" runat="server"
                                                                                name="familyinformationFilled" />
                                                                            <label for="rdofamilyinformationFilledYes">
                                                                                Yes</label>
                                                                            <input id="rdofamilyinformationFilledNo" type="radio" value="No" runat="server" name="familyinformationFilled"
                                                                                onclick="window.open('frmFamilyInformation.aspx');" />
                                                                            <label for="rdofamilyinformationFilledNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label19" runat="server" class="margin5">
                                                                            Have other members of the family been tested for HIV?
                                                                            <asp:DropDownList ID="ddlFamilybeentestedHIV" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
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
                            <act:CollapsiblePanelExtender ID="CPEHTC" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2HTC" CollapseControlID="pnl1HTC"
                                ExpandControlID="pnl1HTC" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="ImgPC" BehaviorID="_content_CPEHTC"></act:CollapsiblePanelExtender>
                            <%--<act:CollapsiblePanelExtender ID="CPEMaternalTesting" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2MaternalTesting" CollapseControlID="pnl1MaternalTesting"
                                ExpandControlID="pnl1MaternalTesting" CollapsedImage="~/images/arrow-up.gif"
                                Collapsed="True" ImageControlID="ImgPC" BehaviorID="_content_CPEMaternalTesting">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEHIVTestResultsToday" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2HIVTestResultsToday"
                                CollapseControlID="pnl1HIVTestResultsToday" ExpandControlID="pnl1HIVTestResultsToday"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEHIVTestResultsToday"></act:CollapsiblePanelExtender>--%>
                            <act:CollapsiblePanelExtender ID="CPEPartnerHIVStatus" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PartnerHIVStatus"
                                CollapseControlID="pnl1PartnerHIVStatus" ExpandControlID="pnl1PartnerHIVStatus"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEPartnerHIVStatus"></act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEFamilyHIVinformation" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2FamilyHIVinformation"
                                CollapseControlID="pnl1FamilyHIVinformation" ExpandControlID="pnl1FamilyHIVinformation"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEFamilyHIVinformation"></act:CollapsiblePanelExtender>
                        </div>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="tblHTC" runat="server">
                                <tr id="TrHTC" runat="server" align="center">
                                    <td id="TdHTC" runat="server" class="form">
                                        <asp:Button ID="btnHTCSave" runat="server" Text="Save" OnClick="btnHTCSave_Click"
                                            Enabled="false" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnHTCClose" runat="server" Text="Close" OnClick="btnHTCClose_Click"
                                            Enabled="false" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-remove-circle" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnHTCPrint" runat="server" Text="Print" OnClientClick="WindowPrint()"
                                            Enabled="false" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-print" style="margin-left: -3%; vertical-align: sub;
                                            color: #fff;">
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <%--profile--%>
                <act:TabPanel ID="TabPnlProfile" runat="server" Font-Size="Large" HeaderText="Profile">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PsychosocialHistoryGBV" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton6" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label20" runat="server" Text="Psychosocial History & GBV"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PsychosocialHistoryGBV" runat="server">
                                            <div id="PHG" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td id="tdHMH" style="width: 30%; display: none">
                                                                        <label id="Label21" runat="server" class="required margin5">
                                                                            Historic Mental Health:
                                                                            <asp:DropDownList ID="ddlHMHealth" onchange="fnotherHMHealth();" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                        <div id="divHMentalHealth" style="display: none">
                                                                            <asp:TextBox ID="txtHMentalHealth" runat="server"></asp:TextBox></div>
                                                                    </td>
                                                                    <td id="tdCMH" style="width: 30%; display: none">
                                                                        <label id="Label22" runat="server" class="margin5">
                                                                            Current Mental Health:
                                                                            <asp:DropDownList ID="ddlCMHealth" onchange="fnotherCMHealth();" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                        <div id="divCMentalHealth" style="display: none">
                                                                            <asp:TextBox ID="txtCMentalHealth" runat="server"></asp:TextBox></div>
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
                                                                        <div id="tdExGBV" style="display: none">
                                                                            <label id="Label24" runat="server" class="required">
                                                                                Experienced any GBV?</label>
                                                                            <input id="rdoExperienceanyGBVYes" type="radio" value="Yes" runat="server" name="ExperienceanyGBV" />
                                                                            <label for="rdoExperienceanyGBVYes">
                                                                                Yes</label>
                                                                            <input id="rdoExperienceanyGBVNo" type="radio" value="No" runat="server" name="ExperienceanyGBV" />
                                                                            <label for="rdoExperienceanyGBVNo">
                                                                                No</label>
                                                                        </div>
                                                                    </td>
                                                                    <td id="tdGBVExperienced" style="width: 50%; display: none; margin-left: -75%">
                                                                        <label id="Label25" runat="server" class="required">
                                                                            GBV Experienced:</label>
                                                                        <div id="divGBVExperienced" class="customdivbordermultiselect">
                                                                            <asp:Panel ID="pnlGBVExperienced" runat="server">
                                                                            </asp:Panel>
                                                                        </div>
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
                                                                        <div id="tdSubabuse" style="display: none">
                                                                            <label id="Label23" runat="server" class="required margin20">
                                                                                Substance abuse?</label>
                                                                            <input id="rdoHIVSubstanceAbusedYes" type="radio" value="Yes" runat="server" name="HIVSubstanceAbused" />
                                                                            <label for="rdoHIVSubstanceAbusedYes">
                                                                                Yes</label>
                                                                            <input id="rdoHIVSubstanceAbusedNo" type="radio" value="No" runat="server" name="HIVSubstanceAbused" />
                                                                            <label for="rdoHIVSubstanceAbusedNo">
                                                                                No</label>
                                                                        </div>
                                                                    </td>
                                                                    <td id="tdSubstanceAbused" style="width: 50%; display: none; margin-left: -75%">
                                                                        <label id="Label26" runat="server" class="required">
                                                                            Substance Abused:</label>
                                                                        <div id="divSubstanceAbused" class="customdivbordermultiselect">
                                                                            <asp:Panel ID="pnlSubstanceAbused" runat="server">
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
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1BirthandGeneralPlan" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton7" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label27" runat="server" Text="Birth and General Plan"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2BirthandGeneralPlan" runat="server">
                                            <div id="BGP" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label28" runat="server" class="required margin5">
                                                                            Preffered mode of delivery:
                                                                            <asp:DropDownList ID="ddlPreferedmodeofdelivery" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label29" runat="server" class="required margin5">
                                                                            Preffered Site of Delivery:
                                                                            <asp:TextBox ID="txtPreferedSiteDelivery" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 60%;" align="left">
                                                                        <label id="Label30" runat="server" class="margin20">
                                                                            Comments - Additional notes?</label>
                                                                        <asp:TextBox ID="txtPreferedSiteDeliveryAdditionalnotes" runat="server" TextMode="MultiLine"
                                                                            Style="height: 200px; vertical-align: middle" Width="80%"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 40%;" align="left">
                                                                        <label id="Label32" runat="server">
                                                                            Referral:</label>
                                                                        <div id="div20" class="customdivbordermultiselect">
                                                                            <asp:Panel ID="pnlReferral" runat="server">
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
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PreviousthreePregnanciesHistory" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton8" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label33" runat="server" Text="Previous three Pregnancies History"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PreviousthreePregnanciesHistory" runat="server">
                                            <div id="PTPH" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label34" runat="server" class="margin5">
                                                                            Year of Delivery:
                                                                            <asp:TextBox ID="txtYrofDelivery" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label35" runat="server" class="margin5">
                                                                            Place of Delivery:
                                                                            <asp:TextBox ID="txtPlaceofDelivery" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label38" runat="server" class="margin5">
                                                                            Maturity :
                                                                            <asp:DropDownList ID="ddlMaturityweeks" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
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
                                                                        <label id="Label36" runat="server" class="margin20">
                                                                            Labour duration (hrs)
                                                                            <asp:TextBox ID="txtLabourduratioin" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label37" runat="server" class="margin20">
                                                                            Mode of Delivery:
                                                                            <asp:DropDownList ID="ddlModeofDelivery" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
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
                                                                        <label id="Label39" runat="server" class="margin20">
                                                                            Gender
                                                                            <asp:DropDownList ID="ddlGenderofBaby" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label40" runat="server" class="margin20">
                                                                            Fate:
                                                                            <asp:DropDownList ID="ddlFateofBaby" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 formbg" width="100%">
                                                            <div id="divPTF" class="whitebg" align="center">
                                                                <asp:Button ID="btnPrevthreeFreq" Text="Add" runat="server" OnClick="btnPrevthreeFreq_Click"
                                                                    CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                                                <label class="glyphicon glyphicon-open" style="margin-left: -3%; vertical-align: sub;
                                                                    color: #fff;">
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="formbg border" colspan="3">
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
                                                                                    <asp:GridView Height="25px" ID="GrdPrevthreeFreq" runat="server" AutoGenerateColumns="False"
                                                                                        Width="100%" AllowSorting="True" BorderWidth="1px" GridLines="None" CssClass="datatable"
                                                                                        CellPadding="0" OnRowDataBound="GrdPrevthreeFreq_RowDataBound" OnRowDeleting="GrdPrevthreeFreq_RowDeleting"
                                                                                        OnSelectedIndexChanging="GrdPrevthreeFreq_SelectedIndexChanging">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                        <RowStyle CssClass="row" />
                                                                                    </asp:GridView>
                                                                                </div>
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
                            </table>
                            <act:CollapsiblePanelExtender ID="CPEPsychosocialHistoryGBV" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PsychosocialHistoryGBV"
                                CollapseControlID="pnl1PsychosocialHistoryGBV" ExpandControlID="pnl1PsychosocialHistoryGBV"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEPsychosocialHistoryGBV"></act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEBirthandGeneralPlan" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2BirthandGeneralPlan"
                                CollapseControlID="pnl1BirthandGeneralPlan" ExpandControlID="pnl1BirthandGeneralPlan"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEBirthandGeneralPlan"></act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPEPreviousthreePregnanciesHistory" runat="server"
                                SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PreviousthreePregnanciesHistory"
                                CollapseControlID="pnl1PreviousthreePregnanciesHistory" ExpandControlID="pnl1PreviousthreePregnanciesHistory"
                                CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                                BehaviorID="_content_CPEPreviousthreePregnanciesHistory"></act:CollapsiblePanelExtender>
                        </div>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table2" runat="server">
                                <tr id="Tr1" runat="server" align="center">
                                    <td id="Td1" runat="server" class="form">
                                        <asp:Button ID="btnProfileSave" runat="server" Text="Save" OnClick="btnProfileSave_Click1"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnProfileClose" runat="server" Text="Close" OnClick="btnProfileClose_Click1"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-remove-circle" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnProfilePrint" runat="server" Text="Print" OnClientClick="WindowPrint()"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-print" style="margin-left: -3%; vertical-align: sub;
                                            color: #fff;">
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <%--Clinical Review--%>
                <act:TabPanel ID="TabPnlClinicalReview" runat="server" Font-Size="Large" HeaderText="Clinical Review">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PreviousObstreticsHistory" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton9" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label41" runat="server" Text="Obstretics History"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PreviousObstreticsHistory" runat="server">
                                            <div id="POH" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label42" runat="server" class="margin5">
                                                                            Maternal Blood Group:
                                                                            <asp:DropDownList ID="ddlMaternalBloodGroup" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label43" runat="server" class="margin5">
                                                                            Partners Blood Group:
                                                                            <asp:DropDownList ID="ddlPartnersBloodGroup" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td align="left" style="width: 15%;" colspan="3">
                                                                        <label id="Label44" runat="server" class="margin5">
                                                                            History of Chronic Illness:
                                                                            <div id="div23" class="customdivbordermultiselect">
                                                                                <asp:Panel ID="pnlHistoryChronicIllness" runat="server">
                                                                                </asp:Panel>
                                                                            </div>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 15%;">
                                                                        <label id="Label92" runat="server" align="right">
                                                                            Rhesus Factor :</label>
                                                                        <asp:DropDownList ID="ddlRhesusFactor" runat="server">
                                                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                                                            <asp:ListItem Text="Positive" Value="Positive"></asp:ListItem>
                                                                            <asp:ListItem Text="Negative" Value="Negative"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 26%;">
                                                                        <label id="Label45" runat="server" class="margin5" align="left" style="margin-left: 5px">
                                                                            History of Blood Transfusion:
                                                                            <input id="rdoHistoryBloodTransfusionYes" type="radio" value="Yes" runat="server"
                                                                                name="HistoryBloodTransfusion" />
                                                                            <label for="rdoHistoryBloodTransfusionYes">
                                                                                Yes</label>
                                                                            <input id="rdoHistoryBloodTransfusionNo" type="radio" value="No" runat="server" name="HistoryBloodTransfusion" />
                                                                            <label for="rdoHistoryBloodTransfusionNo">
                                                                                No</label>
                                                                        </label>
                                                                        <div id="divBloodTransfusion" style="display: none">
                                                                            <label for="txtBloodTransfusion">
                                                                                Date
                                                                                <input id="txtBloodTransfusiondt" onblur="DateFormat(this,this.value,event,false,3)"
                                                                                    onkeyup="DateFormat(this,this.value,event,false,3);" onfocus="javascript:vDateType='3'"
                                                                                    maxlength="11" size="11" runat="server" type="text" />
                                                                                </input><img id="Img6" onclick="w_displayDatePicker('<%=txtBloodTransfusiondt.ClientID%>');"
                                                                                    height="22 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="20"
                                                                                    border="0" name="appDateimg" style="vertical-align: text-bottom;" /><span class="smallerlabel"
                                                                                        id="Span6">(DD-MMM-YYYY)</span>
                                                                            </label>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width: 16%;">
                                                                        <label id="Label61" runat="server" align="right">
                                                                            History Of Twins :
                                                                            <input id="rdoHistoryOfTwinsYes" type="radio" value="Yes" runat="server" name="HistoryOfTwins" />
                                                                            <label for="rdoHistoryBloodTransfusionYes">
                                                                                Yes</label>
                                                                            <input id="rdoHistoryOfTwinsNo" type="radio" value="No" runat="server" name="HistoryOfTwins" />
                                                                            <label for="rdoHistoryBloodTransfusionNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                            </table>
                            <%--<table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PresentingComplaints" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton10" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label48" runat="server" Text="Clinicians Review"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PresentingComplaints" runat="server">
                                            <div id="CR" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    
                                                </table>
                                            </div>
                                        </asp:Panel>
                            </table>--%>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PhysicalExaminationFindings" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton11" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label53" runat="server" Text="Physical Examination Findings"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PhysicalExaminationFindings" runat="server">
                                            <div id="PEF" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label54" runat="server" class="margin5">
                                                                            General Appearance:
                                                                            <asp:TextBox ID="txtGeneralAppearance" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label55" runat="server" class="margin5">
                                                                            CVS:
                                                                            <asp:TextBox ID="txtCVS" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label56" runat="server" class="margin5">
                                                                            RS:
                                                                            <asp:TextBox ID="txtRS" runat="server"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label57" runat="server" class="margin20">
                                                                            Breasts:
                                                                            <asp:TextBox ID="txtBreasts" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label58" runat="server" class="margin20">
                                                                            Abdomen:
                                                                            <asp:TextBox ID="txtAbdomen" runat="server"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label59" runat="server" style="margin-right: 13%">
                                                                            Vaginal Examination:
                                                                            <asp:TextBox ID="txtVaginalExamination" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label60" runat="server" class="margin20">
                                                                            Discharge:
                                                                            <asp:TextBox ID="txtdischarge" runat="server"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label46" runat="server" style="margin-left: 7%;">
                                                                            Pallor:
                                                                            <asp:TextBox ID="txtPallor" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label47" runat="server" style="margin-left: 7%;">
                                                                            Maturity:
                                                                            <asp:TextBox ID="txtMaturity" runat="server"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label50" runat="server" style="margin-right: 5%;">
                                                                            Fundal Height:
                                                                            <asp:TextBox ID="txtFundalHeight" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label51" runat="server" style="margin-right: 1%;">
                                                                            Presentation :
                                                                            <asp:TextBox ID="txtPresentation" runat="server"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label52" runat="server" style="margin-right: 10%;">
                                                                            Foetal Heart Rate:
                                                                            <asp:TextBox ID="txtFoetalHeartRate" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label62" runat="server" style="margin-left: 5%;">
                                                                            Oedema :
                                                                            <asp:TextBox ID="txtOedema" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 30%;" align="right">
                                                                        <label id="Label49" runat="server">
                                                                            Presenting complaints:
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 70%;" align="left">
                                                                        <asp:TextBox ID="txtPresentingcomplaints" TextMode="MultiLine" Width="100%" runat="server"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1LabGrid" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton12" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label63" runat="server" Text="Lab Grid"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2LabGrid" runat="server">
                                            <div id="LG" style="display: none; height: 100px">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td>
                                                            <div class="GridView whitebg" style="cursor: pointer;">
                                                                <div class="grid">
                                                                    <div class="rounded">
                                                                        <div class="top-outer">
                                                                            <div class="top-inner">
                                                                                <div class="top">
                                                                                    <h2 align="center">
                                                                                        Latest Lab Results</h2>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="mid-outer">
                                                                            <div class="mid-inner">
                                                                                <div class="mid" style="height: auto; overflow: auto">
                                                                                    <div id="div29" class="GridView whitebg">
                                                                                        <asp:GridView ID="grdLatestResults" runat="server" Width="100%" BorderWidth="0px"
                                                                                            AutoGenerateColumns="False" GridLines="None" CssClass="datatable" CellPadding="0">
                                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
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
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad10 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 100%;" align="center">
                                                                        <asp:Button ID="btnLab" runat="server" Font-Bold="True" Enabled="False" Text="Order Labs"
                                                                            OnClick="btnLab_Click" CssClass="btn btn-primary" Height="30px" Width="13%" Style="text-align: left;" />
                                                                        <label class="glyphicon glyphicon-open" style="margin-left: -3%; vertical-align: sub;
                                                                            color: #fff;">
                                                                        </label>
                                                                        <br />
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
                                        <asp:Panel ID="pnl1DiagnosisandPlan" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton13" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label65" runat="server" Text="Diagnosis and Plan"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2DiagnosisandPlan" runat="server">
                                            <div id="DP" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label66" runat="server" class="margin5">
                                                                            Mother at risk:
                                                                            <input id="rdoMotheratriskyes" type="radio" value="Yes" runat="server" name="Motheratrisk" />
                                                                            <label for="rdoMotheratriskYes">
                                                                                Yes</label>
                                                                            <input id="rdoMotheratriskno" type="radio" value="No" runat="server" name="Motheratrisk" />
                                                                            <label for="rdoMotheratriskNo">
                                                                                No</label>
                                                                        </label>
                                                                        <div id="divriskfactor" style="display: none">
                                                                            <label id="Label64" runat="server" class="margin5">
                                                                                Specify risk factor:
                                                                                <asp:TextBox ID="txtmthrriskfactor" runat="server"></asp:TextBox>
                                                                            </label>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label67" runat="server" class="margin5">
                                                                            Plan:
                                                                            <asp:TextBox ID="txtPlan" runat="server" TextMode="MultiLine" Style="vertical-align: middle"
                                                                                Width="100%"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 40%;">
                                                                        <label id="Label68" runat="server" class="margin5">
                                                                            Appointment Date:
                                                                            <input id="txtAppointmentDate" onblur="DateFormat(this,this.value,event,false,3)"
                                                                                onkeyup="DateFormat(this,this.value,event,false,3);" onfocus="javascript:vDateType='3'"
                                                                                maxlength="11" size="11" runat="server" type="text" />
                                                                            &nbsp;</input><img id="Img4" onclick="w_displayDatePicker('<%=txtAppointmentDate.ClientID%>');"
                                                                                height="22 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                                                                                border="0" name="appDateimg" style="vertical-align: text-bottom;" /><span class="smallerlabel"
                                                                                    id="Span4">(DD-MMM-YYYY)</span>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label69" runat="server" class="margin20">
                                                                            Admitted to ward?
                                                                            <input id="rdoAdmittedtowardyes" type="radio" value="Yes" runat="server" name="Admittedtoward" />
                                                                            &nbsp;</input><label for="rdoAdmittedtowardYes">Yes</label>
                                                                            <input id="rdoAdmittedtowardno" type="radio" value="No" runat="server" name="Admittedtoward" />
                                                                            &nbsp;</input><label for="rdoAdmittedtowardNo">No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label70" runat="server" class="margin20">
                                                                            Specify Ward Admitted:
                                                                            <asp:DropDownList ID="ddlDiagnosisandPlanWardAdmitted" runat="server">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2Pharmacy" runat="server">
                                            <div id="Phrmcy" style="display: inline">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <asp:Button ID="btnPharmacylink" runat="server" Text="Pharmacy" Enabled="False" OnClick="btnPharmacylink_Click"
                                                                CssClass="btn btn-primary" Height="30px" Width="11%" Style="text-align: left;" />
                                                            <label class="glyphicon glyphicon-open" style="margin-left: -3%; vertical-align: sub;
                                                                color: #fff;">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <act:CollapsiblePanelExtender ID="CPEPreviousObstreticsHistory" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PreviousObstreticsHistory"
                            CollapseControlID="pnl1PreviousObstreticsHistory" ExpandControlID="pnl1PreviousObstreticsHistory"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEPreviousObstreticsHistory"></act:CollapsiblePanelExtender>
                        <%-- <act:CollapsiblePanelExtender ID="CPEPresentingComplaints" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PresentingComplaints"
                            CollapseControlID="pnl1PresentingComplaints" ExpandControlID="pnl1PresentingComplaints"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEPresentingComplaints"></act:CollapsiblePanelExtender>--%>
                        <act:CollapsiblePanelExtender ID="CPEPhysicalExaminationFindings" runat="server"
                            SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PhysicalExaminationFindings"
                            CollapseControlID="pnl1PhysicalExaminationFindings" ExpandControlID="pnl1PhysicalExaminationFindings"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEPhysicalExaminationFindings"></act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPELabGrid" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2LabGrid" CollapseControlID="pnl1LabGrid"
                            ExpandControlID="pnl1LabGrid" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" BehaviorID="_content_CPELabGrid"></act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEDiagnosisandPlan" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2DiagnosisandPlan"
                            CollapseControlID="pnl1DiagnosisandPlan" ExpandControlID="pnl1DiagnosisandPlan"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEDiagnosisandPlan"></act:CollapsiblePanelExtender>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="tblClinicalReview"
                                runat="server">
                                <tr id="TrClinicalReview" runat="server" align="center">
                                    <td id="tdclinicalreview" runat="server" class="form">
                                        <asp:Button ID="btnSaveClinicalReview" runat="server" Text="Save" OnClick="btnSaveClinicalReview_Click1"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnCloseClinicalReview" runat="server" Text="Close" OnClick="btnCloseClinicalReview_Click1"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-remove-circle" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnPrintClinicalReview" runat="server" Text="Print" OnClientClick="WindowPrint()"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-print" style="margin-left: -3%; vertical-align: sub;
                                            color: #fff;">
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <%-- PMTCT--%>
                <act:TabPanel ID="TabPnlPMTCT" runat="server" Font-Size="Large" HeaderText="PMTCT">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1ManagementHIVPositiveClientOtherFacility" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton16" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label73" runat="server" Text="Management of Known Positive"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2ManagementHIVPositiveClientOtherFacility" runat="server">
                                            <div id="MHPCOF" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 35%" class="margin5">
                                                                        <label id="Label74" runat="server">
                                                                            Mother currently on ARVs:
                                                                            <input id="rdoMothercurrentlyonARVYes" type="radio" value="Yes" runat="server" name="MothercurrentlyonARV" />
                                                                            <label for="rdoMothercurrentlyonARVYes">
                                                                                Yes</label>
                                                                            <input id="rdoMothercurrentlyonARVNo" type="radio" value="No" runat="server" name="MothercurrentlyonARV" />
                                                                            <label for="rdoMothercurrentlyonARVNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 35%" align="left">
                                                                        <label id="Label75" runat="server">
                                                                            Specify current regimen:
                                                                            <asp:DropDownList ID="ddlSpecifyCurrentRegmn" runat="server" onchange="fnotherCurrentRegimen();">
                                                                            </asp:DropDownList>
                                                                        </label>
                                                                    </td>
                                                                    <td id="tdothercurrentregimen" style="width: 30%; display: none" align="right">
                                                                        <label id="Label72" runat="server">
                                                                            Regimen:
                                                                            <asp:TextBox ID="txtotherregimen" runat="server" Width="35%"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label76" runat="server" class="margin20">
                                                                            Mother currently on cotrimoxazole:
                                                                            <%-- <asp:DropDownList ID="ddlmthroncotrimoxazole" runat="server">
                                                                            </asp:DropDownList>--%>
                                                                            <input id="ddlmthroncotrimoxazoleyes" type="radio" value="Yes" runat="server" name="cotrimoxa" />
                                                                            <label for="ddlmthroncotrimoxazoleyes">
                                                                                Yes</label>
                                                                            <input id="ddlmthroncotrimoxazoleNo" type="radio" value="No" runat="server" name="cotrimoxa" />
                                                                            <label for="ddlmthroncotrimoxazoleNo">
                                                                                No</label>
                                                                        </label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label77" runat="server" class="margin20">
                                                                            Mother currently on multivitamins:
                                                                            <input id="rdoMotherCurrentlyonmultivitaminsyes" type="radio" value="Yes" runat="server"
                                                                                name="MotherCurrentlyonmultivitamins" />
                                                                            <label for="rdoMotherCurrentlymultivitaminsYes">
                                                                                Yes</label>
                                                                            <input id="rdoMotherCurrentlyonmultivitaminsNo" type="radio" value="No" runat="server"
                                                                                name="MotherCurrentlyonmultivitamins" />
                                                                            <label for="rdoMotherCurrentlymultivitaminsNo">
                                                                                No</label>
                                                                        </label>
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
                                        <asp:Panel ID="pnl1Adherence" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton17" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label79" runat="server" Text="Adherence"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2Adherence" runat="server">
                                            <div id="Adhrnc" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label78" runat="server" class="required margin5">
                                                                            Adherence Assessment done:
                                                                            <input id="rdoMotherAdherenceAssessmentdoneYes" type="radio" value="Yes" runat="server"
                                                                                name="MotherAdherenceAssessmentdone" />
                                                                            <label for="rdoMotherAdherenceAssessmentdoneYes">
                                                                                Yes</label>
                                                                            <input id="rdoMotherAdherenceAssessmentdoneNo" type="radio" value="No" runat="server"
                                                                                name="MotherAdherenceAssessmentdone" />
                                                                            <label for="rdoMotherAdherenceAssessmentdoneNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 35%;">
                                                                        <label id="Label80" runat="server" class="margin5">
                                                                            Have you missed any doses:
                                                                            <input id="rdoMissedanydosesYes" type="radio" value="Yes" runat="server" name="Missedanydoses" />
                                                                            <label for="rdoMissedanydosesYes">
                                                                                Yes</label>
                                                                            <input id="rdoMissedanydosesNo" type="radio" value="No" runat="server" name="Missedanydoses" />
                                                                            <label for="rdoMissedanydosesNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr id="trMisseddoses" style="display: none">
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label94" runat="server" class="margin20">
                                                                            Number of doses missed last month:
                                                                            <asp:TextBox ID="txtNoofdosesmissed" runat="server"></asp:TextBox>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label95" runat="server" class="margin20">
                                                                            Reason for missed dose:
                                                                            <div id="div24" class="customdivbordermultiselect">
                                                                                <asp:Panel ID="pnlReasonmissdeddose" runat="server">
                                                                                </asp:Panel>
                                                                            </div>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;" align="left">
                                                                        <label id="Label96" runat="server">
                                                                            Barriers to adherence:
                                                                            <div id="div25" class="customdivbordermultiselect">
                                                                                <asp:Panel ID="pnlBarriertoadherence" runat="server">
                                                                                </asp:Panel>
                                                                            </div>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label97" runat="server" class="margin20">
                                                                            Number of Home visits:
                                                                            <asp:TextBox ID="txtNofHomevisits" runat="server"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label98" runat="server" class="margin20">
                                                                            Prioritise Home Visits:
                                                                            <input id="rdoPrioritiseHomeVisitYes" type="radio" value="Yes" runat="server" name="PrioritiseHomeVisit" />
                                                                            <label for="rdoPrioritiseHomeVisitYes">
                                                                                Yes</label>
                                                                            <input id="rdoPrioritiseHomeVisitNo" type="radio" value="No" runat="server" name="PrioritiseHomeVisit" />
                                                                            <label for="rdoPrioritiseHomeVisitNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label99" runat="server" class="margin20">
                                                                            DOT:
                                                                            <asp:TextBox ID="txtDOT" runat="server"></asp:TextBox>
                                                                        </label>
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
                                        <asp:Panel ID="pnl1Pwp" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton18" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label81" runat="server" Text="PwP"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2Pwp" runat="server">
                                            <div id="PWP" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 40%;">
                                                                        <label id="Label82" runat="server" class="margin5">
                                                                            Have you disclosed your HIV status:
                                                                            <input id="rdodisclosedHIVStatusYes" type="radio" value="Yes" runat="server" name="disclosedyourHIVstatus" />
                                                                            <label for="rdodisclosedyourHIVstatusYes">
                                                                                Yes</label>
                                                                            <input id="rdodisclosedHIVStatusNo" type="radio" value="No" runat="server" name="disclosedyourHIVstatus" />
                                                                            <label for="rdodisclosedyourHIVstatusNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 35%;" align="left">
                                                                        <label id="Label85" runat="server">
                                                                            If yes disclosed HIV Status to:</label>
                                                                        <div id="div26" class="customdivbordermultiselect">
                                                                            <asp:Panel ID="pnlHIVStatus" runat="server">
                                                                            </asp:Panel>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 30%;">
                                                                        <label id="Label83" runat="server" class="margin5">
                                                                            Condoms Issued:
                                                                            <input id="rdoCondomsIssuedYes" type="radio" value="Yes" runat="server" name="CondomsIssued" />
                                                                            <label for="rdoCondomsIssuedYes">
                                                                                Yes</label>
                                                                            <input id="rdoCondomsIssuedNo" type="radio" value="No" runat="server" name="CondomsIssued" />
                                                                            <label for="rdoCondomsIssuedNo">
                                                                                No</label>
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 65%;">
                                                                        <label id="Label84" runat="server" align="left">
                                                                            Additonal Notes:
                                                                            <asp:TextBox ID="txtAdditionalPWPNotes" runat="server" TextMode="MultiLine" Height="150px"
                                                                                Width="90%"></asp:TextBox>
                                                                        </label>
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
                                                                        <label id="Label86" runat="server" class="margin20">
                                                                            PwP Messages given:
                                                                            <input id="rdoPwpMessageGivenYes" type="radio" value="Yes" runat="server" name="PwpMessageGiven" />
                                                                            <label for="rdoPwpMessageGivenYes">
                                                                                Yes</label>
                                                                            <input id="rdoPwpMessageGivenNo" type="radio" value="No" runat="server" name="PwpMessageGiven" />
                                                                            <label for="rdoPwpMessageGivenNo">
                                                                                No</label>
                                                                        </label>
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
                                        <asp:Panel ID="pnl1TreatmentPlan" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton20" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label103" runat="server" Text="Treatment and Plan"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2TreatmentPlan" runat="server">
                                            <div id="TreatP" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 50%;" align="left">
                                                                        <label id="lblARTPreparation" runat="server">
                                                                            ART Preparation (TPS):</label>
                                                                        <div id="div27" class="customdivbordermultiselect">
                                                                            <asp:Panel ID="pnlARTPreparation" runat="server">
                                                                            </asp:Panel>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width: 50%;" align="left">
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
                                                                        <label id="Label104" runat="server" class="required margin5">
                                                                            ARV Regimen:
                                                                        </label>
                                                                        <asp:DropDownList ID="ddlARVRegimen" runat="server">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <label id="Label105" runat="server" class="margin5">
                                                                            Infant NVP issued:</label>
                                                                        <input id="rdoInfantNVPissuedYes" type="radio" value="Yes" runat="server" name="InfantNVPissued" />
                                                                        <label for="rdoInfantNVPissuedYes">
                                                                            Yes</label>
                                                                        <input id="rdoInfantNVPissuedNo" type="radio" value="No" runat="server" name="InfantNVPissued" />
                                                                        <label for="rdoInfantNVPissuedNo">
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
                                                                    <td style="width: 30%;" colspan="2">
                                                                        <label id="Label107" runat="server" class="required margin5">
                                                                            CTX:
                                                                        </label>
                                                                        <asp:DropDownList ID="ddlCTX" runat="server" onchange="fnotherCTXStopreason();">
                                                                        </asp:DropDownList>
                                                                        <div id="divctx" style="display: none">
                                                                            Stop reason:
                                                                            <asp:TextBox ID="txtctxstopreason" runat="server" TextMode="SingleLine"></asp:TextBox>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width: 30%;" align="center">
                                                                        <label id="Label108" runat="server" class="margin20">
                                                                            Other Management:</label>
                                                                        <asp:TextBox ID="txtotherMgmt" runat="server" TextMode="MultiLine" Style="vertical-align: middle;"></asp:TextBox>
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
                                <tr>
                                    <td class="border pad5 whitebg" width="100%">
                                        <table width="100%" border="0">
                                            <tr>
                                                <td style="width: 30%;">
                                                    <label id="Label109" runat="server" class="margin5">
                                                        Appointment Date:
                                                        <input id="txtPMTCTAppDate" onblur="DateFormat(this,this.value,event,false,3)" onkeyup="DateFormat(this,this.value,event,false,3);"
                                                            onfocus="javascript:vDateType='3'" maxlength="11" size="11" runat="server" type="text" />
                                                        <img id="Img5" onclick="w_displayDatePicker('<%=txtPMTCTAppDate.ClientID%>');" height="22 "
                                                            alt="Date Helper" hspace="0" src="../images/cal_icon.gif" width="22" border="0"
                                                            name="appDateimg" style="vertical-align: sub;" /><span class="smallerlabel" id="Span5">(DD-MMM-YYYY)</span>
                                                    </label>
                                                </td>
                                                <td style="width: 25%;">
                                                    <label id="Label110" runat="server" class="margin5">
                                                        Admitted to ward?
                                                        <input id="rdoAdmittedtowardPMTCTYes" type="radio" value="Yes" runat="server" name="AdmittedtowardPMTCT" />
                                                        <label for="rdoAdmittedtowardPMTCTYes">
                                                            Yes</label>
                                                        <input id="rdoAdmittedtowardPMTCTNo" type="radio" value="No" runat="server" name="AdmittedtowardPMTCT" />
                                                        <label for="rdoAdmittedtowardPMTCTNo">
                                                            No</label>
                                                    </label>
                                                </td>
                                                <td style="width: 25%;">
                                                    <label id="Label111" runat="server" class="margin5">
                                                        Specify Ward Admitted?
                                                        <asp:DropDownList ID="ddlWardAdmitted" runat="server">
                                                        </asp:DropDownList>
                                                    </label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1WHOStaging" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton14" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label71" runat="server" Text="WHO Staging"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2WHOStaging" runat="server">
                                            <div id="WS" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <UcWhoStaging:Uc2 ID="UCWHOStage" runat="server" />
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
                                        <asp:Panel ID="Pnl1TBScreening" runat="server" onclick="fnsetCollapseState();" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton19" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label88" runat="server" Text="TB Screening"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="Pnl2TBScreening" runat="server">
                                            <div id="TBS" style="display: none">
                                                <span id="spTbassessment" style="display: none">
                                                    <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td class="border pad5 whitebg">
                                                                <UcTBScreening:Uc1 ID="UCTBScreen" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </span><span id="spttvaccine" style="display: none">
                                                    <table cellspacing="6" cellpadding="0" width="100%" border="0" class="border">
                                                        <tr>
                                                            <td class="pad5 whitebg" style="width: 100%;">
                                                                <label id="Label89" runat="server" class="margin20" style="width: 90%;">
                                                                    Did Client receive tetanus toxoid vaccine?
                                                                    <input id="rdotetanustoxoidyes" type="radio" value="Yes" runat="server" name="tetanustoxoid"
                                                                        onclick="showHideControls();" />
                                                                    <label for="rdotetanustoxoidYes">
                                                                        Yes</label>
                                                                    <input id="rdotetanustoxoidno" type="radio" value="No" runat="server" name="tetanustoxoid"
                                                                        onclick="showHideControls();" />
                                                                    <label for="rdotetanustoxoidNo">
                                                                        No</label>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="pad5 whitebg">
                                                                <asp:DropDownList ID="ddlTTVaccine" runat="server" Style="display: none; width: 28%;
                                                                    margin-left: 31.5%; margin-top: -2%;">
                                                                </asp:DropDownList>
                                                                <textarea id="txtNoTTReason" runat="server" cols="40" rows="1" style="margin-left: 31.5%;
                                                                    margin-top: -2%; display: none;" placeholder="Give reason why TT vaccine wasn't issued"></textarea>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </span>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <%-- <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PMTCTInteventions" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImgBtnPMTCTInteventions" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="LabelPMTCTInteventions" runat="server" Text="PMTCT Interventions"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PMTCTInteventions" runat="server">
                                            <div id="divPMTCTinterventions" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                    
                                                    <%--     <tr>
                                                        <td class="border pad5 whitebg" width="100%">
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 100%;">
                                                                        <label id="Label87" runat="server" class="margin5">
                                                                            Management:
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>--
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>--%>
                            <%--<table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl1PMTCTDiagnosisPlan" runat="server" onclick="fnsetCollapseState();"
                                            CssClass="border center formbg" Style="padding: 6px">
                                            <h5 class="forms" align="left">
                                                <asp:ImageButton ID="ImageButton21" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label106" runat="server" Text="Diagnosis and Plan"></asp:Label></h5>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnl2PMTCTDiagnosisPlan" runat="server">
                                            <div id="PMTCTDP" style="display: none">
                                                <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                                   
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>--%>
                        </div>
                        <act:CollapsiblePanelExtender ID="CPEManagementHIVPositiveClientOtherFacility" runat="server"
                            SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2ManagementHIVPositiveClientOtherFacility"
                            CollapseControlID="pnl1ManagementHIVPositiveClientOtherFacility" ExpandControlID="pnl1ManagementHIVPositiveClientOtherFacility"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEManagementHIVPositiveClientOtherFacility"></act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEAdherence" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2Adherence" CollapseControlID="pnl1Adherence"
                            ExpandControlID="pnl1Adherence" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" BehaviorID="_content_CPEAdherence"></act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEPwp" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2Pwp" CollapseControlID="pnl1Pwp"
                            ExpandControlID="pnl1Pwp" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" BehaviorID="_content_CPEPwp"></act:CollapsiblePanelExtender>
                        <%-- <act:CollapsiblePanelExtender ID="CPEPMTCTInteventions" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PMTCTInteventions"
                            CollapseControlID="pnl1PMTCTInteventions" ExpandControlID="pnl1PMTCTInteventions"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEPMTCTInteventions"></act:CollapsiblePanelExtender>--%>
                        <act:CollapsiblePanelExtender ID="CPETreatmentPlan" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2TreatmentPlan" CollapseControlID="pnl1TreatmentPlan"
                            ExpandControlID="pnl1TreatmentPlan" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" BehaviorID="_content_CPETreatmentPlan"></act:CollapsiblePanelExtender>
                        <%--<act:CollapsiblePanelExtender ID="CPEPMTCTDiagnosisPlan" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2PMTCTDiagnosisPlan"
                            CollapseControlID="pnl1PMTCTDiagnosisPlan" ExpandControlID="pnl1PMTCTDiagnosisPlan"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgPC"
                            BehaviorID="_content_CPEPMTCTDiagnosisPlan"></act:CollapsiblePanelExtender>--%>
                        <act:CollapsiblePanelExtender ID="CPEWHOStaging" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnl2WHOStaging" CollapseControlID="pnl1WHOStaging"
                            ExpandControlID="pnl1WHOStaging" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" BehaviorID="_content_CPEWHOStaging"></act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPETBScreening" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="Pnl2TBScreening" CollapseControlID="Pnl1TBScreening"
                            ExpandControlID="Pnl1TBScreening" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" BehaviorID="_content_CPETBScreening"></act:CollapsiblePanelExtender>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="tblPMTCT" runat="server">
                                <tr id="TrPMTCT" runat="server" align="center">
                                    <td id="tdPMTCT" runat="server" class="form">
                                        <asp:Button ID="btnSavePMTCT" runat="server" Text="Save" OnClick="btnSavePMTCT_Click"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnClosePMTCT" runat="server" Text="Close" OnClick="btnClosePMTCT_Click"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-remove-circle" style="margin-left: -3%; margin-right: 2%;
                                            vertical-align: sub; color: #fff;">
                                        </label>
                                        <asp:Button ID="btnPrintPMTCT" runat="server" Text="Print" OnClientClick="WindowPrint()"
                                            Enabled="False" CssClass="btn btn-primary" Height="30px" Width="8%" Style="text-align: left;" />
                                        <label class="glyphicon glyphicon-print" style="margin-left: -3%; vertical-align: sub;
                                            color: #fff;">
                                        </label>
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
