﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControlNigeria_PhysicalExamination.ascx.cs"
    Inherits="PresentationApp.ClinicalForms.UserControl.UserControlNigeria_PhysicalExaminationascx" %>
<script type="text/javascript" language="javascript">
    function ShowHidePE(theDiv, YN, theFocus) {

        $(document).ready(function () {

            if (YN == "show") {
                $("#" + theDiv).slideDown();

            }
            if (YN == "hide") {
                $("#" + theDiv).slideUp();

            }

        });

    }
    function CheckBoxToggle(strcblcontrolId, strdivId, strfieldname) {
        var checkList = document.getElementById(strcblcontrolId);
        var checkBoxList = checkList.getElementsByTagName("input");
        var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
        var checkBoxSelectedItems = new Array();

        for (var i = 0; i < checkBoxList.length; i++) {

            if (checkBoxList[i].checked) {
                if (arrayOfCheckBoxLabels[i].innerText == strfieldname) {
                    ShowHidePE(strdivId, "show");
                }
                else {
                    ShowHidePE(strdivId, "hide");
                }
            }
            else {
                ShowHidePE(strdivId, "hide");
            }
        }



    }
    function fnUncheckall(strcblcontrolId) {

        var checkList = document.getElementById(strcblcontrolId);
        var checkBoxList = checkList.getElementsByTagName("input");
        var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
        var checkBoxSelectedItems = new Array();


        for (var i = 0; i < checkBoxList.length; i++) {
            if ($("label[for='" + checkBoxList[i].id + "']").text() != 'Normal') {
                //alert($("label[for='" + checkBoxList[i].id + "']").text());
                checkBoxList[i].checked = false;
            }

        }
    }
    function fnUncheckNormal(strcblcontrolId) {
        var checkList = document.getElementById(strcblcontrolId);
        var checkBoxList = checkList.getElementsByTagName("input");
        var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
        var checkBoxSelectedItems = new Array();
        for (var i = 0; i < checkBoxList.length; i++) {
            if ($("label[for='" + checkBoxList[i].id + "']").text() == 'Normal') {
                checkBoxList[i].checked = false;
            }

        }

    }
    function CheckBoxToggleShowHidePE(val, divID, txt, txtControlId) {
        var checkList = document.getElementById(val);
        var checkBoxList = checkList.getElementsByTagName("input");
        var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
        var checkBoxSelectedItems = new Array();
        var arrayOfCheckBoxLabelsnew;
        for (var i = 0; i < checkBoxList.length; i++) {
            if (checkBoxList[i].checked) {
                if ($("label[for='" + checkBoxList[i].id + "']").text() == txt) {
                    ShowHidePE(divID, "show");
                }

            }
            else {
                if ($("label[for='" + checkBoxList[i].id + "']").text() == txt) {
                    document.getElementById(txtControlId).value = '';
                    ShowHidePE(divID, "hide");
                }

            }
        }



    }




    function togglePhyExamPC(strcblcontrolId) {
        var GV = document.getElementById(strcblcontrolId);

        if (GV.children.length > 0) {
            for (var i = 0; i < GV.children.length; i++) {
                var inputs = GV.children[i].tagName;

                if (inputs == "INPUT" && GV.children[i].checked == true && GV.children[i].labels[0].innerText == "NSF") {
                    for (var j = 0; j < GV.children.length; j++) {
                        var inputsinner = GV.children[j].tagName;
                        if (inputsinner == "INPUT" && GV.children[j].labels[0].innerText != "NSF") {
                            GV.children[j].checked = false;
                            GV.children[j].disabled = true;
                        }
                    }

                }
                else if (inputs == "INPUT" && GV.children[i].checked == false && GV.children[i].labels[0].innerText == "NSF") {
                    for (var j = 0; j < GV.children.length; j++) {
                        var inputsinner = GV.children[j].tagName;
                        if (inputsinner == "INPUT" && GV.children[j].labels[0].innerText != "NSF") {
                            GV.children[j].disabled = false;
                        }
                    }

                }

                else if (inputs == "INPUT" && GV.children[i].checked == true && GV.children[i].labels[0].innerText != "NSF") {
                    for (var j = 0; j < GV.children.length; j++) {
                        var inputsinner = GV.children[j].tagName;
                        if (inputsinner == "INPUT" && GV.children[j].labels[0].innerText == "NSF") {
                            GV.children[j].checked = false;
                            GV.children[j].disabled = true;
                        }
                    }

                }

                else if (inputs == "INPUT" && GV.children[i].checked == false && GV.children[i].labels[0].innerText != "NSF") {
                    for (var j = 0; j < GV.children.length; j++) {
                        var inputsinner = GV.children[j].tagName;
                        if (inputsinner == "INPUT" && GV.children[j].labels[0].innerText == "NSF") {
                            GV.children[j].disabled = false;
                        }
                    }

                }


                //                if ((inputs[i].checked == true) && (lbl[i].innerText == "NSF")) {
                //                    for (var j = 1; j < GV.children.length; j++) {
                //                        var inputsinner = GV.children[j].getElementsByTagName('input');
                //                        var lblinner = GV.children[j].getElementsByTagName('label');
                //                        if (lblinner[j].innerText != "NSF") {
                //                            inputsinner[j].checked = false;
                //                            inputsinner[j].disabled = true;
                //                        }
                //                    }
                //                }
                //                else if ((inputs[i].checked == false) && (lbl[i].innerText == "NSF")) {
                //                    for (var k = 1; k < GV.children.length.length; k++) {
                //                        var inputsinnerouter = GV.children[i].getElementsByTagName('input');
                //                        var lblinnerouter = GV.children[i].getElementsByTagName('label');
                //                        if (lblinnerouter[k].innerText != "NSF") {
                //                            inputsinnerouter[k].checked = false;
                //                            inputsinnerouter[k].disabled = false;
                //                        }
                //                    }
                //                }
                //            }
                //        }
                //        else if ((inputList[0].checked == true) && (arrayOfCheckBoxLabels[0].innerText != "NSF")) {

                //            if (GV.childNodes.length > 0) {
                //                for (var i = 1; i < GV.childNodes.length; i++) {
                //                    var inputs = GV.childNodes[i].getElementsByTagName('input');
                //                    var lbl = GV.childNodes[i].getElementsByTagName('label');
                //                    if (arrayOfCheckBoxLabels[0].innerText == "NSF") {
                //                        inputs[0].checked = false;
                //                        
                //                    }                    
                //                }
                //            }
                //        }
                //        else if ((inputList[0].checked == false) && (arrayOfCheckBoxLabels[0].innerText == "NSF")) {
                //            if (GV.childNodes.length > 0) {
                //                for (var i = 1; i < GV.childNodes.length; i++) {
                //                    var inputs = GV.childNodes[i].getElementsByTagName('input');
                //                    var lbl = GV.childNodes[i].getElementsByTagName('label');
                //                    if (arrayOfCheckBoxLabels[0].innerText == "NSF") {
                //                        
                //                    }
                //                    else {                      
                //                                              
                //                        inputs[0].disabled = false;
                //                    }
                //                }
                //            }
                //        }

            }
        }
    }
