﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true" Inherits="ClinicalForms_frmClinical_ARVTherapy" Codebehind="frmClinical_ARVTherapy.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="Server">

    <script language="javascript" type="text/javascript"> 

        function WindowPrint() {

            window.print();

        }
         
        function GetControl() {
            document.forms[0].submit();
        }
        function ShowValue() {
            document.getElementById('Img1').disabled = true;
            document.getElementById('Img2').disabled = true;
            document.getElementById('Img6').disabled = true;
        }
        function CalEnbleDisble(a, b, c) {
            if (a == 0) {
                document.getElementById('Img1').disabled = true;
            }
            if (b == 0) {
                document.getElementById('Img2').disabled = true;
            }
            if (c == 0) {
                document.getElementById('Img6').disabled = true;
            }
        }
        function setMonthYear() {
            var artTransferDate = document.getElementById("<%=txtanotherRegimendate.ClientID%>").value;
            if (artTransferDate != "") {
                var arrMonthDate = artTransferDate.split('-');
                if (arrMonthDate[1] != "")
                    document.getElementById("<%=txtcohortmnth.ClientID%>").value = arrMonthDate[1];
                else
                    document.getElementById("<%=txtcohortmnth.ClientID%>").value = "";

                if (arrMonthDate[2] != "")
                    document.getElementById("<%=txtcohortyear.ClientID%>").value = arrMonthDate[2];
                else
                    document.getElementById("<%=txtcohortyear.ClientID%>").value = "";
            }
        }

        //    function EligibilityEnableDisable(ddleligibleThru) {
        //        var ControlName = document.getElementById("<%=ddleligibleThru.ClientID%>");

        //        if (ControlName.value == 330)  //it depends on which value Selection do u want to hide or show your textbox 
        //        {
        //            document.getElementById("<%=txtCD4.ClientID%>").value = '';
        //            document.getElementById("<%=txtCD4.ClientID%>").disabled = true;
        //            document.getElementById("<%=txtCD4percent.ClientID%>").value = '';
        //            document.getElementById("<%=txtCD4percent.ClientID%>").disabled = true;
        //            document.getElementById("<%=lstClinicalStage.ClientID%>").value = '0';
        //            document.getElementById("<%=lstClinicalStage.ClientID%>").disabled = false;
        //            // document.getElementById("=TextBox1.ClientID%>").style.display = 'none';


        //        }
        //        else if (ControlName.value == 331) {
        //            document.getElementById("<%=txtCD4.ClientID%>").value = '';
        //            document.getElementById("<%=txtCD4.ClientID%>").disabled = false;
        //            document.getElementById("<%=txtCD4percent.ClientID%>").value = '';
        //            document.getElementById("<%=txtCD4percent.ClientID%>").disabled = false;
        //            document.getElementById("<%=lstClinicalStage.ClientID%>").value = '0';
        //            document.getElementById("<%=lstClinicalStage.ClientID%>").disabled = true;
        //            // document.getElementById("=TextBox1.ClientID%>").style.display = 'none';
        //            //document.getElementById("=TextBox1.ClientID%>").style.display = '';
        //        }
        //        else {
        //            document.getElementById("<%=txtCD4.ClientID%>").value = '';
        //            document.getElementById("<%=txtCD4.ClientID%>").disabled = true;
        //            document.getElementById("<%=txtCD4percent.ClientID%>").value = '';
        //            document.getElementById("<%=txtCD4percent.ClientID%>").disabled = true;
        //            document.getElementById("<%=lstClinicalStage.ClientID%>").value = '0';
        //            document.getElementById("<%=lstClinicalStage.ClientID%>").disabled = true;
        //            // document.getElementById("=TextBox1.ClientID%>").style.display = 'none';
        //            //document.getElementById("=TextBox1.ClientID%>").style.display = '';
        //        }
        //    }

        function CalcualteBMI(txtBMI, txtWeight, txtHeight) {
            var weight = document.getElementById(txtWeight).value;
            var height = document.getElementById(txtHeight).value;
            if (weight == "" || height == "") {
                weight = 0;
                height = 0;
            }

            weight = parseFloat(weight);
            height = parseFloat(height);
            if (weight == 0 || height == 0) {
                document.getElementById(txtBMI).value = "";
            }
            else {
                var BMI = weight / ((height / 100) * (height / 100));
                BMI = BMI.toFixed(2);
                document.getElementById(txtBMI).value = BMI;
            }
        }

        function compareDates(dob, otherdate) {
            if (document.getElementById(otherdate).value == "") {
                return true;
            }
            var dobdd = dob.toString().substr(0, 2);
            var dobmm = dob.toString().substr(3, 3);
            var dobyr = dob.toString().substr(7, 4);
            var dmm;
            switch (dobmm.toLowerCase()) {
                case "jan": dmm = "0";
                    break;
                case "feb": dmm = "1";
                    break;
                case "mar": dmm = "2";
                    break;
                case "apr": dmm = "3";
                    break;
                case "may": dmm = "4";
                    break;
                case "jun": dmm = "5";
                    break;
                case "jul": dmm = "6";
                    break;
                case "aug": dmm = "7";
                    break;
                case "sep": dmm = "8";
                    break;
                case "oct": dmm = "9";
                    break;
                case "nov": dmm = "10";
                    break;
                case "dec": dmm = "11";
                    break;
            }
            var myDOB = new Date();
            myDOB.setFullYear(dobyr, dmm, dobdd);

            var otherdd = document.getElementById(otherdate).value.toString().substr(0, 2);
            var othermm = document.getElementById(otherdate).value.toString().substr(3, 3);
            var otheryr = document.getElementById(otherdate).value.toString().substr(7, 4);
            var omm;
            switch (othermm.toLowerCase()) {
                case "jan": omm = "0";
                    break;
                case "feb": omm = "1";
                    break;
                case "mar": omm = "2";
                    break;
                case "apr": omm = "3";
                    break;
                case "may": omm = "4";
                    break;
                case "jun": omm = "5";
                    break;
                case "jul": omm = "6";
                    break;
                case "aug": omm = "7";
                    break;
                case "sep": omm = "8";
                    break;
                case "oct": omm = "9";
                    break;
                case "nov": omm = "10";
                    break;
                case "dec": omm = "11";
                    break;
            }
            var myOther = new Date();
            myOther.setFullYear(otheryr, omm, otherdd);

            if (myDOB <= myOther) {
                return true;
            }
            else {
                alert("Date cannot be Less than Date of Birth!!");
                document.getElementById(otherdate).value = "";
                document.getElementById(otherdate).focus();
                //document.getElementById(otherdate).select();
                return false;
            }
        }

    </script>
    <br />
    <div style="padding-left: 8px; padding-right: 8px;">
        
        <div class="border center formbg">
            <br/>
            <h2 class="forms" align="left">
                ART Eligibility</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label id="Label2" class="right5">
                                Date Medically Eligible:</label>
                            <input id="txtdateEligible" runat="server" maxlength="11" size="10" name="txtarttransdate" />
                            <img id="img2" onclick="w_displayDatePicker('<%=txtdateEligible.ClientID%>');" height="22"
                                alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22" border="0" /><span
                                    class="smallerlabel">(DD-MMM-YYYY)</span>
                        </td>
                        <td class="border whitebg formcenter pad5">
                            <label class="right5">
                                Eligible Through:</label>
                            <asp:DropDownList ID="ddleligibleThru" runat="Server" OnSelectedIndexChanged="ddleligibleThru_SelectedIndexChanged"  
                                AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label id="Label1" class="right5">
                                WHO Stage:</label>
                            <asp:DropDownList ID="lstClinicalStage" runat="server" Style="width: 100px">
                            </asp:DropDownList>
                        </td>
                        <td class="border whitebg formcenter pad5">
                            <label id="Label3">
                                CD4:
                            </label>
                            <asp:TextBox ID="txtCD4" runat="server" Width="110px"></asp:TextBox>
                            <label id="Label4" class="right15">
                                CD4 %:
                            </label>
                            <asp:TextBox ID="txtCD4percent" runat="server" Width="110px"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br>
        </div>
        <br />
        <div class="border center formbg">
            <br />
            <h2 class="forms" align="left">
                Cohort</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label>
                                Cohort Month:</label>
                            <input id="txtcohortmnth" size="10" name="CohortMonth" runat="server" readonly="readonly"/>
                        </td>
                        <td class="form   center">
                            <label>
                                Cohort Year:</label>
                            <input id="txtcohortyear" size="10" name="CohortYear" runat="server" readonly="readonly"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
        </div>
        <br />
        <div class="border center formbg">
            <br/>
            <h2 class="forms" align="left">
                ART Start at Another Facility</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label id="lblrARTdate">
                                Start ART 1st Line Regimen Date:</label>
                            <input id="txtanotherRegimendate" runat="server" maxlength="11" size="10" name="txtanotherRegimendate"
                                onmouseout="setMonthYear();" />
                            <img id="imgdate" onclick="w_displayDatePicker('<%=txtanotherRegimendate.ClientID%>');"
                                height="22" alt="Date Helper" hspace="3" src="../images/cal_icon.gif" width="22"
                                border="0" /><span class="smallerlabel">(DD-MMM-YYYY)</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right10">
                                Regimen:</label>
                            <input id="txtanotherregimen" size="16" name="anotherregimen" readonly="readonly"
                                runat="server"/>
                            <asp:Button ID="btnanotherRegimen" runat="server" Text="..." OnClick="btnTransRegimen_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label>
                                Weight :
                            </label>
                            <input id="txtanotherwght" size="6" maxlength="3" name="anotherwght" runat="server" />
                            <label>
                                Kgs</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                Height :</label>
                            <input id="txtanotherheight" size="6" maxlength="3" name="anotherheight" runat="server"/>
                             <label>
                                cm</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                BMI :</label>
                            <%--<input id="txtanotherwght1"  size="6" name="anotherwght1" runat="server">--%>
                            <input id="txtanotherbmi" size="6" name="anotherbmi" runat="server" readonly="readonly"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                WHO Stage :</label>
                            <asp:DropDownList ID="lstanotherClinicalStage" runat="server" Style="width: 100px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
        </div>
        <br />
        <div class="border center formbg">
            <br/>
            <h2 class="forms" align="left">
                ART Start at This Facility</h2>
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label id="lblthisregi">
                                Start ART 1st Line Regimen Date:</label>
                            <input id="txtthisRegimendate" runat="server" maxlength="11" size="10" name="txtthisRegimendate"
                                readonly="readonly" />
                            <img id="img1" height="22" alt="Date Helper" hspace="3" src="../images/cal_icon.gif"
                                width="22" border="0" /><span class="smallerlabel">(DD-MMM-YYYY)</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right10">
                                Regimen:</label>
                            <input id="txtthisregimen" size="16" name="thisregimen" readonly="readonly" runat="server" />
                            <asp:Button ID="btnthisRegimen" runat="server" Text="..." Enabled="False" />
                        </td>
                    </tr>
                    <tr>
                        <td class="border whitebg formcenter pad5">
                            <label>
                                Weight :</label>
                            <input id="txtthiswght" size="6" name="thisweight" runat="server" readonly="readonly"/>
                            Kgs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                Height :</label>
                            <input id="txtthisheight" size="6" name="thisheight" runat="server" readonly="readonly"/>
                            cm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                BMI :</label>
                            <input id="txtthisbmi" size="6" name="thisbmi" runat="server" readonly="readonly"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="right15">
                                WHO Stage:</label>
                            <asp:DropDownList ID="lstthisClinicalStage" runat="server" Style="width: 100px" Enabled="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
        </div>
        <br />
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="pad5 formbg border">
                            <div class="grid">
                                <div class="rounded">
                                    <div class="top-outer">
                                        <div class="top-inner">
                                            <div class="top">
                                                <h2>
                                                    <center>
                                                        Substitutions and Switches
                                                    </center>
                                                </h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mid-outer">
                                        <div class="mid-inner">
                                            <div class="mid" style="height: 200px; overflow: auto">
                                                <div id="div-gridview" class="gridviewbackup whitebg">
                                                    <asp:GridView ID="grdSubsARVs" runat="server" AutoGenerateColumns="False" AllowSorting="true"
                                                        Width="100%" BorderColor="white" PageIndex="1" BorderWidth="0" GridLines="None"
                                                        CssClass="datatable" CellPadding="0" CellSpacing="0">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <RowStyle CssClass="row" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Date" DataField="ChangeDate" />
                                                            <asp:BoundField HeaderText="Regimen" DataField="regimentype" />
                                                            <asp:BoundField HeaderText="Line" DataField="RegimenLine" />
                                                            <asp:BoundField HeaderText="Why" DataField="ChangeReason" />
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
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br />
        <div class="border center formbg">
            <table cellspacing="6" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td class="pad5 formbg border">
                            <div class="grid">
                                <div class="rounded">
                                    <div class="top-outer">
                                        <div class="top-inner">
                                            <div class="top">
                                                <h2>
                                                    <center>
                                                        ART Treatment Interruptions</center>
                                                </h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mid-outer">
                                        <div class="mid-inner">
                                            <div class="mid" style="height: 200px; overflow: auto">
                                                <div id="div-gridview2" class="gridviewbackup whitebg">
                                                    <asp:GridView ID="grdInteruptions" runat="server" AutoGenerateColumns="False" AllowSorting="true"
                                                        Width="100%" BorderColor="white" PageIndex="1" BorderWidth="0" GridLines="None" Height="20px"
                                                        CssClass="datatable" CellPadding="0" CellSpacing="0">
                                                        <%--<HeaderStyle   CssClass="tableheaderstyle" ForeColor="Blue"  Font-Underline="true"  HorizontalAlign="Left" />--%>
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <RowStyle CssClass="row" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Stop/Lost" DataField="StopLost" />
                                                            <asp:BoundField HeaderText="Date" DataField="ARTEndDate" />
                                                            <asp:BoundField HeaderText="Why" DataField="Reason" />
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
                        </td>
                    </tr> 
                     <tr>
                        <td colspan="2" class="form" > 
                            <asp:Panel ID="pnlCustomList" Visible="false" runat="server" Height="100%" Width="100%" Wrap="true">
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="form pad5 center" colspan="2">
                            <br />
                            <asp:Button ID="btn_save" Text="Save" runat="server" OnClick="btn_save_Click" />
                            <asp:Button ID="DQ_Check" Text="Data Quality check" runat="server" OnClick="DQ_Check_Click" />
                            <asp:Button ID="btn_close" Text="Close" runat="server" OnClick="btn_close_Click" />
                            <asp:Button ID="btn_print" Text="Print" runat="server" OnClientClick="WindowPrint()"
                                OnClick="btn_print_Click" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
