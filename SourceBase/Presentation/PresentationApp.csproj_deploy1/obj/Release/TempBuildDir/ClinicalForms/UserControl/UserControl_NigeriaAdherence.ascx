<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControl_NigeriaAdherence.ascx.cs"
    Inherits="PresentationApp.ClinicalForms.UserControl.UserControl_NigeriaAdherence" %>
<script language="javascript" type="text/javascript">
    function ShowHideDiv(theDiv) {

        if ($("#" + theDiv).is(':visible')) {
            $("#" + theDiv).hide();
            document.getElementById(<%=txtOtherdisclosed.ClientID %>).value = '';
        }
        else {
            $("#" + theDiv).show();
        }
    }
    $(document).ready(function () {
        $(".checkbox").on("change", function () {

            if ($(this).is(":checked")) {
                alert('a');
                $(".selectAll").prop('checked', false);
            }
        });
    });
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

    function toggleDisclosedPC(strcblcontrolId) {

        var GV = document.getElementById("<%= gvdisclosed.ClientID %>");

        var inputList = GV.getElementsByTagName("input");
        var arrayOfCheckBoxLabels = GV.getElementsByTagName("label");

        if ((inputList[0].checked == true) && (arrayOfCheckBoxLabels[0].innerText == "No one")) {
            if (GV.rows.length > 0) {
                for (var i = 1; i < GV.rows.length; i++) {
                    var inputs = GV.rows[i].getElementsByTagName('input');
                    var lbl = GV.rows[i].getElementsByTagName('label');
                    if (lbl[0].innerText != "No one") {
                        inputs[0].checked = false;

                        inputs[0].disabled = true;
                    }
                    else if (lbl[0].innerText == "No one") {
                    }
                }
            }
        }
        else if ((inputList[0].checked == true) && (arrayOfCheckBoxLabels[0].innerText != "No one")) {

            if (GV.rows.length > 0) {
                for (var i = 1; i < GV.rows.length; i++) {
                    var inputs = GV.rows[i].getElementsByTagName('input');
                    var lbl = GV.rows[i].getElementsByTagName('label');
                    if (lbl[0].innerText == "No one") {
                        inputs[0].checked = false;

                    }
                    else {

                    }
                }
            }
        }
        else if ((inputList[0].checked == false) && (arrayOfCheckBoxLabels[0].innerText == "No one")) {
            if (GV.rows.length > 0) {
                for (var i = 1; i < GV.rows.length; i++) {
                    var inputs = GV.rows[i].getElementsByTagName('input');
                    var lbl = GV.rows[i].getElementsByTagName('label');

                    if (lbl[0].innerText == "No one") {

                    }
                    else {

                        inputs[0].disabled = false;
                    }
                }
            }
        }
    }