</script>
<table width="100%" border="0" cellspacing="6" cellpadding="0">
    <tbody>
        <tr>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPEGeneral" runat="server" Font-Bold="true" Text="General appearance :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPEGeneral" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPEGeneral" runat="server" Width="100%" RepeatLayout="Flow">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divNigeriaPEGeneralOther" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther general conditions-8888326" align="center">
                                                        Other general conditions :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPEGeneral" ClientIDMode="Static" runat="server" Width="99%"
                                                        Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPESkin" runat="server" Font-Bold="true" Text="Skin :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPESkin" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPESkin" Width="100%" RepeatLayout="Flow" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPESkin" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther cardiovascular condition-8888330" align="center">
                                                        Other Skin condition :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPESkin" ClientIDMode="Static" runat="server" Width="99%"
                                                        Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPEHeadEyeEnt" runat="server" Font-Bold="true" Text="Head/Eye/ENT :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPEHeadEyeEnt" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPEHeadEyeEnt" Width="100%" RepeatLayout="Flow" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPEHeadEyeEnt" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther oral cavity conditions-8888332" align="center">
                                                        Other HeadEyeEnt:</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPEHeadEyeEnt" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPECardiovascular" runat="server" Font-Bold="true" Text="Cardiovascular :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPECardiovascular" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPECardiovascular" Width="100%" RepeatLayout="Flow"
                                        runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPECardiovascular" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther genital urinary conditions-8888334" align="center">
                                                        Other Cardiovascular :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPECardiovascular" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPEBreast" runat="server" Font-Bold="true" Text="Breast :"></asp:Label>
                                <%-- <label id="lblCNS-8888335" align="center" class="required">
                                    CNS :</label>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPEBreast" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPEBreast" Width="100%" RepeatLayout="Flow" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPEBreast" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther CNS conditions-8888336" align="center">
                                                        Other Breast :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPEBreast" ClientIDMode="Static" runat="server" Width="99%"
                                                        Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPEGenitalia" runat="server" Font-Bold="true" Text="Genitalia :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPEGenitalia" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPEGenitalia" Width="100%" RepeatLayout="Flow" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPEGenitalia" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther chest lungs conditions-8888338" align="center">
                                                        Other Genitalia :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPEGenitalia" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPERespiratory" runat="server" Font-Bold="true" Text="Respiratory :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPERespiratory" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPERespiratory" Width="100%" RepeatLayout="Flow" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <div id="divOtherNigeriaPERespiratory" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther skin conditions-8888340">
                                                        Other Respiratory :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPERespiratory" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPEGastrointestinal" runat="server" Font-Bold="true" Text="Gastrointestinal :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPEGastrointestinal" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPEGastrointestinal" onclick="CheckBoxToggleShortTerm();"
                                        Width="100%" RepeatLayout="Flow" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPEGastrointestinal" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="lblOther abdomen conditions-8888328" align="center">
                                                        Other Gastrointestinal:</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPEGastrointestinal" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPENeurological" runat="server" Font-Bold="true" Text="Neurological :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPENeurological" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPENeurological" Width="100%" RepeatLayout="Flow"
                                        runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <div id="divOtherNigeriaPENeurological" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="Label2">
                                                        Other Neurological :</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPENeurological" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="border center pad5 whitebg" style="width: 50%;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblNigeriaPEMentalstatus" runat="server" Font-Bold="true" Text="Mental status :"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div id="divNigeriaPEMentalstatus" enableviewstate="true" class="customdivbordermultiselect"
                                    runat="server">
                                    <asp:CheckBoxList ID="cblNigeriaPEMentalstatus" Width="100%" RepeatLayout="Flow"
                                        runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divOtherNigeriaPEMentalstatus" style="display: none;">
                                    <table width="100%">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    <label id="Label4" align="center">
                                                        Other Gastrointestinal:</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:TextBox ID="txtOtherNigeriaPEMentalstatus" ClientIDMode="Static" runat="server"
                                                        Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="border center pad5 whitebg" colspan="2">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td align="left" style="width: 100%;">
                                <label id="lblAdditional medical condition notes-8888564" align="center">
                                    Additional and detailed findings :</label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%;">
                                <asp:TextBox ID="txtOtherAdditionaldetailedfindings" Columns="20" Rows="6" Width="100%"
                                    TextMode="MultiLine" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>
