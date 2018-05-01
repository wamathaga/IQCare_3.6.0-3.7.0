<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmPharmacyDispense_PatientOrder.aspx.cs" Inherits="PresentationApp.PharmacyDispense.frmPharmacyDispense_PatientOrder"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<%@ Register Src="../ClinicalForms/UserControl/UserControl_Loading.ascx" TagName="UserControl_Loading"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script type="text/javascript">
        function ace1_itemSelected(source, e) {
            var hdCustID = $get('<%= hdCustID.ClientID %>');
            hdCustID.value = e.get_value();
        }

        function openDrugHistory() {
            window.open('frmPharmacy_DrugHistory.aspx', '_blank', 'height=500,width=1100,scrollbars=yes');
        }

        function openAddAllergyPage() {
            var PatientID = '<%= Session["PatientID"] %>';
            window.open('../ClinicalForms/frmAllergy.aspx?name=Add&PatientId=' + PatientID + '&opento=popup', '_blank', 'height=500,width=1100,scrollbars=yes');
        }

        function ClearTextBox(txtDrug) {
            document.getElementById(txtDrug).value = "";
        }

        function ValidateRequired() {
            var name = document.getElementById('<%=ddlTreatmentProg.ClientID %>').value;
            if (name == "0") {
                alert("Please Select Treatment Program ");
                return false;
            }
            name = document.getElementById('<%=ddlregimenLine.ClientID %>').value;
            visible = document.getElementById('<%=ddlregimenLine.ClientID %>').style.visibility;
            if (name == "0" && visible != 'hidden') {

                alert("Please Select Regimen line");
                return false;
            }
            return true;
        }

        function chkQtyDispGreaterQtyPres(qtyDisp, qtyPres) {
            var disp = document.getElementById(qtyDisp).value;
            var pres = document.getElementById(qtyPres).value;
            if (parseFloat(disp) > parseFloat(pres)) {
                alert('Quantity dispensed is greater than quantity prescribed.');
            }
        }

        function disbleDateImage() {
            document.getElementById("Img1").style.display = 'none'; //.setAttribute('disabled', 'disabled');
        }

        function DispenseBySelect(selectId, qtyDisp1, qtyDisp2) {
            if (document.getElementById(selectId)[document.getElementById(selectId).selectedIndex].text == "Select") {
                //document.getElementById(qtyDisp1).value = "";
                document.getElementById(qtyDisp2).value = "";
                document.getElementById(qtyDisp1).disabled = true;
                document.getElementById(qtyDisp2).disabled = true;
            }
            else {
                //document.getElementById(otherControlID).value = "";
                document.getElementById(qtyDisp1).disabled = false;
                document.getElementById(qtyDisp2).disabled = false;
            }
        }

        function disableGVColumn(strGV, strColName) //gv id as string 
        {
            //var gridViewID = document.getElementById(gv);
            var index = 0;
            for (i = 2; i <= strGV.rows + 1; i++) {
                if ((i.toString()).length == 1) //concatenate like 01, 02 if row length is less than 10 
                {
                    index = "0" + i.toString();
                }
                else {
                    index = i.toString(); //else index of column would be 11.... on words 
                }
                var colID = strGV + "_ctl" + index + "_" + strColName;
                alert(colID);
                document.getElementById(colID).disabled = true;
            }
        }

        function hideColumn(selectId, gv) {
            rows = document.getElementById(gv).rows;
            if (document.getElementById(selectId)[document.getElementById(selectId).selectedIndex].text == "Select") {

                for (i = 0; i < rows.length; i++) {
                    //rows[i].cells[12].style.display = "none";
                    rows[i].cells[12].disabled = 'disabled';
                }
            }
            else {
                for (i = 0; i < rows.length; i++) {
                    //rows[i].cells[12].style.display = "block";
                    //rows[i].cells[12].disabled = 'disabled';
                    rows[i].cells[12].setAttribute('disabled', true);
                    //alert(rows[i].cells[12].text);
                }
            }
        }

        function showRegimenDDown(show) {
            if (show == 'false') {

                document.getElementById("<%= ddlregimenLine.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%= lblregimenLine.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=hdnregimenLine.ClientID %>").value = "hidden";
                //Regimen Code
                document.getElementById("<%= ddlRegimenCode.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%= lblregimenCode.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=hdnregimenCode.ClientID %>").value = "hidden";
            }
            else {
                document.getElementById("<%= ddlregimenLine.ClientID%>").style.visibility = "visible";
                document.getElementById("<%= lblregimenLine.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=hdnregimenLine.ClientID %>").value = "visible";
                //Regimen Code
                document.getElementById("<%= ddlRegimenCode.ClientID%>").style.visibility = "visible";
                document.getElementById("<%= lblregimenCode.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=hdnregimenCode.ClientID %>").value = "visible";
            }

        }
        function resetPosition(object, args) {
            var tb = object._element;
            var tbposition = findPositionWithScrolling(tb);
            var xposition = tbposition[0] - 75;
            var yposition = tbposition[1] + 10; // 22 textbox height 
            var ex = object._completionListElement;
            if (ex)
                $common.setLocation(ex, new Sys.UI.Point(xposition, yposition));
        }
        function findPositionWithScrolling(oElement) {
            if (typeof (oElement.offsetParent) != 'undefined') {
                var originalElement = oElement;
                for (var posX = 0, posY = 0; oElement; oElement = oElement.offsetParent) {
                    posX += oElement.offsetLeft;
                    posY += oElement.offsetTop;
                    if (oElement != originalElement && oElement != document.body && oElement != document.documentElement) {
                        posX -= oElement.scrollLeft;
                        posY -= oElement.scrollTop;
                    }
                }
                return [posX, posY];
            } else {
                return [oElement.x, oElement.y];
            }
        }
    </script>
    <div class="container-fluid">
        <table class="table-condensed" width="100%">
            <tr>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td colspan="2" class="style6">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnNewOrder" runat="server" Font-Bold="True" Text="New Order" OnClick="btnNewOrder_Click" />
                                            <asp:Button ID="btnPendingOrders" runat="server" Font-Bold="True" Text="View Pending Orders" />
                                            <asp:Button ID="btnDrugHistory" runat="server" Font-Bold="True" Text="Drug History"
                                                OnClientClick="openDrugHistory()" />
                                            <asp:Button ID="btnAddAllergy" runat="server" Font-Bold="True" Text="Add Allergy"
                                                OnClientClick="openAddAllergyPage()" />
                                            <act:ModalPopupExtender ID="btnPendingOrders_ModalPopupExtender" runat="server" TargetControlID="btnPendingOrders"
                                                PopupControlID="tblPendingOrders" BackgroundCssClass="modalBackground" CancelControlID="btnPendingOrdersClose">
                                            </act:ModalPopupExtender>
                                            <act:ModalPopupExtender ID="btnPrintLabels_ModalPopupExtender" runat="server" TargetControlID="btnPrintLabels"
                                                PopupControlID="tblPrintLabels" BackgroundCssClass="modalBackground" CancelControlID="btnClosePrintLabels">
                                            </act:ModalPopupExtender>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="table-condensed" width="100%">
                                    <tr>
                                        <td class="border pad5 formbg">
                                            <asp:Panel ID="PatientInfoHeader" runat="server">
                                                <h5 class="forms" align="left">
                                                    <asp:ImageButton ID="imgClientInfo" runat="server" ImageUrl="~/images/arrow-up.gif" />
                                                    &nbsp;<asp:Label ID="lblClientInfo" runat="server" Text="Current Patient Information"></asp:Label>
                                                </h5>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Panel ID="PatientInfoBody" runat="server">
                                    <table id="tblPatientVitals" class="table-condensed" width="100%">
                                        <tr valign="top">
                                            <td width="50%">
                                                <hr align="left" width="90%" />
                                                <div>
                                                    <table class="table-condensed" width="100%">
                                                        <tr>
                                                            <td width="33%">
                                                                <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Start Weight (kg)"></asp:Label>
                                                            </td>
                                                            <td width="33%">
                                                                <asp:Label ID="Label5" runat="server" Font-Bold="True" Text="Start Height (cm)"></asp:Label>
                                                            </td>
                                                            <td width="34%">
                                                                <asp:Label ID="Label14" runat="server" Font-Bold="True" Text="Start BSA"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtStartWeight" runat="server" Enabled="False" Width="125px"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtStartheight" runat="server" Enabled="False" Width="125px"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtStartBSA" runat="server" Enabled="False" Width="125px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label4" runat="server" Font-Bold="True" Text="Current Weight (kg)"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="server" Font-Bold="True" Text="Current Height (cm)"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label15" runat="server" Font-Bold="True" Text="Current BSA"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtCurrentWeight" runat="server" Width="125px"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtCurrentHeight" runat="server" Width="125px"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtCurrentBSA" runat="server" Enabled="False" Width="125px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <br />
                                                <hr align="left" width="90%" />
                                                <div>
                                                    <table width="100%" class="table-condensed">
                                                        <tr>
                                                            <td width="33%">
                                                                <asp:Label ID="Label7" runat="server" Font-Bold="True" Text="Start regimen at this facility:"></asp:Label>
                                                            </td>
                                                            <td width="33%">
                                                                <asp:Label ID="Label8" runat="server" Font-Bold="True" Text="Start Regimen Line:"></asp:Label>
                                                            </td>
                                                            <td width="34%">
                                                                <asp:Label ID="Label9" runat="server" Font-Bold="True" Text="Start Regimen Date:"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtStartReg" runat="server" Width="125px" Enabled="False"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtStartRegLine" runat="server" Width="125px" Enabled="False"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtStartRegDate" runat="server" Width="125px" Enabled="False"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Last Regimen:"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Last Regimen Line:"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtLastReg" runat="server" Width="125px" ReadOnly="True" Enabled="False"></asp:TextBox>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:TextBox ID="txtLastRegLine" runat="server" Width="125px" Enabled="False"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td width="50%">
                                                <hr />
                                                <div>
                                                    <table width="100%" class="table-condensed">
                                                        <tr>
                                                            <td width="20%">
                                                                <asp:Label ID="Label28" runat="server" Font-Bold="True" Text="On TB Treatment:"></asp:Label>
                                                            </td>
                                                            <td width="20%">
                                                                <asp:RadioButtonList ID="rbOnTBTreatment" runat="server" Enabled="False" Font-Bold="True"
                                                                    RepeatDirection="Horizontal">
                                                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                    <asp:ListItem Value="0">No</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                            <td width="18%">
                                                                <asp:Label ID="lblIPTStartDate" runat="server" Font-Bold="True" Text="IPT Start Date:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtIPTStartDate" runat="server" Width="110px"></asp:TextBox>
                                                                <img id="appDateimg3" onclick="w_displayDatePicker('<%=txtIPTStartDate.ClientID%>');"
                                                                    height="22" alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                                                                    border="0" name="appDateimg0" /><span class="smallerlabel" id="appDatespan3">(DD-MMM-YYYY)</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="18%">
                                                            </td>
                                                            <td width="20%">
                                                            </td>
                                                            <td width="18%">
                                                                <asp:Label ID="lblIPTEndDate" runat="server" Font-Bold="True" Text="IPT End Date:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtIPTEndDate" runat="server" Width="110px"></asp:TextBox>
                                                                <img id="appDateimg4" onclick="w_displayDatePicker('<%=txtIPTEndDate.ClientID%>');"
                                                                    height="22" alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22"
                                                                    border="0" name="appDateimg1" style="vertical-align: bottom; margin-bottom: 2px;" /><span
                                                                        class="smallerlabel" id="appDatespan4">(DD-MMM-YYYY)</span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <br />
                                                <br />
                                                <hr />
                                                <div>
                                                    <table width="100%" class="table-condensed">
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label23" runat="server" Font-Bold="True" Text="Days to Appointment:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label24" runat="server" Font-Bold="True" Text="Appointment Date:"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label25" runat="server" Font-Bold="True" Text="Previous Appointment"
                                                                    CssClass="style11"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDaysToPreviousAppt" runat="server" Width="85px" Enabled="False"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPreviousApptDate" runat="server" Width="125px" Enabled="False"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <strong>Days to Next appointment:</strong>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDaysToNextAppt" runat="server" Width="85px"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtNextApptDate" runat="server" Width="125px"></asp:TextBox><img
                                                                    id="Img2" onclick="w_displayDatePicker('<%=txtNextApptDate.ClientID%>');" height="22"
                                                                    alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22" border="0"
                                                                    name="appDateimg0" style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel"
                                                                        id="Span4">(DD-MMM-YYYY)</span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <hr />
                                                <div>
                                                    <table width="100%" class="table-condensed">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label27" runat="server" Font-Bold="True" Text="Treatment Plan:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlTreatmentPlan" runat="server" Width="224px" Enabled="False"
                                                                    Font-Bold="True">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label16" runat="server" Font-Bold="True" Text="WHO Stage:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlWHOStage" runat="server" Width="225px" Enabled="False" Font-Bold="True">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <act:CollapsiblePanelExtender ID="CollapsiblePanelExtenderPatientInfo" runat="server"
                                    SuppressPostBack="True" ExpandedImage="~/images/arrow-dn.gif" TargetControlID="PatientInfoBody"
                                    CollapseControlID="PatientInfoHeader" ExpandControlID="PatientInfoHeader" CollapsedImage="~/images/arrow-up.gif"
                                    Collapsed="True" ImageControlID="imgClientInfo" Enabled="True"></act:CollapsiblePanelExtender>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td colspan="2">
                                <hr />
                                <table width="100%" class="table-condensed">
                                    <tr>
                                        <td width="130px">
                                            <asp:Label ID="Label29" runat="server" Font-Bold="True" Text="Treatment Program:"
                                                CssClass="required"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTreatmentProg" runat="server" Width="225px">
                                            </asp:DropDownList>
                                        </td>
                                         <td>
                                            <asp:Label ID="lblregimenCode" runat="server" Font-Bold="True" Text="Regimen Code:"
                                                CssClass="required" Style="visibility: hidden;"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlRegimenCode" runat="server" Width="120px" Style="visibility: hidden;">
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="hdnregimenCode" runat="server" Value="hidden" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblregimenLine" runat="server" Font-Bold="True" Text="Regimen Line:"
                                                CssClass="required" Style="visibility: hidden;"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlregimenLine" runat="server" Width="225px" Style="visibility: hidden;">
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="hdnregimenLine" runat="server" Value="hidden" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td colspan="2">
                                <hr />
                                <table width="100%" class="table-condensed">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDispensingStoreLabel" runat="server" Font-Bold="True" Text="Dispensing Store:"
                                                CssClass="required"></asp:Label>
                                            <asp:DropDownList ID="ddlDispensingStore" runat="server" Width="150px" OnSelectedIndexChanged="ddlDispensingStore_SelectedIndexChanged"
                                                AutoPostBack="true">
                                            </asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorDispenStore" runat="server"
                                            ErrorMessage="Required" ControlToValidate="ddlDispensingStore" InitialValue="0"
                                            ValidationGroup='RequiredForSave'></asp:RequiredFieldValidator>--%>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label17" runat="server" Font-Bold="True" Text="Prescribed by:" CssClass="required"></asp:Label>
                                            &nbsp;<asp:DropDownList ID="ddlPrescribedBy" runat="server" Width="166px">
                                            </asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorPresBy" runat="server" ErrorMessage="Required"
                                            ControlToValidate="ddlPrescribedBy" InitialValue="0" ValidationGroup='RequiredForSave'></asp:RequiredFieldValidator>--%>
                                        </td>
                                        <td width="115px">
                                            <asp:Label ID="Label18" runat="server" Font-Bold="True" Text="Prescription date:"
                                                CssClass="required"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtprescriptionDate" runat="server" Width="125px"></asp:TextBox>
                                            <span id="dtpSpan" runat="server">
                                                <img onclick="w_displayDatePicker('<%=txtprescriptionDate.ClientID%>');" height="22"
                                                    alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22" border="0"
                                                    name="appDateimg2" style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel">(DD-MMM-YYYY)</span></span>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required"
                                            ControlToValidate="txtprescriptionDate" ValidationGroup='RequiredForSave'></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDispensedBy" runat="server" Font-Bold="True" Text="Dispensed by:"
                                                CssClass="required"></asp:Label>
                                            &nbsp;<asp:DropDownList ID="ddlDispensedBy" runat="server" Width="168px">
                                            </asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorDispBy" runat="server" ErrorMessage="Required"
                                            ControlToValidate="ddlDispensedBy" InitialValue="0" ValidationGroup='RequiredForSave'></asp:RequiredFieldValidator>--%>
                                        </td>
                                        <td class="style7">
                                            <asp:Label ID="lblDispenseDate" runat="server" Font-Bold="True" Text="Dispense date:"
                                                CssClass="required"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDispenseDate" runat="server" Width="125px"></asp:TextBox><img
                                                id="Img1" onclick="w_displayDatePicker('<%=txtDispenseDate.ClientID%>');" height="22"
                                                alt="Date Helper" hspace="5" src="../images/cal_icon.gif" width="22" border="0"
                                                name="appDateimg0" style="vertical-align: bottom; margin-bottom: 2px;" /><span class="smallerlabel"
                                                    id="Span1">(DD-MMM-YYYY)</span>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidatorDateDispensed" runat="server"
                                            ErrorMessage="Required" ControlToValidate="txtDispenseDate" ValidationGroup='RequiredForSave'></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr valign="top">
                            <td colspan="2">
                                <div class="GridView whitebg" style="cursor: pointer;">
                                    <div class="grid">
                                        <div class="rounded">
                                            <div class="top-outer">
                                                <div class="top-inner">
                                                    <div class="top">
                                                        <h2 class="center">
                                                            Dispense Drugs</h2>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mid-outer">
                                                <div class="mid-inner">
                                                    <div>
                                                        <table class="table-condensed">
                                                            <tr>
                                                                <br />
                                                                <td style="width:100px;">
                                                                    &nbsp;<asp:Label ID="Label30" runat="server" Text="Drug Name:" Font-Bold="true" Style="vertical-align: top"></asp:Label>
                                                                </td>
                                                                <td style="width: 570px">
                                                                    <asp:TextBox ID="txtDrug" runat="server" Width="100%" OnTextChanged="txtDrug_TextChanged"
                                                                        AutoPostBack="true"></asp:TextBox>
                                                                    <asp:Panel ID="divwidth" runat="server" ScrollBars="Vertical" Height="200px" />
                                                                </td>
                                                                <td style="width:10%;" align="left">
                                                                <asp:CheckBox ID="chkAvailDrugs" runat="server" Text="Available Only" 
                                                                        TextAlign="Right" Checked="true" 
                                                                        oncheckedchanged="chkAvailDrugs_CheckedChanged" AutoPostBack="true"/>
                                                                </td>
                                                                <td width="41%" align="right">
                                                                    <asp:Button ID="btnPriorPrescription" runat="server" Font-Bold="True" Text="Copy Prior Prescription"
                                                                        OnClick="btnPriorPrescription_Click" CssClass="btn btn-primary" Height="30px"
                                                                        Width="38%" Style="text-align: left;" />
                                                                    <label class="glyphicon glyphicon-copy" style="margin-left: -4%; margin-right: 2%;
                                                                        vertical-align: sub; color: #fff;">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <act:AutoCompleteExtender ServiceMethod="SearchDrugs" MinimumPrefixLength="2" CompletionInterval="30"
                                                            EnableCaching="false" CompletionSetCount="10" TargetControlID="txtDrug" ID="AutoCompleteExtender1"
                                                            OnClientShown="resetPosition" runat="server" FirstRowSelected="false" CompletionListElementID="divwidth"
                                                            OnClientItemSelected="ace1_itemSelected">
                                                        </act:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdCustID" runat="server" />
                                                        <hr />
                                                    </div>
                                                    <div class="mid" style="height: 300px; overflow: auto">
                                                        <div id="div-gridview" class="GridView whitebg">
                                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="gvDispenseDrugs" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                                                                        Width="100%" BorderWidth="0px" CellPadding="0" CssClass="datatable" OnRowDataBound="gvDispenseDrugs_RowDataBound"
                                                                        DataKeyNames="DrugId, DispensingUnitId, orderId, QtyUnitDisp, syrup, UserID"
                                                                        GridLines="None" OnRowDeleting="gvDispenseDrugs_RowDeleting">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Drug Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Unit" HeaderStyle-Width="50px">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUnit" runat="server" Text='<%# Bind("Unit") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Batch No" HeaderStyle-Width="90px">
                                                                                <ItemTemplate>
                                                                                    <asp:DropDownList ID="ddlBatchNo" runat="server" Width="90%" OnSelectedIndexChanged="ddlBatchNo_SelectedIndexChanged"
                                                                                        AutoPostBack="true">
                                                                                    </asp:DropDownList>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Expiry Date" HeaderStyle-Width="80px">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblExpiryDate" runat="server" Width="90%" Text='<%# Bind("ExpiryDate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Morning" HeaderImageUrl="~/Images/morning1.jpg" HeaderStyle-Width="40px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtMorning" runat="server" Width="80%" Text='<%# Bind("Morning") %>'
                                                                                        onkeyup="chkDecimal('<%=txtMorning.ClientID%>')"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Midday" HeaderImageUrl="~/Images/midday1.jpg" HeaderStyle-Width="40px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtMidday" runat="server" Width="80%" Text='<%# Bind("Midday") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Evening" HeaderImageUrl="~/Images/evening1.jpg" HeaderStyle-Width="40px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtEvening" runat="server" Width="80%" Text='<%# Bind("Evening") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Night" HeaderImageUrl="~/Images/night2.jpg" HeaderStyle-Width="40px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtNight" runat="server" Width="80%" Text='<%# Bind("Night") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Duration" HeaderStyle-Width="60px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtDuration" runat="server" Width="90%" Text='<%# Bind("Duration") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Qty Presc" HeaderStyle-Width="65px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtQtyPrescribed" runat="server" Width="90%" Text='<%# Bind("QtyPrescribed") %>'></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required"
                                                                                        Display="Dynamic" ControlToValidate="txtQtyPrescribed" ValidationGroup='RequiredForSave'></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Pill Count" HeaderStyle-Width="65px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtPillCount" runat="server" Width="90%" Text='<%# Bind("PillCount") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Refill" HeaderStyle-Width="45px" HeaderStyle-CssClass="hidden"
                                                                                ItemStyle-CssClass="hidden">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtRefillQty" runat="server" Width="90%" Text='<%# Bind("QtyDispensed") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Qty Disp" HeaderStyle-Width="65px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtQtyDispensed" runat="server" Width="90%" Text=""></asp:TextBox>
                                                                                    <asp:RangeValidator ID="RangeValidatorQtyDisp" runat="server" ErrorMessage="Error"
                                                                                        MinimumValue="1" MaximumValue="50000" Enabled="false" ControlToValidate="txtQtyDispensed"
                                                                                        Type="Double" Display="Dynamic" ValidationGroup='RequiredForSave'></asp:RangeValidator>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorQtyDisp" runat="server" ErrorMessage="Required"
                                                                                        ControlToValidate="txtQtyDispensed" Enabled="false" ValidationGroup='RequiredForSave'
                                                                                        Display="Dynamic"></asp:RequiredFieldValidator></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="PPx">
                                                                                <ItemTemplate>
                                                                                    <div style="text-align: center">
                                                                                        <asp:CheckBox ID="chkProphylaxis" runat="server" Checked='<%# (Eval("Prophylaxis").ToString() == "1" ? true : false) %>'
                                                                                            ToolTip="Prophylaxis" />
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Print Rx" HeaderStyle-HorizontalAlign="Center">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkPrintPrescrip" runat="server" Checked='<%# (Eval("PrintPrescriptionStatus").ToString() == "1" ? true : false) %>'
                                                                                        ToolTip="Prophylaxis" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Comments" HeaderStyle-Width="200px">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtComments" runat="server" Width="98%" Text='<%# Bind("Comments") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="">
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton ID="DeleteButton" runat="server" ImageUrl="~/Images/del.gif" CommandName="Delete"
                                                                                        OnClientClick="return confirm('Are you sure you want to remove this drug?');"
                                                                                        AlternateText="Delete" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Instructions" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblInstructions" runat="server" Width="90%" Text='<%# Bind("Instructions") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="GenericAbbrevation" HeaderStyle-CssClass="hidden"
                                                                                ItemStyle-CssClass="hidden">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblregimen" runat="server" Width="90%" Text='<%# Bind("GenericAbbrevation") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <RowStyle CssClass="row" />
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="ddlDispensingStore" EventName="SelectedIndexChanged" />
                                                                    <asp:AsyncPostBackTrigger ControlID="txtDrug" EventName="TextChanged" />
                                                                </Triggers>
                                                            </asp:UpdatePanel>
                                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                                <ProgressTemplate>
                                                                    <uc1:UserControl_Loading ID="UserControl_Loading1" runat="server" />
                                                                </ProgressTemplate>
                                                            </asp:UpdateProgress>
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
                            <td colspan="2" align="right">
                                <asp:Button ID="btnFullyDispensed" runat="server" Text="Mark as Fully Dispensed"
                                    Height="30px" Width="16%" Style="text-align: left;" OnClick="btnFullyDispensed_Click"
                                    CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to mark this order as Fully Dispensed?');" />
                                <label class="glyphicon glyphicon-floppy-saved" style="margin-left: -2%; margin-right: 0%;
                                    vertical-align: sub; color: #fff;">
                                </label>
                                <asp:Button ID="btnPrintLabels" runat="server" class="hidden" Text="Print Labels"
                                    Height="30px" Width="8%" />
                                <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -2%; margin-right: 2%;
                                    vertical-align: sub; color: #fff; visibility: hidden">
                                </label>
                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click"
                                    ValidationGroup='RequiredForSave' Height="30px" Width="7%" align="left" />
                                <label class="glyphicon glyphicon-floppy-disk" style="margin-left: -2%; margin-right: 1%;
                                    vertical-align: sub; color: #fff;">
                                </label>
                                <asp:Button ID="btnPrintPres" runat="server" CssClass="btn btn-primary" OnClick="btnPrintPres_Click"
                                    Text="Print Prescription" Height="30px" Width="15%" />
                                <label class="glyphicon glyphicon-print" style="margin-left: -3%; margin-right: 2%;
                                    vertical-align: sub; color: #fff;">
                                </label>
                                <asp:Button ID="btnPrintLabel" Text="Print Labels" CssClass="btn btn-primary" runat="server"
                                    OnClick="btnPrintLabel_Click" Height="30px" Width="8%" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:Table ID="tblPendingOrders" runat="server" Width="400px" Height="300px" BackColor="White"
            CssClass="table-condensed">
            <asp:TableRow>
                <asp:TableCell Height="20px" BackColor="#666699">
                    <asp:Table ID="Table11" runat="server" Width="100%">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="White"
                                Font-Bold="true">
                                Pending Orders
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right" VerticalAlign="Middle">
                                <asp:ImageButton ID="btnPendingOrdersClose" runat="server" ImageUrl="~/Images/closeButton1.png"
                                    Height="20px" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell Height="100%">
                    <div class="grid" id="divBills" style="width: 100%;">
                        <div class="rounded">
                            <div class="mid-outer">
                                <div class="mid-inner">
                                    <div class="mid" style="height: 400px; overflow: auto">
                                        <div id="div1" class="GridView whitebg">
                                            <asp:GridView ID="gvPendingorders" runat="server" AutoGenerateColumns="False" AllowSorting="true"
                                                Width="100%" BorderColor="white" PageIndex="1" BorderWidth="1" GridLines="None"
                                                CssClass="datatable" CellPadding="0" CellSpacing="0" DataKeyNames="ptn_pharmacy_pk, visitID"
                                                OnSelectedIndexChanged="gvPendingorders_SelectedIndexChanged" OnRowDataBound="gvPendingorders_RowDataBound">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <RowStyle CssClass="row" />
                                                <Columns>
                                                    <asp:BoundField HeaderText="Transaction Date" DataField="TransactionDate" />
                                                    <asp:BoundField HeaderText="Status" DataField="Status" />
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
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table ID="tblPrintLabels" runat="server" Width="600px" Height="70%" BackColor="White"
            CssClass="table-condensed">
            <asp:TableRow>
                <asp:TableCell Height="20px" BackColor="#666699">
                    <asp:Table ID="Table4" runat="server" Width="100%">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="White"
                                Font-Bold="true">
                                
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right" VerticalAlign="Middle">
                                <asp:ImageButton ID="btnClosePrintLabels" runat="server" ImageUrl="~/Images/closeButton1.png"
                                    Height="20px" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell Height="100%">
                    <iframe style="width: 100%; height: 100%;" id="Iframe3" src="frmPharmacy_PrintLabels.aspx"
                        runat="server"></iframe>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <script type="text/javascript">
        $('#aspnetForm').keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
            }
        });
    </script>
</asp:Content>
