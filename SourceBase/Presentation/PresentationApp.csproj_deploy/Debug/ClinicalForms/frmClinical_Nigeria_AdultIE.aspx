<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmClinical_Nigeria_AdultIE.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_Nigeria_AdultIE" %>

<%@ Register TagPrefix="UcVitalSign" TagName="Uc1" Src="~/ClinicalForms/UserControl/UserControlNigeria_VitalSigns.ascx" %>
<%@ Register TagPrefix="UcPhysicalExamination" TagName="Uc2" Src="~/ClinicalForms/UserControl/UserControlNigeria_PhysicalExamination.ascx" %>
<%@ Register TagPrefix="UcPresentingComplaints" TagName="Uc3" Src="~/ClinicalForms/UserControl/UserControlKNHPresentingComplaints.ascx" %>
<%@ Register TagPrefix="UcNigeriaMedicalHistory" TagName="Uc4" Src="~/ClinicalForms/UserControl/UserControl_NigeriaMedicalHistory.ascx" %>
<%@ Register TagPrefix="UcWhoStaging" TagName="Uc5" Src="~/ClinicalForms/UserControl/UserControlNigeria_WHOStaging.ascx" %>
<%@ Register TagPrefix="UcDrugAllergies" TagName="Uc6" Src="~/ClinicalForms/UserControl/UserControlKNH_DrugAllergies.ascx" %>
<%@ Register TagPrefix="UcPriorArt" TagName="Uc7" Src="~/ClinicalForms/UserControl/UserControl_NigeriaPriorART.ascx" %>
<%@ Register TagPrefix="UcCurrentMed" TagName="Uc8" Src="~/ClinicalForms/UserControl/UserControl_NigeriaCurrentMedication.ascx" %>
<%@ Register TagPrefix="UcAdherence" TagName="Uc9" Src="~/ClinicalForms/UserControl/UserControl_NigeriaAdherence.ascx" %>
<%@ Register TagPrefix="UcTreatment" TagName="Uc10" Src="~/ClinicalForms/UserControl/UserControl_NigeriaTreatmentPlan.ascx" %>
<%@ Register Src="~/ClinicalForms/UserControl/UserControlKNH_LabEvaluation.ascx"
    TagName="Uclabeval" TagPrefix="uc11" %>
<%@ Register Src="~/ClinicalForms/UserControl/UserControlKNH_NextAppointment.ascx"
    TagName="UcAppoint" TagPrefix="uc12" %>
<%@ Register Src="~/ClinicalForms/UserControl/UserControlKNH_Signature.ascx" TagName="UserControlKNH_Signature"
    TagPrefix="uc12" %>
