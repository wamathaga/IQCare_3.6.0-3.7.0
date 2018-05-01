<%@ Page Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    Inherits="frmScheduler_AppointmentNew" Title="Untitled Page" CodeBehind="frmScheduler_AppointmentNew.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="Server">
    <%--<link type="text/css" href="../Style/_assets/css/grid.css" rel="stylesheet" />
<link type="text/css" href="../Style/_assets/css/round.css" rel="stylesheet" />--%>
    <%--  <form id="appointmentnew" method="post" runat="server" enableviewstate="true" title="patientAppointmentNew">
    --%>
    <div style="padding-top: 20px; padding-left: 10px; padding-right: 10px;">
        <!--Modified 20June 2007 (6)-->
        <script language="javascript" type="text/javascript">
            function CheckDate(vDateName) {

                var mYear = vDateName.value.substr(7, 4)
                if (mYear != '') {
                    if (mYear < 1930) {
                        alert("Selected year should be between 1930 and Current year. Reenter..");
                        vDateName.value = "";
                        vDateName.focus();

                    }
                }
            }
            function getFormattedDate(input) {
                var pattern = /(.*?)\/(.*?)\/(.*?)$/;
                var result = input.replace(pattern, function (match, p1, p2, p3) {
                    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    return (p2 < 10 ? "0" + p2 : p2) + "-" + months[(p1 - 1)] + "-" + p3;
                });
                //alert(result);
                return result;
            }
            function noOfDays(days, newDate) {
                var daysValue = document.getElementById(days).value;
                //Bug ID 3279...added a new condition, if day value is less then 0.........
                if (daysValue < 0) {
                    alert("You can't book previous days appointment..");
                    document.getElementById(days).value = '';
                    document.getElementById(newDate).value = '';
                    document.getElementById(days).focus();
                    return;
                }
                // End Bug D 3279..........
                var someDate = new Date();
                var numberOfDaysToAdd = 0;
                if (daysValue == "") {
                    numberOfDaysToAdd = 0;
                }
                else {
                    numberOfDaysToAdd = parseInt(daysValue);
                }

                someDate.setDate(someDate.getDate() + numberOfDaysToAdd);

                var dd = someDate.getDate();
                var mm = someDate.getMonth() + 1;
                var y = someDate.getFullYear();

                //weekends
                var dayOfWeek = someDate.getDay();
                var isWeekend = (dayOfWeek == 6) || (dayOfWeek == 0);    // 6 = Saturday, 0 = Sunday
                if (isWeekend) {
                    var ans = confirm('Selected day is a weekend. Move date to following Monday?');
                    if (ans == true) {
                        if (dayOfWeek == 6) {
                            dd += 2;
                        }

                        if (dayOfWeek == 0) {
                            dd += 1;
                        }
                    }


                }
                var noofdaysinmonth = daysInMonth(mm, y);
                if (dd > noofdaysinmonth) {
                    dd = noofdaysinmonth - dd;
                    mm = mm + 1;
                }
                var someFormattedDate = new Date(mm + '/' + Math.abs(dd) + '/' + y);

                var curr_date = someFormattedDate.getDate();
                var curr_month = someFormattedDate.getMonth() + 1;
                var curr_year = someFormattedDate.getFullYear();
                var someFormattedDate1 = curr_month + "/" + curr_date + "/" + curr_year;

                document.getElementById(newDate).value = getFormattedDate(someFormattedDate1.toString());
            }
            function daysInMonth(month, year) {
                return new Date(year, month, 0).getDate();
            }
        </script>
        <!--Modified 20June 2007 (6)-->
        <h1 class="nomargin" id="header" runat="server">
            New Appointment</h1>
        <div class="border center formbg">
            <table class="center" width="100%" border="0" cellpadding="0" cellspacing="6">
                <%-- <tr>
                    <td class="form" align="center" colspan="2">
                        <label class="patientInfo">
                            Patient Name:</label>
                        <asp:Label ID="lblPatientNameValue" runat="server" Text="Mary Longlastname"></asp:Label>
                        <label id="lblpatientenrol" class="patientInfo" runat="server" ></label>
                        <asp:Label ID="lblPatientEnrollmentNoValue" runat="server" Text="444545"></asp:Label>
                        <label id="lblExisclinicID" class="patientInfo" runat="server"></label>
                        <asp:Label ID="lblHospitalNoValue" runat="server" Text="12345678-444444-596A"></asp:Label>
                       <%-- <label class="patientInfo">
                            Sex:</label>
                        <asp:Label ID="lblPatientGenderValue" runat="server" Text="female"></asp:Label>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <tr>
                    <td class="border pad5 whitebg" valign="top" width="50%" style="height: 39px">
                        <label class="required">
                            Appointment Date:</label>
                        <asp:TextBox ID="txtNoOfDays" runat="server" Width="34px"></asp:TextBox>
                        <asp:Label ID="Label3" runat="server" Font-Bold="False" Text="Days"></asp:Label>
                        <asp:TextBox ID="txtAppDate" MaxLength="11" runat="server"></asp:TextBox>
                        <img src="../images/cal_icon.gif" height="22" alt="Date Helper" onclick="w_displayDatePicker('<%= txtAppDate.ClientID %>');"
                            style="vertical-align: bottom; margin-bottom: 2px;" />
                        <span class="smallerlabel">(DD-MMM-YYYY)</span>
                    </td>
                    <td class="border pad5 whitebg" align="center" width="50%" style="height: 39px">
                        <label class="required">
                            Purpose:</label>
                        <asp:DropDownList ID="ddAppPurpose" runat="server" AutoPostBack="false" Width="125px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="border pad5 whitebg" align="center" colspan="2" style="height: 32px">
                        <label class="right15 required" style="width: 17%">
                            Provider:&nbsp;</label><asp:DropDownList ID="ddAppProvider" runat="server" AutoPostBack="false"
                                Width="125px">
                            </asp:DropDownList>
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="border pad5 whitebg" align="center" colspan="2" style="height: 24px">
                        <asp:Button ID="btnSubmit" runat="server" Text="Save" OnClick="btnSubmit_Click" Enabled="True" />
                        <asp:Button ID="btndelete" runat="server" Text="Delete" OnClick="btndelete_Click"
                            Visible="false" />
                        <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Enabled="True" />
                        <asp:Button ID="theBtn" Text="OK" CssClass="textstylehidden" runat="server" OnClick="theBtn_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="border pad5 whitebg" valign="top" colspan="2">
                        <div class="grid">
                            <div class="rounded">
                                <div class="top-outer">
                                    <div class="top-inner">
                                        <div class="top">
                                            <h2>
                                                Appointments</h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="mid-outer">
                                    <div class="mid-inner">
                                        <div class="mid" style="cursor: pointer; height: 280px; overflow: auto; border: 1px solid #666699;">
                                            <div id="div-gridview" class="GridView whitebg">
                                                <asp:GridView ID="grdSearchResult" AllowSorting="True" runat="server" CssClass="datatable"
                                                    CellPadding="0" CellSpacing="0" AutoGenerateColumns="False" Width="100%" PageSize="1"
                                                    BorderWidth="0" GridLines="None" OnSorting="grdSearchResult_Sorting" OnRowDataBound="grdSearchResult_RowDataBound"
                                                    OnSelectedIndexChanging="grdSearchResult_SelectedIndexChanging">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <%--<AlternatingRowStyle BackColor="White" BorderColor="White" />--%>
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
            </table>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
    </script>
</asp:Content>
