<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmClinical_Nigeria_ARTCareVisitation.aspx.cs" Inherits="PresentationApp.ClinicalForms.frmClinical_Nigeria_ARTCareVisitation" %>

<%@ Register TagPrefix="UcNextAppointment" TagName="UcNxtAppt" Src="~/ClinicalForms/UserControl/UserControlKNH_NextAppointment.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <div style="padding-left: 8px; padding-right: 8px;">
        <script language="javascript" type="text/javascript">

            function WindowPrint() {
                window.print();
            }

            function fnPageOpen(pageopen) {
                if (pageopen == "Pharmacy") {
                    window.open('../PharmacyDispense/frmPharmacyDispense_PatientOrder.aspx?opento=ArtForm');
                }
                else if (pageopen == "Labratory") {
                    window.open('../Laboratory/frm_Laboratory.aspx?opento=ArtForm');
                }
                else if (pageopen == "LabTest") {
                    window.open('../Laboratory/frm_Laboratory.aspx?opento=ArtForm');
                }
            }

            function fnfamilyplanning() {
                var e = document.getElementById("<%=ddlFamilyPanningStatus.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "Select") {
                    hide('divFamilyPlanningMethod');
                }
                else if (strtext == "ONFP=on Family Planning") {
                    show('divFamilyPlanningMethod');
                }
                else { hide('divFamilyPlanningMethod'); }
            }

            function fnARVDrug() {
                var e = document.getElementById("<%=ddlarvdrugadhere.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "Select") {
                    hide('divARVAdherence');
                }
                else if (strtext == "Fair" || strtext == "Poor") {
                    show('divARVAdherence');
                }
                else { hide('divARVAdherence'); }
            }

            function fnCotrimoxale() {
                var e = document.getElementById("<%=ddlCotrimoxazoleAdhere.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "Select") {
                    hide('divCotrimoxazole');
                }
                else if (strtext == "Fair" || strtext == "Poor") {
                    show('divCotrimoxazole');
                }
                else { hide('divCotrimoxazole'); }
            }

            function fnINH() {
                var e = document.getElementById("<%=DDLINH.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "Select") {
                    hide('divINH');
                }
                else if (strtext == "Fair" || strtext == "Poor") {
                    show('divINH');
                }
                else { hide('divINH'); }
            }

            function fnSubsituations() {
                var e = document.getElementById("<%=ddlsubsituationInterruption.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "Change regimen") {
                    show('arvTherapyChange');
                    hide('arvTherapyStop');

                }
                else if (strtext == "Stop treatment") {
                    show('arvTherapyStop');
                    hide('arvTherapyChange');
                }
                else {
                    hide('arvTherapyChange');
                    hide('arvTherapyStop');
                }
            }

            function fnRegimenChange() {
                var e = document.getElementById("<%=ddlArvTherapyChangeCode.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "10=Other reasons(specify)") {
                    show('otherarvTherapyChangeCode');

                }
                else {
                    hide('otherarvTherapyChangeCode');
                }
            }

            function fnStopReason() {
                var e = document.getElementById("<%=ddlArvTherapyStopCode.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "10=Other reasons(specify)") {
                    show('otherarvTherapyStopCode');

                }
                else {
                    hide('otherarvTherapyStopCode');
                }
            }

            function CalculateBMI(txtBMI, txtWeight, txtHeight) {
                var weight = document.getElementById(txtWeight).value;
                var height = document.getElementById(txtHeight).value;
                if (weight == "" || height == "") {
                    weight = 0;
                    height = 0;
                }

                weight = parseFloat(weight);
                height = parseFloat(height);

                var BMI = weight / ((height / 100) * (height / 100));
                BMI = BMI.toFixed(2);
                document.getElementById(txtBMI).value = BMI;
            }

            function fnTBStatus() {
                var e = document.getElementById("<%=ddlTBStatus.ClientID%>");
                var strtext = e.options[e.selectedIndex].text;
                if (strtext == "Select") {
                    hide('tbCardNo');
                    document.getElementById("<%=txtTBCardNo.ClientID %>").value = "";
                }
                else if (strtext == "4=TB Rx") {
                    show('tbCardNo');
                }
                else {
                    hide('tbCardNo');
                    document.getElementById("<%=txtTBCardNo.ClientID %>").value = "";
                }
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

            function GetCheckboxId(Id) {
                var searchEles = document.getElementById("<%=PnlNotedSideEffects.ClientID %>").children;
                for (var i = 0; i < searchEles.length; i++) {
                    if (searchEles[i].children.length > 0) {
                        for (var ii = 0; ii < searchEles[i].children.length; ii++) {
                            if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].textContent == "12=None" && searchEles[i].children[ii].htmlFor == Id) {
                                checkNone(searchEles, Id);
                            }
                            else if (searchEles[i].children[ii].tagName == 'LABEL' && searchEles[i].children[ii].htmlFor == Id) {
                                checkNotNone(searchEles, Id);
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
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad5 whitebg" align="center">
                            <label class="required left" id="lblVisitDate" runat="server">
                                Visit Date:</label>
                            <asp:TextBox ID="txtVisitDate" MaxLength="11" Columns="8" runat="server"></asp:TextBox>
                            <img height="22" alt="Date Helper" onclick="w_displayDatePicker('<%=txtVisitDate.ClientID%>');"
                                hspace="5" src="../images/cal_icon.gif" width="22" border="0" style="vertical-align: bottom;
                                margin-bottom: 2px;" />
                            <span class="smallerlabel">(DD-MMM-YYYY)</span>
                            <label class="margin80">
                                If Scheduled:</label>
                            <input id="chkifschedule" type="checkbox" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" align="center">
                            <label class="center">
                                Duration Since:</label>
                            <strong>ART Start </strong>
                            <asp:TextBox ID="txtARTStart" CssClass="margin10" MaxLength="3" Columns="2" runat="server"></asp:TextBox>
                            <span class="smalllabel">Months</span> <strong class="margin50">Starting Current Regimen
                            </strong>
                            <asp:TextBox ID="txtStartingCurrentRegimen" CssClass="margin10" MaxLength="3" Columns="2"
                                runat="server"></asp:TextBox>
                            <span class="smalllabel">Months</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                Clinical Status</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad5 whitebg" colspan="2" width="100%">
                            <table width="100%" border="0">
                                <tr>
                                    <td align="center" style="width: 19%;">
                                        <label id="lblWeight" runat="server">
                                            Weight:</label>
                                        <asp:TextBox ID="txtPhysWeight" runat="server" MaxLength="5" Columns="4"></asp:TextBox>
                                        <span class="smallerlabel">kg</span>
                                    </td>
                                    <td align="center" style="width: 19%;">
                                        <label id="lblHeight" runat="server">
                                            Height:</label>
                                        <asp:TextBox ID="txtPhysHeight" runat="server" MaxLength="3" Columns="4"></asp:TextBox>
                                        <span class="smallerlabel">cm</span>
                                    </td>
                                    <td align="center" style="width: 19%;">
                                        <label id="lblBmi" runat="server">
                                            BMI:</label>
                                        <asp:TextBox ID="txtBMI" runat="server" MaxLength="6" Columns="4" ReadOnly="true"></asp:TextBox>
                                    </td>
                                    <td align="center" style="width: 24%;" runat="server">
                                        <label>
                                            BP:</label>
                                        <asp:TextBox ID="txtBPSystolic" runat="server" MaxLength="3" Columns="4" Enabled="false"></asp:TextBox>
                                        <label>
                                            /</label>
                                        <asp:TextBox ID="txtBPDiastolic" runat="server" MaxLength="3" Columns="4"></asp:TextBox>
                                        <span class="smallerlabel">(mm/Hg)</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="trPregnant" visible="false" runat="server">
                        <td class="border pad5 whitebg" colspan="2" width="100%">
                            <table width="100%" border="0">
                                <tr>
                                    <td align="left" style="width: 40%;">
                                        <label id="Label1" runat="server">
                                            Pregnant:</label>
                                        <input type="radio" id="PregnantYes" name="GrpPregnant" runat="server" /><label>Yes</label>
                                        <input type="radio" id="PregnantNo" name="GrpPregnant" value="No" runat="server" /><label>No</label>
                                        <input type="radio" id="PregnantUnknown" name="GrpPregnant" value="Unknown" runat="server" /><label>Unknown</label>
                                    </td>
                                    <td align="left" style="width: 30%;">
                                        <label id="Label4" class="margin10" for="EDD">
                                            EDD:</label>
                                        <input id="txtEDD" runat="server" maxlength="11" size="11" />
                                        <img id="img5" onclick="w_displayDatePicker('<%=txtEDD.ClientID%>');" height="22"
                                            alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22" border="0"
                                            style="vertical-align: bottom; margin-bottom: 2px;" />
                                        <span class="smallerlabel">(DD-MMM-YYYY)</span>
                                    </td>
                                    <td align="left" style="width: 30%;">
                                        <label id="Label5" class="margin20" runat="server">
                                            onPMTCT:</label>
                                        <asp:CheckBox ID="ChkonPMTCT" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad10 whitebg" colspan="2" width="100%" valign="top" align="left"
                            id="tdFamilyPlanning" runat="server" visible="false">
                            <table width="100%" border="0">
                                <tr align="left">
                                    <td style="width: 100%;">
                                        <label class="margin20" id="lblFP" runat="server">
                                            Family Planning:</label>
                                        <asp:DropDownList ID="ddlFamilyPanningStatus" onchange="fnfamilyplanning();" runat="server">
                                        </asp:DropDownList>
                                        <div class="divborder checkbox" id="divFamilyPlanningMethod" style="display: none">
                                            <asp:Panel ID="PnlFamilyPlanningMethod" runat="server">
                                            </asp:Panel>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" colspan="2" width="100%">
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <label class="margin20" id="lblFS" runat="server">
                                            Functional Status:</label>
                                        <asp:DropDownList ID="ddlFunctionalStatus" onchange="fnfamilyplanning();" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <label id="lblWHOStage" class="margin20" runat="server">
                                            WHO Clinical Stage:</label>
                                        <asp:DropDownList ID="DDLWHOStage" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" colspan="2" width="100%">
                            <table width="100%" border="0">
                                <tr>
                                    <td width="100%">
                                        <table width="100%" border="0">
                                            <tr align="center">
                                                <td align="center">
                                                    <label id="lblTBStatus" runat="server">
                                                        TB Status:</label>
                                                    <asp:DropDownList ID="ddlTBStatus" onchange="fnTBStatus();" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <span id="tbCardNo" style="display: none">
                                                        <label id="lblTBCardNo" runat="server">
                                                            TB Card No:</label>
                                                        <input id="txtTBCardNo" runat="server" maxlength="11" size="11" />
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" colspan="2" width="100%" style="height: 35px">
                            <table width="100%" border="0">
                                <tr>
                                    <td class="border pad10 whitebg" align="left" width="50%" valign="top">
                                        <label class="margin20">
                                            Other OIs/Other Problems:</label>
                                        <br />
                                        <div id="divPotentialSideEffect" class="divborder margin10" style="margin-top: 10;
                                            margin-bottom: 10">
                                            <asp:Panel ID="PnlOIsOtherProblems" runat="server">
                                            </asp:Panel>
                                        </div>
                                    </td>
                                    <td class="border pad10 whitebg" width="50%" align="left" valign="top">
                                        <label class="margin20">
                                            Noted Side Effects:</label>
                                        <br />
                                        <div class="divborder margin20" style="margin-top: 10; margin-bottom: 10">
                                            <asp:Panel ID="PnlNotedSideEffects" runat="server">
                                            </asp:Panel>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <table cellspacing="2" cellpadding="0" width="100%" border="0">
                <tr>
                    <td style="width: 50%;">
                        <h2 id="H1" class="forms" align="left">
                            Pharmacy</h2>
                    </td>
                    <td style="width: 50%;">
                        <label class="margin10">
                            Use pharmacy form for INH dispensing and other medications dispensed.
                        </label>
                    </td>
                </tr>
            </table>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad10 whitebg" colspan="2" width="100%" valign="top" align="left"
                            id="td1" runat="server">
                            <table width="100%" border="0">
                                <tr align="left">
                                    <td style="width: 100%;" align="left">
                                        <label class="margin10" id="lblARVDrugs" runat="server">
                                            ARV Drugs
                                        </label>
                                        <label class="margin10">
                                            Adherence:
                                        </label>
                                        <asp:DropDownList ID="ddlarvdrugadhere" onchange="fnARVDrug();" runat="server">
                                        </asp:DropDownList>
                                        <div id="divARVAdherence" style="display: none">
                                            <br />
                                            <br />
                                            <label class="margin10">
                                                Why Poor/Fair
                                            </label>
                                            <br />
                                            <div class="divborder checkbox">
                                                <asp:Panel ID="PnlARVwhypoorfair" runat="server">
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad10 whitebg" colspan="2" width="100%" valign="top" align="left"
                            id="td2" runat="server">
                            <table width="100%" border="0">
                                <tr align="left">
                                    <td style="width: 100%;" align="left">
                                        <label class="margin10" id="lblCotrimoxazole" runat="server">
                                            Cotrimoxazole
                                        </label>
                                        <label class="margin10">
                                            Adherence:
                                        </label>
                                        <asp:DropDownList ID="ddlCotrimoxazoleAdhere" onchange="fnCotrimoxale();" runat="server">
                                        </asp:DropDownList>
                                        <div id="divCotrimoxazole" style="display: none">
                                            <br />
                                            <br />
                                            <label class="margin10">
                                                Why Poor/Fair
                                            </label>
                                            <br />
                                            <div class="divborder checkbox">
                                                <asp:Panel ID="PnlCotrimoxazolewhypoorfair" runat="server">
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad10 whitebg" colspan="2" width="100%" valign="top" align="left"
                            id="td3" runat="server">
                            <table width="100%" border="0">
                                <tr align="left">
                                    <td style="width: 100%;" align="left">
                                        <label class="margin10" id="lblINH" runat="server">
                                            INH
                                        </label>
                                        <label class="margin10">
                                            Adherence:
                                        </label>
                                        <asp:DropDownList ID="DDLINH" onchange="fnINH();" runat="server">
                                        </asp:DropDownList>
                                        <div id="divINH" style="display: none">
                                            <br />
                                            <br />
                                            <label class="margin10">
                                                Why Poor/Fair
                                            </label>
                                            <div class="divborder checkbox">
                                                <asp:Panel ID="PnlINHWhyPoorFair" runat="server">
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" colspan="2" width="100%" valign="top" align="left">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr align="left">
                                    <td style="width: 30%; display: inline" align="left">
                                        <label class="required margin10">
                                            Substitutions/Interruptions:
                                        </label>
                                        <asp:DropDownList ID="ddlsubsituationInterruption" onchange="fnSubsituations();"
                                            runat="server">
                                        </asp:DropDownList>
                                        <div id="arvTherapyChange" style="display: none">
                                            <label class="required margin10">
                                                Change Regimen Reason:</label>
                                            <asp:DropDownList ID="ddlArvTherapyChangeCode" onchange="fnRegimenChange();" runat="server">
                                            </asp:DropDownList>
                                            <div id="otherarvTherapyChangeCode" style="display: none">
                                                <label class="required margin10" for="arvTherapyChangeCodeOtherName">
                                                    Specify:</label>
                                                <input id="txtarvTherapyChangeCodeOtherName" maxlength="20" size="10" name="arvTherapyChangeCodeOtherName"
                                                    runat="server" /></div>
                                        </div>
                                        <div id="arvTherapyStop" style="display: none">
                                            <label id="lblrARTdate" class="required margin10">
                                                Date ART Ended:</label>
                                            <input id="txtARTEndeddate" runat="server" maxlength="11" size="10" name="txtARTEndeddate" />
                                            <img id="imgdate" onclick="w_displayDatePicker('<%=txtARTEndeddate.ClientID%>');"
                                                height="22" alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22"
                                                border="0" style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel">(DD-MMM-YYYY)</span>
                                            <br />
                                            <br />
                                            <label class="required margin10">
                                                Stop Regimen Reason:</label>
                                            <asp:DropDownList ID="ddlArvTherapyStopCode" onchange="fnStopReason();" runat="server">
                                            </asp:DropDownList>
                                            <div id="otherarvTherapyStopCode" style="display: none">
                                                <label class="required margin10" for="arvTherapyStopCodeOtherName">
                                                    Specify:</label>
                                                <input id="txtarvTherapyStopCodeOtherName" maxlength="20" size="10" name="arvTherapyStopCodeOtherName"
                                                    runat="server" /></div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg center" colspan="2" width="100%">
                            <div id="divAdultPharmacy" runat="server">
                                <asp:Button ID="btnpharmacy" Text="Prescribe Drugs" runat="server" OnClick="btnpharmacy_Click">
                                </asp:Button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <table cellspacing="2" cellpadding="0" width="100%" border="0">
                <tr>
                    <td style="width: 50%;">
                        <h2 id="H2" class="forms" align="left">
                            Laboratory Investigations</h2>
                    </td>
                    <td style="width: 50%;">
                        <label class="margin10">
                            Use lab order test button to order labs and document results.
                        </label>
                    </td>
                </tr>
            </table>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad5 whitebg formcenter" align="center" colspan="2">
                            <div id="divLaboratory" runat="server">
                                <asp:Button ID="btnLabratory" Text="Laboratory" runat="server" OnClick="btnLabratory_Click" />
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 id="H3" class="forms" align="left">
                Referrals and Consultations</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border pad10 whitebg" valign="top" width="50%" align="left">
                            <label class="margin20">
                                Referred To:
                            </label>
                            <div class="divborder margin20" style="margin-top: 10; margin-bottom: 10">
                                <div>
                                    <asp:Panel ID="PnlReferredTo" runat="server">
                                    </asp:Panel>
                                </div>
                            </div>
                        </td>
                        <td class="border pad5 whitebg" align="center">
                            <label id="Label17" class="margin15">
                                # of Days Hospitalized:</label>
                            <asp:TextBox ID="txtNumOfDaysHospitalized" runat="server" MaxLength="4" Columns="4"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="border pad5 whitebg" align="center" width="50%">
                            <UcNextAppointment:UcNxtAppt ID="UserControlKNH_NextAppointment" runat="server" />
                        </td>
                        <td class="border pad5 whitebg" width="50%" align="center">
                            <label class="margin10">
                                Signature:</label>
                            <asp:DropDownList ID="DDSignature" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="pad5 center whitebg border" colspan="2">
                            <br />
                            <asp:Button ID="btnSave" Text="Save" runat="server" OnClick="btnSave_Click" />
                            <asp:Button ID="btnDataQualityCheck" Text="Data Quality check" runat="server" OnClick="btnDataQualityCheck_Click" />
                            <asp:Button ID="btnClose" Text="Close" runat="server" OnClick="btnClose_Click" />
                            <asp:Button ID="btnPrint" Text="Print" runat="server" OnClientClick="WindowPrint()" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
    </div>
</asp:Content>