<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script type="text/javascript" language="javascript">
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
        function ShowMore(sender, eventArgs) {
            var substr = eventArgs._commandArgument.toString().split('|')
            ShowHide(substr[0], substr[1]);
        }

        function rblSelectedValue(rbl, divID) {
            var selectedvalue = $("#" + rbl.id + " input:radio:checked").val();
            if (selectedvalue == "1") {
                YN = "show";
            }
            else {
                YN = "hide";
            }
            ShowHide(divID, YN);
        }

        function rblSelectedValueNo(rbl, divID) {
            var selectedvalue = $("#" + rbl.id + " input:radio:checked").val();
            if (selectedvalue == "0") {
                YN = "show";
            }
            else {
                YN = "hide";
            }
            ShowHide(divID, YN);
        }
        //Checkbox list
        function getCheckBoxValue(DivId, chktext, str) {
            var YN = "";
            var id = "#" + CheckBoxID;
            if ($(id).is(':checked')) {
                YN = "show";
            }
            else {
                YN = "hide";
            }
            ShowHide(CheckBoxID, YN);
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
        function CheckBoxToggleShowHideKNHAdultIE(divID, val, txt) {
            var checkList = document.getElementById(val);
            var checkBoxList = checkList.getElementsByTagName("input");
            var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
            var checkBoxSelectedItems = new Array();
            for (var i = 0; i < checkBoxList.length; i++) {

                if (checkBoxList[i].checked) {
                    if (arrayOfCheckBoxLabels[i].innerText.trim() == txt) {
                        ShowHide(divID, "show");
                        break;
                    }
                }
                else {
                    if (arrayOfCheckBoxLabels[i].innerText == txt) {
                        ShowHide(divID, "hide");
                    }

                }
            }

        }
        function WindowPrintAll() {
            window.print();
        }
        function fnUncheckall(strcblcontrolId) {
            var checkList = document.getElementById(strcblcontrolId);
            var checkBoxList = checkList.getElementsByTagName("input");
            var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
            var checkBoxSelectedItems = new Array();

            for (var i = 1; i < checkBoxList.length; i++) {
                checkBoxList[i].checked = false;
            }
        }
        function fnUncheckNormal(strcblcontrolId) {
            var checkList = document.getElementById(strcblcontrolId);
            var checkBoxList = checkList.getElementsByTagName("input");
            var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
            var checkBoxSelectedItems = new Array();
            checkBoxList[0].checked = false;

        }
        function checkNone(searchEles, Id_None) {
            for (var i = 0; i < searchEles.length; i++) {
                if (searchEles[i].children.length > 0) {
                    for (var ii = 0; ii < searchEles[i].children.length; ii++) {
                        if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].htmlFor != Id_None) {
                            document.getElementById(searchEles[i].children[ii].htmlFor).checked = false;
                        }
                    }
                }
            }
        }
        function checkNotNone(searchEles, Id_None) {
            for (var i = 0; i < searchEles.length; i++) {
                if (searchEles[i].children.length > 0) {
                    for (var ii = 0; ii < searchEles[i].children.length; ii++) {
                        if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].textContent == "12=None") {
                            document.getElementById(searchEles[i].children[ii].htmlFor).checked = false;
                        }
                    }
                }
            }
        }



        function ShowPnlforOther(param, shwpnl) {
            var searchpnl = document.getElementById(param).children;
            var chkboxId = "";
            for (var i = 0; i < searchpnl.length; i++) {
                var insidei = searchpnl[i].children;
                for (var j = 0; j < insidei.length - 1; j++) {
                    var insidej = insidei[j].children;
                    for (var k = 0; k < insidej.length; k++) {
                        if (insidej[k].type == "checkbox")
                            chkboxId = insidej[k].id;
                    }
                }
            }

            if (document.getElementById(chkboxId).checked == true)
                show(shwpnl);

        }
    </script>
    <div style="padding-left: 8px; padding-right: 8px; padding-top: 2px;">
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tr>
                    <td class="form" align="center">
                        <label class="required">
                            *Visit date:
                        </label>
                        <input id="txtVisitDate" onblur="DateFormat(this,this.value,event,false,3)" onkeyup="DateFormat(this,this.value,event,false,3);"
                            onfocus="javascript:vDateType='3'" maxlength="11" size="11" runat="server" type="text" />
                        <img id="appDateimg1" onclick="w_displayDatePicker('<%=txtVisitDate.ClientID%>');"
                            height="22 " alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                            border="0" name="appDateimg" style="vertical-align: bottom; margin-bottom: 2px;" /><span
                                class="smallerlabel" id="appDatespan1">(DD-MMM-YYYY)</span>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="border formbg">
            <br />
            <act:TabContainer ID="tabControl" runat="server" ActiveTabIndex="0" Width="100%">
                <act:TabPanel ID="TabPanel3" runat="server" Font-Size="Large" HeaderText="Clinical History">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlPComp" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImgPC" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblPresComp" runat="server" Text="Presenting Complaints"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <asp:Panel ID="pnlTPComp" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcPresentingComplaints:Uc3 ID="UcPc" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlNigeriaMedical" runat="server" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgNigeriaMedical" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblNigeriaMedical" runat="server" Text="Medical History"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlNigeriaMedicalDetails" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcNigeriaMedicalHistory:Uc4 ID="idNigeriaMedical" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table id="TabManagement" class="center formbg" width="100%" border="0">
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:Panel ID="pnlDAToxities" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgDAToxities" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                Drug Allergies</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlDAToxitiesDetail" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcDrugAllergies:Uc6 ID="UCDrugAllergies" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlriskfactors" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="Imgriskfactors" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblriskfactors" runat="server" Text="Risk Factors"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlriskfactorsDetail" runat="server">
                                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td width="50%" class="form" align="left">
                                                        <asp:Label ID="lblriskfactorslist" runat="server" Font-Bold="True" Text="Risk Factors"></asp:Label>
                                                        <div class="customdivbordermultiselect">
                                                            <asp:CheckBoxList ID="cblRiskFactors" runat="server">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                        <br />
                                                        <div id="divotherriskfactors" style="display: none">
                                                            <label>
                                                                Other medical conditions :</label>
                                                            <asp:TextBox ID="txtOtherriskfactors" runat="server" Width="60%"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlpregnant" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgpregnant" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblpregnant" runat="server" Text="Pregnancy"></asp:Label>
                                            </h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlpregnantDetail" runat="server">
                                            <table class="border center whitebg" cellspacing="6" cellpadding="0" width="100%"
                                                border="0">
                                                <tr>
                                                    <td style="width: 100%">
                                                        <table width="100%">
                                                            <tr>
                                                                <td style="width: 25%" align="right">
                                                                    <label for="LMP">
                                                                        LMP:</label>
                                                                </td>
                                                                <td style="width: 25%" align="left">
                                                                    <input id="txtLMPdate" maxlength="11" size="11" runat="server" type="text" />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<img
                                                                        onclick="w_displayDatePicker('<%=txtLMPdate.ClientID%>');" height="22" alt="Date Helper"
                                                                        hspace="3" src="../Images/cal_icon.gif" width="22" border="0" />&nbsp;
                                                                </td>
                                                                <td style="width: 25%" align="right">
                                                                    <label id="lblpregnantlabal">
                                                                        Currently pregnant:</label>
                                                                </td>
                                                                <td style="width: 25%" align="left">
                                                                    <asp:RadioButtonList ID="rdopregnantyesno" runat="server" RepeatDirection="Horizontal"
                                                                        OnClick="rblSelectedValue(this,'hideFP')">
                                                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <tr id="hideFP">
                                                        <td style="width: 100%">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="width: 25%" align="right">
                                                                        <label id="Label1" for="EDD">
                                                                            EDD:</label>
                                                                    </td>
                                                                    <td style="width: 25%" align="left">
                                                                        <input id="txtEDDDate" runat="server" maxlength="11" size="11" type="text" />
                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                                                                        <img id="img1" onclick="w_displayDatePicker('<%=txtEDDDate.ClientID%>');" height="22"
                                                                            alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22" border="0"
                                                                            style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel">(DD-MMM-YYYY)</span>
                                                                        </span>
                                                                    </td>
                                                                    <td style="width: 25%" align="right">
                                                                        <label id="lblgestage" for="gestage">
                                                                            Gestational age (wks):</label>
                                                                    </td>
                                                                    <td style="width: 25%" align="left">
                                                                        <asp:TextBox ID="txtgestage" runat="server" Columns="2" MaxLength="3"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <act:CollapsiblePanelExtender ID="CPEHIVCare" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlTPComp" CollapseControlID="pnlPComp"
                            ExpandControlID="pnlPComp" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgPC" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPENigeriaMedical" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlNigeriaMedicalDetails"
                            CollapseControlID="pnlNigeriaMedical" ExpandControlID="pnlNigeriaMedical" CollapsedImage="~/images/arrow-up.gif"
                            Collapsed="True" ImageControlID="imgNigeriaMedical" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEDAT" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlDAToxitiesDetail" CollapseControlID="pnlDAToxities"
                            ExpandControlID="pnlDAToxities" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgDAToxities" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEriskfactors" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlriskfactorsDetail"
                            CollapseControlID="pnlriskfactors" ExpandControlID="pnlriskfactors" CollapsedImage="~/images/arrow-up.gif"
                            Collapsed="True" ImageControlID="imgriskfactors" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEpregnant" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlpregnantDetail" CollapseControlID="pnlpregnant"
                            ExpandControlID="pnlpregnant" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgpregnant" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table4" runat="server">
                                <tr runat="server" align="center">
                                    <td runat="server" class="form">
                                        <uc12:UserControlKNH_Signature ID="UserControlKNH_SignatureCH" runat="server" />
                                    </td>
                                </tr>
                                <tr runat="server" align="center">
                                    <td runat="server" class="form">
                                        <asp:Button ID="btnClinicalHistorySave" runat="server" OnClick="btnClinicalHistorySave_Click"
                                            Text="Save" />
                                        <asp:Button ID="btnClinicalHistoryPrint" runat="server" OnClientClick="WindowPrintAll();"
                                            Text="Print" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <act:TabPanel ID="TabHIVHistory" runat="server" Font-Size="Large" HeaderText="HIV History">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlhivrelhistory" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imghivrelhistory" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblhivrelhistory" runat="server" Text="HIV Related History"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlhivrelhistoryDetails" runat="server">
                                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td style="width: 100%">
                                                        <table width="100%" class="border center pad5 whitebg">
                                                            <tr>
                                                                <td width="25%" align="left">
                                                                    <asp:Label ID="lbllatestCD4" runat="server" Font-Bold="True" Text="Latest CD4:"></asp:Label>
                                                                    <asp:Label ID="lbllatestCD4number" runat="server" Font-Bold="True"></asp:Label>
                                                                </td>
                                                                <td width="25%" align="left">
                                                                    <asp:Label ID="lbllatestCD4count" runat="server" Font-Bold="True" Text="Count:"></asp:Label>
                                                                    <asp:TextBox ID="txtlatestcd4number" runat="server" Columns="2" MaxLength="3"></asp:TextBox>
                                                                </td>
                                                                <td width="30%" align="left">
                                                                    <asp:Label ID="lbllatestcd4date" runat="server" Font-Bold="True" Text="Date:"></asp:Label>
                                                                    <input id="dtlatestcd4date" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                                                        onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,'3')"
                                                                        size="11" type="text" />&nbsp; </input> </input>
                                                                    <img id="Img27" alt="Date Helper" border="0" height="22 " hspace="5" name="appDateimg"
                                                                        onclick="w_displayDatePicker('<%=dtlatestcd4date.ClientID%>');" src="../images/cal_icon.gif"
                                                                        style="vertical-align: text-bottom;" width="22" style="vertical-align: bottom;
                                                                        margin-bottom: 2px;" /><span class="smallerlabel" id="Span27">(DD-MMM-YYYY)</span>
                                                                </td>
                                                                <td width="20%" align="left">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%">
                                                        <table width="100%" class="border center pad5 whitebg">
                                                            <tr>
                                                                <td width="25%" align="left">
                                                                    <asp:Label ID="lbllowestCD4" runat="server" Font-Bold="True" Text="Lowest CD4:"></asp:Label>
                                                                    <asp:Label ID="lbllowestCD4Value" runat="server" Font-Bold="True"></asp:Label>
                                                                </td>
                                                                <td width="25%" align="left">
                                                                    <asp:Label ID="lbllowestCD4Count" runat="server" Font-Bold="True" Text="Count:"></asp:Label>
                                                                    <asp:TextBox ID="txtlowestCD4Count" runat="server" Columns="2" MaxLength="3"></asp:TextBox>
                                                                </td>
                                                                <td width="30%" align="left">
                                                                    <asp:Label ID="lbllowestCD4Date" runat="server" Font-Bold="True" Text="Date:"></asp:Label>
                                                                    <input id="txtlbllowestCD4Date" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                                                        onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,'3')"
                                                                        size="11" type="text" />&nbsp; </input> </input>
                                                                    <img id="Img2" alt="Date Helper" border="0" height="22 " hspace="5" name="appDateimg"
                                                                        onclick="w_displayDatePicker('<%=txtlbllowestCD4Date.ClientID%>');" src="../images/cal_icon.gif"
                                                                        style="vertical-align: text-bottom;" width="22" style="vertical-align: bottom;
                                                                        margin-bottom: 2px;" /><span class="smallerlabel" id="Span1">(DD-MMM-YYYY)</span>
                                                                </td>
                                                                <td width="20%" align="left">
                                                                    <asp:CheckBox runat="server" Text="Lab records seen" ID="chklowestcd4labrecord" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%">
                                                        <table width="100%" class="border center pad5 whitebg">
                                                            <tr>
                                                                <td width="25%" align="left">
                                                                    <asp:Label ID="lbllatestViralLoad" runat="server" Font-Bold="True" Text="Latest ViralLoad:"></asp:Label>
                                                                    <asp:Label ID="lbllatestViralLoadValue" runat="server" Font-Bold="True"></asp:Label>
                                                                </td>
                                                                <td width="25%" align="left">
                                                                    <asp:Label ID="lbllatestViralLoadCount" runat="server" Font-Bold="True" Text="Count:"></asp:Label>
                                                                    <asp:TextBox ID="txtlatestViralLoadCount" runat="server" Columns="2" MaxLength="3"></asp:TextBox>
                                                                </td>
                                                                <td width="30%" align="left">
                                                                    <asp:Label ID="lbllatestViralLoadDate" runat="server" Font-Bold="True" Text="Date:"></asp:Label>
                                                                    <input id="txtlatestViralLoadDate" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                                                        onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,'3')"
                                                                        size="11" type="text" />&nbsp; </input> </input>
                                                                    <img id="Img3" alt="Date Helper" border="0" height="22 " hspace="5" name="appDateimg"
                                                                        onclick="w_displayDatePicker('<%=txtlatestViralLoadDate.ClientID%>');" src="../images/cal_icon.gif"
                                                                        style="vertical-align: text-bottom;" width="22" style="vertical-align: bottom;
                                                                        margin-bottom: 2px;" /><span class="smallerlabel" id="Span2">(DD-MMM-YYYY)</span>
                                                                </td>
                                                                <td width="20%" align="left">
                                                                    <asp:CheckBox runat="server" Text="Lab records seen" ID="chkviralloadlabrecord" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlpriorart" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgpriorart" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label2" runat="server" Text="ARV Exposure"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlpriorartDetails" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcPriorArt:Uc7 ID="UcPriorArt" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcCurrentMed:Uc8 ID="UcCurrentMed" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" class="border whitebg" cellspacing="6" cellpadding="0" width="100%"
                                                border="0">
                                                <tr>
                                                    <td align="right">
                                                        <label>
                                                            Service entry into program :</label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlreferredfrom" runat="server" Width="200px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="PnlAdherence" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgAdherence" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="Label3" runat="server" Text="Adherence"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <asp:Panel ID="PnlAdherenceDetails" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcAdherence:Uc9 ID="UcAdherence" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnlARVSideeffects" CssClass="border center formbg" runat="server"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImgARVSideEffect" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                ARV Side Effects</h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlARVSideEffectDetail" runat="server">
                                            <table width="100%" class="formbg" cellspacing="6" cellpadding="0" border="0">
                                                <tr>
                                                    <td width="50%" class="border pad5 whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    <label>
                                                                        Short term effects:</label>
                                                                    <div id="divShortTermEffects" class="customdivbordermultiselect" style="margin-bottom: 20px">
                                                                        <asp:CheckBoxList ID="cblShortTermEffects" RepeatLayout="Flow" runat="server">
                                                                        </asp:CheckBoxList>
                                                                    </div>
                                                                    <div id="divshorttermeffecttxt" style="display: none">
                                                                        <label>
                                                                            Specify other short term effects:</label>
                                                                        <asp:TextBox ID="txtOtherShortTermEffects" runat="server" Skin="MetroTouch" Width="100%"></asp:TextBox>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="50%" class="border pad5 whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    <label>
                                                                        Long term effects:</label>
                                                                    <div id="divLongTermEffects" class="customdivbordermultiselect" style="margin-bottom: 20px">
                                                                        <asp:CheckBoxList ID="cblLongTermEffects" RepeatLayout="Flow" runat="server">
                                                                        </asp:CheckBoxList>
                                                                    </div>
                                                                    <div id="divlongtermeffecttxt" style="display: none">
                                                                        <label>
                                                                            Specify other long term effects:</label>
                                                                        <asp:TextBox ID="txtOtherLongtermEffects" runat="server" Skin="MetroTouch" Width="100%"></asp:TextBox>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <act:CollapsiblePanelExtender ID="CPEhivrelhistory" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlhivrelhistoryDetails"
                            CollapseControlID="pnlhivrelhistory" ExpandControlID="pnlhivrelhistory" CollapsedImage="~/images/arrow-up.gif"
                            Collapsed="True" ImageControlID="imghivrelhistory" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEpriorart" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlpriorartDetails" CollapseControlID="pnlpriorart"
                            ExpandControlID="pnlpriorart" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgpriorart" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEAdherence" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="PnlAdherenceDetails" CollapseControlID="PnlAdherence"
                            ExpandControlID="PnlAdherence" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgAdherence" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEARVSE" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlARVSideEffectDetail"
                            CollapseControlID="pnlARVSideeffects" ExpandControlID="pnlARVSideeffects" CollapsedImage="~/images/arrow-up.gif"
                            Collapsed="True" ImageControlID="ImgARVSideEffect" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table1" runat="server">
                                <tr runat="server" align="center">
                                    <td runat="server" class="form">
                                        <uc12:UserControlKNH_Signature ID="UserControlKNH_SignatureHH" runat="server" />
                                    </td>
                                </tr>
                                <tr runat="server" align="center">
                                    <td runat="server" class="form">
                                        <asp:Button ID="btnHIVHistorySave" runat="server" Text="Save" OnClick="btnHIVHistorySave_Click" />
                                        <asp:Button ID="btnHIVHistoryPrint" runat="server" OnClientClick="WindowPrintAll();"
                                            Text="Print" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <act:TabPanel ID="TabPanelExamination" runat="server" Font-Size="Large" HeaderText="Examination">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlvitalsign" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgvitalsign" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblVitalSigns" runat="server" Text="Vital Signs"></asp:Label>
                                            </h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlVitalSignDetail" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcVitalSign:Uc1 ID="idVitalSign" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnlPE" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgPE" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblPhysicalExamination" runat="server" Text="Physical Examination"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlPEDetail" runat="server">
                                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td colspan="2" width="100%">
                                                        <UcPhysicalExamination:Uc2 ID="UcPE" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="100%" class="border whitebg">
                                                        <table width="100%">
                                                            <tbody>
                                                                <tr>
                                                                    <td align="left">
                                                                        <label id="Label4" align="center">
                                                                            Assessment :</label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:RadioButtonList ID="rblassessment" runat="server" RepeatDirection="Horizontal">
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="100%" class="border pad5 whitebg">
                                                        <table width="100%">
                                                            <tbody>
                                                                <tr>
                                                                    <td align="left">
                                                                        <label id="lblOther general conditions-8888326" align="center">
                                                                            Assessment Notes :</label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtAssessmentNotes" ClientIDMode="Static" runat="server" Width="99%"
                                                                            Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnlWHOStage" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgWHOStage" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblheadWHOStage" runat="server" Text="WHO Stage"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlWHOStageDetail" runat="server">
                                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td colspan="2" width="100%">
                                                        <UcWhoStaging:Uc5 ID="UcWhostaging" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <act:CollapsiblePanelExtender ID="CPEVitalSign" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlVitalSignDetail" CollapseControlID="pnlVitalSign"
                            ExpandControlID="pnlVitalSign" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgVitalSign" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEPE" runat="server" SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif"
                            TargetControlID="pnlPEDetail" CollapseControlID="pnlPE" ExpandControlID="pnlPE"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgLTM"
                            Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPWHOStage" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlWHOStageDetail" CollapseControlID="pnlWHOStage"
                            ExpandControlID="pnlWHOStage" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="ImgWHOStage" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table2" runat="server">
                                <tbody>
                                    <tr runat="server" align="center">
                                        <td runat="server" class="form">
                                            <uc12:UserControlKNH_Signature ID="UserControlKNH_SignatureExamination" runat="server" />
                                        </td>
                                    </tr>
                                    <tr runat="server" align="center">
                                        <td runat="server" class="form">
                                            <asp:Button ID="btnExaminationSave" runat="server" OnClick="btnExaminationSave_Click"
                                                Text="Save" />
                                            <asp:Button ID="btnExaminationPrint" runat="server" OnClientClick="WindowPrintAll();"
                                                Text="Print" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
                <act:TabPanel ID="Tabmanagement" runat="server" Font-Size="Large" HeaderText="Management">
                    <ContentTemplate>
                        <div class="border center formbg">
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnlTreatment" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgtreatment" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblheadregimenpresc" runat="server" Text="Treatment Plan"></asp:Label>
                                            </h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlTreatmentdetail" runat="server" Style="padding: 6px">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <UcTreatment:Uc10 ID="UCTreatment" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg" width="100%" border="0">
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:Panel ID="pnlAppointmentsHeader" CssClass="border center formbg" runat="server"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgAppointments" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblAppointment" runat="server" Text="Next Appointment"></asp:Label>
                                            </h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlAppointmentsBody" runat="server" Style="padding: 6px">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <uc12:UcAppoint ID="UserControlKNH_NextAppointment1" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <act:CollapsiblePanelExtender ID="CPETreatment" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlTreatmentdetail" CollapseControlID="pnlTreatment"
                                ExpandControlID="pnlTreatment" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imgtreatment" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlAppointmentsBody" CollapseControlID="pnlAppointmentsHeader"
                                ExpandControlID="pnlAppointmentsHeader" CollapsedImage="~/images/arrow-up.gif"
                                Collapsed="True" ImageControlID="imgAppointments" Enabled="True">
                            </act:CollapsiblePanelExtender>
                        </div>
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tbody>
                                    <tr align="center">
                                        <td class="form">
                                            <uc12:UserControlKNH_Signature ID="UserControlKNH_SignatureMgt" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="tblSaveButton" align="center">
                                        <td class="form">
                                            <asp:Button ID="btnSaveMgt" runat="server" Text="Save" OnClick="btnSaveTriage_Click" />
                                            <asp:Button ID="btnPrintMgt" Text="Print" OnClientClick="WindowPrintAll();" runat="server" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </ContentTemplate>
                </act:TabPanel>
            </act:TabContainer>
        </div>
        <br />
        <table class="formbg center border pad5" width="100%">
            <tbody>
                <tr>
                    <td class="form pad5">
                        <asp:Button ID="btnClose" Text="Close" runat="server" OnClick="btnClose_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
