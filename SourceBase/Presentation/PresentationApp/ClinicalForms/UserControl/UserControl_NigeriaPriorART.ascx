<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControl_NigeriaPriorART.ascx.cs"
    Inherits="PresentationApp.ClinicalForms.UserControl.UserControl_NigeriaPriorART" %>
<script language="javascript" type="text/javascript">
    function GetControl() {
        document.forms[0].submit();
    }

    function EnableDis(a) {
        var rdoVal = a;
        if (rdoVal.value == "Y") {
            document.getElementById('<%=ddlfacilityname.ClientID%>').disabled = false;
            document.getElementById('<%=ddlentrytype.ClientID%>').disabled = false;
            document.getElementById('<%=txtdurationfrom.ClientID%>').disabled = false;
            document.getElementById('<%=txtdurationto.ClientID%>').disabled = false;
            document.getElementById('<%=btnAddPriorART.ClientID%>').disabled = false;
            document.getElementById('Img1').disabled = false;
            document.getElementById('Img2').disabled = false;
        }
        else {
            document.getElementById('<%=ddlfacilityname.ClientID%>').disabled = true;
            document.getElementById('<%=ddlentrytype.ClientID%>').disabled = true;
            document.getElementById('<%=txtdurationfrom.ClientID%>').disabled = true;
            document.getElementById('<%=txtdurationto.ClientID%>').disabled = true;
            document.getElementById('<%=btnAddPriorART.ClientID%>').disabled = true;
            document.getElementById('Img1').disabled = true;
            document.getElementById('Img2').disabled = false;
        }
    }
    function show_Priorhide(controlID, status) {
        var s = document.getElementById(controlID);
        if (status == "notvisible") {
            s.style.display = "none";
        }
        else {
            //s.style.display = "block";
        }
    }
</script>
<asp:UpdatePanel runat="server" ID="divComponent" UpdateMode="Conditional">
    <ContentTemplate>
        <table cellspacing="6" cellpadding="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td class="form">
                        <table width="100%">
                            <tr id="divshowpreviousexposure">
                                <td style="width: 16%" align="left">
                                    <label style="padding-left: 10px;" id="lblpurpose" runat="server">
                                        Previous ARV Exposure:</label>
                                </td>
                                <td colspan="2" align="left">
                                    <input id="rbtnknownYes" runat="server" onmouseup="up(this);" onfocus="up(this);"
                                        onclick="down(this); EnableDis(this)" type="radio" value="Y" name="PriorART" />
                                    <label for="y">
                                        Yes</label>
                                    <input id="rbtnknownNo" runat="server" onmouseup="up(this);" onfocus="up(this);"
                                        onclick="down(this); EnableDis(this)" type="radio" value="N" name="PriorART" />
                                    <label for="n">
                                        No</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 16%" align="left">
                                    <label id="lblfacilityname" runat="server" style="padding-left: 10px;">
                                        Name of the facility:</label>
                                </td>
                                <td colspan="2" align="left">
                                    <asp:DropDownList ID="ddlfacilityname" runat="server" Width="200px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 16%" align="left">
                                    <label style="padding-left: 10px;" id="Label1" runat="server">
                                        Duration of care:</label>
                                </td>
                                <td style="width: 30%" align="left">
                                    <label class="">
                                        From:</label>
                                    <asp:TextBox ID="txtdurationfrom" runat="server" Width="25%" MaxLength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                        onkeyup="DateFormat(this,this.value,event,false,'3')" onfocus="javascript:vDateType='3'"></asp:TextBox>
                                    <img onclick="w_displayDatePicker('<%= txtdurationfrom.ClientID %>');" height="22"
                                        alt="Date Helper" hspace="3" src="../Images/cal_icon.gif" width="22" border="0"
                                        id="Img1" style="vertical-align: bottom; margin-bottom: 2px;" />
                                    <span class="smallerlabel">(DD-MMM-YYYY)</span>
                                </td>
                                <td style="width: 30%" align="left">
                                    <label class="">
                                        To:</label>
                                    <asp:TextBox ID="txtdurationto" runat="server" Width="25%" MaxLength="11" onblur="DateFormat(this,this.value,event,false,'3')"
                                        onkeyup="DateFormat(this,this.value,event,false,'3')" onfocus="javascript:vDateType='3'"></asp:TextBox>
                                    <img onclick="w_displayDatePicker('<%= txtdurationto.ClientID %>');" height="22"
                                        alt="Date Helper" hspace="3" src="../Images/cal_icon.gif" width="22" border="0"
                                        id="Img2" style="vertical-align: bottom; margin-bottom: 2px;" />
                                    <span class="smallerlabel">(DD-MMM-YYYY)</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 16%" align="left">
                                    <label id="Label2" runat="server" style="padding-left: 10px;">
                                        Entry type:</label>
                                </td>
                                <td colspan="2" align="left">
                                    <asp:DropDownList ID="ddlentrytype" runat="server" Width="200px" Style="z-index: 2">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="pad5 formbg border" colspan="2">
                        <div id="divbtnPriorART" class="whitebg" align="center">
                            <asp:Button ID="btnAddPriorART" Text="Add Prior ART" runat="server" OnClick="btnAddPriorART_Click" /></div>
                    </td>
                </tr>
                <caption>
                    <br />
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
                                            <div class="mid" style="height: 200px; overflow: auto">
                                                <div id="div-gridview" class="GridView whitebg">
                                                    <asp:GridView ID="GrdPriorART" runat="server" AllowSorting="true" AutoGenerateColumns="False"
                                                        BorderWidth="1" CellPadding="0" CellSpacing="0" CssClass="datatable" GridLines="None"
                                                        HeaderStyle-HorizontalAlign="Left" Height="50px" OnRowDataBound="GrdPriorART_RowDataBound"
                                                        OnRowDeleting="GrdPriorART_RowDeleting" OnSelectedIndexChanging="GrdPriorART_SelectedIndexChanging"
                                                        RowStyle-CssClass="row" Width="100%">
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
            </tbody>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnAddPriorART" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>