</script>
<table class="border center formbg" cellspacing="6" cellpadding="0" width="100%"
    border="0">
    <tr>
        <td class="border center whitebg" width="100%">
            <table width='100%'>
                <tr>
                    <td style='width: 60%' align='right'>
                        <label for="rbladherenceYesNo">
                            Participating in an adherence program:</label>
                    </td>
                    <td style='width: 40%' align='left'>
                        <asp:RadioButtonList ID="rbladherenceYesNo" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" class="border center whitebg">
            <table width='100%'>
                <tr>
                    <td  align='right'>
                        <label for="rblmissedarvYesNo">
                            Missed ARV in the last 3 days:</label>
                    </td>
                    <td  align='left'>
                        <asp:RadioButtonList ID="rblmissedarvYesNo" runat="server" onclick="rblSelectedValue(this,'DIVmissedarv');"
                            RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style='width: 50%'>
            <div id="DIVmissedarv" style="display: none;">
                <table width='100%'>
                    <tr>
                        <td style='width: 50%' align='right'>
                            <label>
                                Reason missed:</label>
                        </td>
                        <td style='width: 50%' align='left'>
                            <asp:DropDownList ID="ddlReasomMissed" runat="server" Width="130px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
                </tr>
            </table>
        </td>
        
    </tr>
    <tr>
        <td style='width: 100%' class="border center whitebg">
            <table width='100%'>
                <tr>
                    <td  align='right' style='width: 19%'>
                        <label for="rblmissedarvYesNo">
                            Treatment was Interrupted:</label>
                    </td>
                    <td  align='left' style='width: 13%'>
                        <asp:RadioButtonList ID="rdoTreatmentIntrupted" runat="server" onclick="rblSelectedValue(this,'DIVInturptedReason');"
                            RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style='width: 70%'>
                        <div id="DIVInturptedReason" style="display: none;">
                            <table width='100%'>
                                <tr>
                                    <td style='width: 10%' align='right'>
                                        <label>
                                            Date:</label>
                                            </td>
                                <td  align='left' style='width: 23%'>
                                        <input id="txtdtIntrupptedDate" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                            onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,'3')"
                                            size="11" type="text"></input>
                                        <img id="Img1" alt="Date Helper" border="0" height="22 " hspace="5" name="appDateimg"
                                            onclick="w_displayDatePicker('<%=txtdtIntrupptedDate.ClientID%>');" src="../Images/cal_icon.gif"
                                            style="vertical-align: text-bottom;" width="22" />                                        
                                    </td>
                                    <td style='width: 20%' align="right">
                                        <label>
                                            Number of Days:</label>
                                            </td>
                                    <td style='width: 10%' align='left'>
                                        <asp:TextBox ID="txtintrpdays" MaxLength="3" runat="server" Width="20px"></asp:TextBox>
                                        
                                    </td>
                                    <td style='width: 23%' align="right">
                                        <label>
                                            Reason Interrupted:</label>
                                            </td>
                        <td  align="left" style='width: 15%'>
                                        <asp:DropDownList ID="ddlreasonInterrupted" runat="server" Width="90px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr >
        <td class="border center whitebg">
            <table width='100%'>
                <tr>
                    <td  align='right' style='width: 18%'>
                        <label for="rblmissedarvYesNo">
                            Treatment was Stopped:</label>
                    </td>
                    <td  align='left' style='width: 13%'>
                        <asp:RadioButtonList ID="rblstopped" runat="server" onclick="rblSelectedValue(this,'DIVStopedReason');"
                            RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style='width: 70%'>
            <div id="DIVStopedReason" style="display: none;">
                <table width='100%'>
                    <tr>
                        <td align='right' style='width: 10%'>
                            <label>
                                Date:</label>
                                </td>
                                <td  align='left' style='width: 23%'>
                            <input id="txtStopedReasonDate" runat="server" maxlength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                onfocus="javascript:vDateType='3'" onkeyup="DateFormat(this,this.value,event,false,'3')"
                                size="11" type="text"></input>
                            <img id="Img2" alt="Date Helper" border="0" height="22 " hspace="5" name="appDateimg"
                                onclick="w_displayDatePicker('<%=txtStopedReasonDate.ClientID%>');" src="../Images/cal_icon.gif"
                                style="vertical-align: text-bottom;" width="22" />
                            
                        </td>
                        <td style='width: 20%' align="right">
                            <label>
                                Number of Days:</label>
                                </td>
                                <td style='width: 10%' align='left'>
                            <asp:TextBox ID="txtstoppeddays" MaxLength="3" runat="server" Width="20px"></asp:TextBox>
                        </td>
                        <td  align="right" style='width: 22%'>
                            <label>
                                Reason Interrupted:</label>
                                </td>
                                <td align='left' style='width: 15%'>
                            <asp:DropDownList ID="ddlStopedReason" runat="server" Width="90px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
                </tr>
            </table>
        </td>
        
    </tr>
    <tr>
        <td class="border pad5 whitebg" width="100%">
            <div id="divdisclosed" style="margin-top: 10; margin-bottom: 10;">
                <asp:GridView ID="gvdisclosed" runat="server" AutoGenerateColumns="False" Width="100%"
                    GridLines="None" OnRowDataBound="gvdisclosed_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Patient has disclosed status to:" HeaderStyle-HorizontalAlign="Left"
                            ItemStyle-HorizontalAlign="Left">
                            <HeaderStyle ForeColor="Navy" />
                            <ItemTemplate>
                                <asp:Label ID="lbldisclosed" runat="server" Text='<%# Eval("ID")%>' Visible="false"></asp:Label>
                                <asp:CheckBox ID="Chkdisclosed" runat="server" Text='<%# Eval("NAME")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </td>
        </tr>
        <tr id="DivDiscloseOther" style="display: none;">
        <td width="100%">            
                <table width="100%">
                    <tr>
                        <td align="left">
                            <label>
                                Specify other disclosed:</label>
                            <asp:TextBox ID="txtOtherdisclosed" runat="server" Width="99%" Rows="3"
                                TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                </table>            
        </td>        
    </tr>
    <tr >
        <td width="100%" class="border center whitebg">
            <table width='100%'>
                <tr>
                    <td style='width: 25%' align="right">
                        <label for="rbladherenceYesNo">
                            HIV Status can be discussed with:</label>
                            </td>
                            <td style='width: 20%' align="left">
                            <asp:TextBox ID="txthivdiscussed" runat="server" Width="150px" ></asp:TextBox>
                    </td>
                   
                    <td style='width: 35%' align='right'>
                        <label for="rbladherenceYesNo">
                            Is the patient a member of as support group?:</label>
                            </td>
                            <td style='width: 15%' align="left">
                            <asp:RadioButtonList ID="rblsupportgroup" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    
                </tr>
            </table>
        </td>
        
    </tr>
</table>
