<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControl_NigeriaTreatmentPlan.ascx.cs"
    Inherits="PresentationApp.ClinicalForms.UserControl.UserControl_NigeriaTreatmentPlan" %>
<%@ Register Src="~/ClinicalForms/UserControl/UserControlKNH_LabEvaluation.ascx"
    TagName="Uclabeval" TagPrefix="uc11" %>
<script type="text/javascript">

    function getSelectedtableValue(DivId, DDText, str, tableId) {
        var e = document.getElementById(DDText);
        var text = e.options[e.selectedIndex].innerHTML;
        var YN = "";


        if (text == str) {
            YN = "show";
        }
        else {
            YN = "hide";
        }

        
        hideChklistEligiblethrough('<%=chklistARTchangecode.ClientID %>');
        
        ShowHide(DivId, YN);
    }

    function hideChklistEligiblethrough(controlId) {
        var elementRef = document.getElementById(controlId);
        var inputElementArray = elementRef.getElementsByTagName('INPUT');
        for (var i = 0; i < inputElementArray.length; i++) {
            if (inputElementArray[i].type == 'checkbox')
                inputElementArray[i].checked = false; ;
        }
    }
    function CheckBoxHideUnhide(strcblcontrolId, strdivId, strfieldname) {
        //alert(strcblcontrolId);
        var checkList = document.getElementById(strcblcontrolId);
        var checkBoxList = checkList.getElementsByTagName("input");
        var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
        var checkBoxSelectedItems = new Array();

        for (var i = 0; i < checkBoxList.length; i++) {

            if (checkBoxList[i].checked) {
                if (arrayOfCheckBoxLabels[i].innerHTML == strfieldname) {
                    ShowHide(strdivId, "show");
                }
                else {
                    ShowHide(strdivId, "hide");
                }
            }
            else {
                ShowHide(strdivId, "hide");
            }
        }

    }

    
</script>
<style type="text/css">
    .style2
    {
        width: 15%;
    }
</style>
<script language="javascript" type="text/javascript">
    
</script>
<table class="border center formbg" cellspacing="6" cellpadding="0" width="100%"
    border="0">
    <tbody>
        <tr>
            <td align="left">
                <asp:CheckBox ID="ChkLabEvaluation" runat="server" Text="Lab Evaluation" onchange="ShowHideDiv('DivLabEval');" />
            </td>
        </tr>
        <tr>
            <td>
                <div id="DivLabEval" class="border whitebg" style="display: none;">
                    <uc11:Uclabeval ID="UcLabEval" runat="server" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="border pad5 whitebg">
                <div id="divtreatment" style="margin-top: 10; margin-bottom: 10;">
                    <asp:GridView ID="gvtreatment" runat="server" AutoGenerateColumns="False" Width="100%"
                        GridLines="None" OnRowDataBound="gvtreatment_RowDataBound" ShowHeader="false">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lbltreatment" runat="server" Text='<%# Eval("ID")%>' Visible="false"></asp:Label>
                                    <asp:CheckBox ID="Chktreatment" runat="server" Text='<%# Eval("NAME")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:TemplateField>                            
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <div id="DivTreatmentOther" style="display: none;">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <label>
                                    Specify other Referrals:</label>
                                <asp:TextBox ID="txtOtherReferrals" runat="server" Width="99%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:CheckBox ID="chkregimen" runat="server" Text="Regimen" onchange="ShowHideDiv('DivPrescDrug');" />
            </td>
        </tr>
        <tr>
            <td align="left">
                <div id="DivPrescDrug" class="border pad5 whitebg" style="display: none;">
                    <asp:Button ID="btnPrescribeDrugs" runat="server" Text="Prescribe Regimen" OnClick="btnPrescribeDrugs_Click" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="border pad5 whitebg">
                <div id="divenrollin" style="margin-top: 10; margin-bottom: 10;">
                    <asp:GridView ID="gvenrollin" runat="server" AutoGenerateColumns="False" Width="100%"
                        GridLines="None" ShowHeader="false">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblenrollin" runat="server" Text='<%# Eval("ID")%>' Visible="false"></asp:Label>
                                    <asp:CheckBox ID="Chkenrollin" runat="server" Text='<%# Eval("NAME")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
        <tr align="left">
            <td class="form" align="left">
                <asp:Label ID="lblTreatmentplan" runat="server" CssClass="required" Font-Bold="True"
                    Text="Treatment plan:"></asp:Label>
                <asp:DropDownList ID="ddlTreatmentplan" runat="server" OnSelectedIndexChanged="ddlTreatmentplan_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr align="left" id="divARTchangecode" style="display: none;">
            <td class="form">
                <div>
                    <table width="100%">
                        <tbody>
                            <tr>
                                <td align="left">
                                    <label id="lblART change code-8888552" align="center">
                                        ART change code :</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <div id="divchklistARTchangecode" enableviewstate="true" class="customdivbordermultiselect"
                                        runat="server">
                                        <asp:CheckBoxList ID="chklistARTchangecode" RepeatLayout="Flow" runat="server">
                                        </asp:CheckBoxList>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <div id="divSpecifyotherARTchangereason" style="display: none;">
                                        <label id="lblSpecify other ART change reason-8888873" align="center">
                                            Specify other ART change reason:</label>
                                        <asp:TextBox ID="txtSpecifyotherARTchangereason" runat="server" Width="70%"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </tbody>
</table>
