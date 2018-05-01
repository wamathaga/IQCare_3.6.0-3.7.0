<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmClinical_Nigeria_PeadIE.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_Nigeria_PeadIE" %>

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
                            border="0" name="appDateimg" style="vertical-align: bottom;
                            margin-bottom: 2px;" /><span class="smallerlabel"
                                id="appDatespan1">(DD-MMM-YYYY)</span>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="border formbg">
            <br />
            <act:TabContainer ID="tabControl" runat="server" ActiveTabIndex="0" 
                Width="100%">
                <act:TabPanel ID="TabPanel3" runat="server" Font-Size="Large" HeaderText="Clinical History">
                    <ContentTemplate>
                        <div class="border center formbg">
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
                                                <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="right">
                                                                    <label>
                                                                        Developmental Assessment :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddldevlopAssessment" runat="server" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td align="right">
                                                                    <label>
                                                                        Immunisation: Complete for age :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:RadioButtonList ID="rdoImmunAgryesno" runat="server" RepeatDirection="Horizontal">
                                                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%" cellspacing="6" cellpadding="0" border="0">
                                                            <tr>
                                                                <td align="right">
                                                                    <label>
                                                                        Mode of infant feeding :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddlfeedingMode" runat="server" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <UcCurrentMed:Uc8 ID="UcCurrentMed" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%" cellspacing="6" cellpadding="0" border="0">
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
                                                <asp:Label ID="lblpriorart" runat="server" Text="Prior ART"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlpriorartDetails" runat="server">
                                            <table width="100%">
                                            <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 50%">
                                                                    <label>
                                                                        Patient has received previous care for HIV/AIDS :</label>
                                                                </td>
                                                                <td align="left" style="width: 50%">
                                                                    <asp:RadioButtonList ID="rdopreviousHIV" runat="server" RepeatDirection="Horizontal"
                                                                        OnClick="rblSelectedValue(this,'divshowpriorart')">
                                                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr id="divshowpriorart"  style="display: none;">
                                                    <td align="center" colspan="2" class="border whitebg" style="width: 100%">
                                                        <UcPriorArt:Uc7 ID="UcPriorArt" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="right">
                                                                    <label>
                                                                        Previous ARV exposure other than PMTCT :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddlPrevARVExpoPMTCT" runat="server" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr id="divshowPrevARVExpoPMTCT" style="display: none;">
                                                    <td class="border whitebg" style="width: 100%">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="right" style="width:25%">
                                                                    <label>
                                                                        Specify months :</label>
                                                                </td>
                                                                <td align="left" style="width:25%">
                                                                    <asp:TextBox ID="txtPreExpSpecifyMonths" runat="server" Width="10%"></asp:TextBox>
                                                                </td>
                                                                <td align="right" style="width:25%">
                                                                    <label>
                                                                        Specify drugs :</label>
                                                                </td>
                                                                <td align="left" style="width:25%">
                                                                    <asp:TextBox ID="txtPreExpSpecifyDrugs" runat="server" Width="80%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%" class="border whitebg">
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <UcDrugAllergies:Uc6 id="UCDrugAllergies" runat="server" />
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
                                    <td colspan="2">
                                        <asp:Panel ID="PnlAdherence" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgAdherence" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lbladherence" runat="server" Text="Adherence"></asp:Label></h2>
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
                        </div>
                        <act:CollapsiblePanelExtender ID="CPENigeriaMedical" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlNigeriaMedicalDetails"
                            CollapseControlID="pnlNigeriaMedical" ExpandControlID="pnlNigeriaMedical" CollapsedImage="~/images/arrow-up.gif"
                            Collapsed="True" ImageControlID="imgNigeriaMedical" Enabled="True">
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
                        <br />
                        <div class="border center formbg">
                            <table cellspacing="6" cellpadding="0" width="100%" border="0" id="Table4" runat="server">
                                <tr id="Tr1" runat="server" align="center">
                                    <td id="Td1" runat="server" class="form">
                                        <uc12:UserControlKNH_Signature ID="UserControlKNH_SignatureCH" runat="server" />
                                    </td>
                                </tr>
                                <tr id="Tr2" runat="server" align="center">
                                    <td id="Td2" runat="server" class="form">
                                        <asp:Button ID="btnClinicalHistorySave" runat="server" OnClick="btnClinicalHistorySave_Click"
                                            Text="Save" />                                        
                                        <asp:Button ID="btnClinicalHistoryPrint" runat="server" OnClientClick="WindowPrintAll()"
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
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnlPE" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgPE" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblPhysicalExamination" runat="server" Text="Physical Examination"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlPEDetail" runat="server">
                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td colspan="2" width="100%">
                                            <UcPhysicalExamination:Uc2 ID="UcPE" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="PnlAssessment" CssClass="border center formbg" runat="server" Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="ImgAssessment" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblPnlAssessment" runat="server" Text="Assessment"></asp:Label></h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="PnlAssessmentDetails" runat="server">
                                <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td  width="100%" class="border pad5 whitebg" align="center">
                                            <asp:RadioButtonList ID="rblassessment" runat="server" RepeatDirection="Horizontal">                                                                        
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="100%" class="border pad5 whitebg" align="center">
                                            <table width="100%">
                                                <tr>
                                                    <td align="right" style="width: 50%;">
                                                        <asp:Label ID="lblWHOStage" runat="server" CssClass="required" Font-Bold="True" Text="WHO Stage:"></asp:Label>
                                                    </td>
                                                    <td align="left" style="width: 50%;">
                                                        <asp:DropDownList ID="ddlwhostage1" runat="server" Width="130px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <act:CollapsiblePanelExtender ID="CPEVitalSign" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlVitalSignDetail" CollapseControlID="pnlVitalSign"
                            ExpandControlID="pnlVitalSign" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgVitalSign" Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEPE" runat="server" SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif"
                            TargetControlID="pnlPEDetail" CollapseControlID="pnlPE" ExpandControlID="pnlPE"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="imgPE"
                            Enabled="True">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEPnlAssessment" runat="server" SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif"
                            TargetControlID="PnlAssessmentDetails" CollapseControlID="PnlAssessment" ExpandControlID="PnlAssessment"
                            CollapsedImage="~/images/arrow-up.gif" Collapsed="True" ImageControlID="ImgAssessment"
                            Enabled="True">
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
                            </table>
                            <asp:Panel ID="pnlTreatmentdetail" runat="server" Style="padding: 6px">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <UcTreatment:Uc10 ID="UCTreatment" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <table class="center formbg" cellspacing="6" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:Panel ID="pnlAppointmentsHeader" CssClass="border center formbg" runat="server"
                                            Style="padding: 6px">
                                            <h2 class="forms" align="left">
                                                <asp:ImageButton ID="imgAppointments" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblAppointment" runat="server" Text="Next Appointment"></asp:Label>
                                            </h2>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlAppointmentsBody" runat="server" Style="padding: 6px">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <uc12:UcAppoint ID="UserControlKNH_NextAppointment1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <act:CollapsiblePanelExtender ID="CPETreatment" runat="server" SuppressPostBack="True"
                                ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlTreatmentdetail" CollapseControlID="pnlTreatment"
                                ExpandControlID="pnlTreatment" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                                ImageControlID="imgtreatment" Enabled="True">
                            </act:CollapsiblePanelExtender>
                            <act:CollapsiblePanelExtender ID="CPELAppointment" runat="server" SuppressPostBack="True"
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
