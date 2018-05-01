<%@ Page Language="c#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    Inherits="frmPatient_Home" Title="untitled page" MaintainScrollPositionOnPostback="true"
    CodeBehind="frmpatient_home.aspx.cs" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<%@ MasterType VirtualPath="~/ClinicalForms/ClinicalHomeHeaderFooter.master" %>--%>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<%--<%@ Register src="wucDebitNote.ascx" tagname="wucDebitNote" tagprefix="uc1" %>--%>
<asp:Content ID="content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script language="javascript" type="text/javascript">
        function fnSetSession(url) {
            //var result=frmFindAddPatient.SetPatientId_Session(url).value;
            //alert(url);
            window.open(url, 'ab', 'toolbars=no,location=no,directories=no,dependent=yes,top=10,left=30,maximize=no,resize=no,width=800,height=700,scrollbars=yes');

        }
        function fnSetalert(url) {
            //alert('');
        }
                    
    </script>
    <%--    <form id="PatientHome" method="post" runat="server">--%>
    <div style="padding-left: 8px; padding-right: 8px; padding-top: 2px;">
        <%--<tr>
                        <td>
                            <label class="bold">
                                <asp:Label ID="lblenroll" runat="server" Visible="false">Enroll#:</asp:Label>
                                <asp:Label ID="lblptnenrollment" runat="server" Visible="false"></asp:Label>
                            </label>
                        </td>
                        <td>
                            <label class="bold">
                                <asp:Label ID="lblClinicNo" runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="lblexistingid" runat="server" Visible="false"></asp:Label>
                            </label>
                        </td>
                    </tr>--%>
        <%--   <asp:ScriptManager ID="mst" runat="server">
        </asp:ScriptManager> --%>
        <asp:UpdatePanel ID="UpdateMasterLink" runat="server">
            <ContentTemplate>
                <table width="100%" border="0">
                    <tr>
                        <td>
                            <h1 class="marginpHome" id="tHeading">
                                 Patient Home</h1>
                        </td>
                        <td>
                            <h1 class="marginpHome" id="lblServiceArea" runat="server" align='right'>Service Area
                            </h1>
                        </td>
                    </tr>
                </table>
              
                <div>
                    <table width="100%">
                        <tbody>
                            <tr>
                                <td colspan="4">
                                </td>
                                <td align="right">
                                    <div>
                                        <asp:Button ID="btnReactivate" runat="server" Text="Reactivate Patient" Font-Bold="true"
                                            BorderColor="#99cc66" Visible="false" OnClick="btnReactivate_Click" Style="background-color: #99cc66;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                </td>
                                <td>
                                    <%--<div align="Left">
                                <asp:Button ID="btnPMTCTReactivate" runat="server" Text="Reactivate PMTCT Patient"
                                    Font-Bold="true" BorderColor="#99cc66" OnClick="btnPMTCTReactivate_Click" Style="background-color: #99cc66" />
                            </div>--%>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%" align="left">
                                    <label class="bold">
                                        Patient Name:
                                        <asp:Label ID="lblpatientname" runat="server"></asp:Label></label>
                                </td>
                                <td style="width: 20%;" align="left">
                                    <label class="bold">
                                        DOB:
                                        <asp:Label ID="lbldob" runat="server"></asp:Label></label>
                                </td>
                                <td style="width: 10%;" align="left">
                                    <label class="bold">
                                        Age:
                                        <asp:Label ID="lblage" runat="server"></asp:Label></label>
                                </td>
                                <td style="width: 10%" align="left">
                                    <label class="bold">
                                        Sex:
                                        <asp:Label ID="lblgender" runat="server"></asp:Label></label>
                                </td>
                                <td style="width: 35%;" align="left">
                                    <div class="bold">
                                        Patient Status:
                                        <asp:Label ID="lblptnstatus" runat="server" Text="" Font-Bold="true"></asp:Label><br />
                                        <asp:Label ID="lbloutofstock" runat="server" Font-Bold="true" ForeColor="Red" Visible="false"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%" align="left">
                                    &nbsp;
                                    <div id="divAddChildren" style="background-color: white">
                                        <asp:Button ID="btnAddChildren" runat="server" Text="Add/Show Children" Font-Size="XX-Small"
                                            Font-Bold="true" OnClick="btnAddChildren_Click" />
                                        <asp:Button ID="btnShowMother" runat="server" Text="Show Mother" Visible="false"
                                            OnClick="btnShowMother_Click" />
                                        <asp:HiddenField ID="hpIQNumber" runat="server" />
                                    </div>
                                </td>
                                <%--<td style="width: 25%" align="left">
                            &nbsp;
                            <div id="divAddExposedInfant" style="background-color: white">
                                <asp:Button ID="btnAddExposedInfant" runat="server" Text="Add Exposed Infant" OnClick="btnAddExposedInfant_Click" />
                            </div>
                        </td>--%>
                                <td colspan="3" style="width: 25%;" align="left">
                                    <%--<label class="bold">
                                        Service Last Visited:--%>
                                        <asp:Label CssClass="required" ID="lblTechVisited" runat="server" Text="" Visible="false"></asp:Label>
                                    <%--</label>--%>
                                </td>
                                <td style="width: 25%;" align="left">
                                    <div>
                                        <asp:LinkButton ID="btnTechChange" runat="server" OnClick="btnTechChange_Click">Find Different Patient</asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                            <td>
                            <telerik:RadAjaxPanel ID="pnlnotification" runat="server"/>
                            </td>
                            </tr>
                            <%--<tr>
                        <td>
                            <label class="bold">
                                <asp:Label ID="lblenroll" runat="server" Visible="false">Enroll#:</asp:Label>
                                <asp:Label ID="lblptnenrollment" runat="server" Visible="false"></asp:Label>
                            </label>
                        </td>
                        <td>
                            <label class="bold">
                                <asp:Label ID="lblClinicNo" runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="lblexistingid" runat="server" Visible="false"></asp:Label>
                            </label>
                        </td>
                    </tr>--%>
                        </tbody>
                    </table>
                    <div class="border" style="width: 100%">
                        <table width="100%" border="0" style="height: 426px">
                            <tbody align="left">
                                <tr align="left">
                                    <td style="width: 100%" align="left">
                                        <div id="TabDiv" runat="server">
                                            <act:TabContainer ID="tabControl" runat="server" Height="550px" ActiveTabIndex="0"
                                                CssClass="ajax__tab_technorati-theme">
                                                <act:TabPanel ID="tbpnlgeneral" runat="server" Font-Size="Medium" HeaderText="General">
                                                    <HeaderTemplate>
                                                        General
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table cellspacing="0" cellpadding="0" border="0">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <h2 class="forms" align="left">
                                                                                    Contact Information</h2>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                Patient Phone:
                                                                            </td>
                                                                            <td style="width: 40%">
                                                                                <asp:Label ID="lblpatientphone" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                <asp:Label ID="lblShowAddress" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lbladdress" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                <asp:Label ID="lblEmrContact" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblemergencycontact" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                <asp:Label ID="lblEmrPhone" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblemgphone" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 104px; height: 15px;" colspan="2">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <h2 align="left" class="forms">
                                                                                    Family Information</h2>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" colspan="2 ">
                                                                                <asp:Label ID="lblhivpositivemother" runat="server" Font-Bold="True" Visible="False"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                No. of related members enrolled:
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:Label ID="lblfamilyEnrolled" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                No. of related members on ART:
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:Label ID="lblfamilyArt" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18">
                                                                                <asp:HyperLink ID="hlFamilyInfo" runat="server" CssClass="utility" Visible="False">Family Information</asp:HyperLink>
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:Image ID="imgfamily" runat="server" Visible="False" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 104px; height: 15px;" colspan="2">
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <h2 align="left" class="forms">
                                                                                    Clinical Information</h2>
                                                                            </td>
                                                                            <td>
                                                                                <asp:LinkButton ID="lnkPharmacyNotes" runat="server" OnClick="lnkPharmacyNotes_Click">View Prescription Notes</asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" colspan="2">
                                                                                <asp:Label ID="lblPregnant" runat="server" Visible="False"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%; height: 16px">
                                                                                Last Recorded WAB:
                                                                            </td>
                                                                            <td style="height: 16px;">
                                                                                <asp:Label ID="lblWABStage" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%; height: 16px">
                                                                                WHO Stage:
                                                                            </td>
                                                                            <td style="height: 16px;">
                                                                                <asp:Label ID="lblWHOStage" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%; height: 16px">
                                                                                Weight:
                                                                            </td>
                                                                            <td style="height: 16px;">
                                                                                <asp:Label ID="lblweight" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%; height: 16px">
                                                                                Lowest CD4:
                                                                            </td>
                                                                            <td style="height: 16px;">
                                                                                <asp:Label ID="lblLowestCD4" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="height: 16px; width: 30%;">
                                                                                Most Recent CD4:
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblRecentCD4" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="height: 16px; width: 30%;">
                                                                                Next CD4 Due:
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblCD4Due" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="height: 16px; width: 30%;">
                                                                                <asp:Label ID="lblnexthivstatuscheck" runat="server" Visible="False" Text="Next HIV Status Check"></asp:Label>
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblnexthivscheck" runat="server" Width="134px" Visible="False"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="height: 16px; width: 30%;">
                                                                                HCT:
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblHB" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%; height: 16px;">
                                                                                HB:
                                                                            </td>
                                                                            <td style="height: 16px;">
                                                                                <asp:Label ID="lblHCT" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                AST:
                                                                            </td>
                                                                            <td style="height: 16px;">
                                                                                <asp:Label ID="lblAST" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                Cr:
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblCr" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                Syphilis:
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblSyphilis" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="bold pad18" style="width: 30%">
                                                                                Pregnancy Test:
                                                                            </td>
                                                                            <td style="height: 16px">
                                                                                <asp:Label ID="lblPregnancyTest" runat="server" Width="134px"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <td class="border" style="width: 40%" align="center" valign="top">
                                                                        <table>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>
                                                                                        <h3 align="center">
                                                                                            Weight and BMI over time
                                                                                        </h3>
                                                                                        <table cellspacing="0" cellpadding="0" width="271" border="0">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <chart:WebChartViewer ID="WebChartViewerWeight" runat="server" Height="400px" Width="300px" />
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:Button ID="btnWeightChart" runat="server" Text="View Larger Graph" Font-Bold="true"
                                                                                                        OnClick="btnWeightChart_Click" Style="background-color: #99cc66" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 104px; height: 15px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <h3 align="center">
                                                                                            CD4 Count and Viral Load over time</h3>
                                                                                        <table cellspacing="0" cellpadding="0" width="271" border="0">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <chart:WebChartViewer ID="WebChartViewerCD4VL" runat="server" Height="400px" Width="300px" />
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:Button ID="btnCD4Graph" runat="server" Text="View Larger Graph" Font-Bold="true"
                                                                                                        OnClick="btnCD4Graph_Click" Style="background-color: #99cc66" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </act:TabPanel>
                                                <act:TabPanel ID="tbpnldynamic" runat="server">
                                                    <ContentTemplate>
                                                        <asp:Panel ID="thePnl" Width="100%" runat="server">
                                                        </asp:Panel>
                                                    </ContentTemplate>
                                                </act:TabPanel>
                                                <act:TabPanel ID="TabPanelPatientCosts" runat="server" HeaderText="Patient Costs">
                                                    <ContentTemplate>
                                                        <h2 class="forms" align="left">
                                                            <asp:Label ID="Label1" runat="server" Text="HIV Care Program Costs"></asp:Label>
                                                        </h2>
                                                        <table width="100%">
                                                            <tr>
                                                                <th class="bold pad18">
                                                                    Patient Cost Per Debit Note
                                                                </th>
                                                                <th class="bold pad18">
                                                                    &nbsp;
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <td width="50%">
                                                                    <div class="grid">
                                                                        <div id="div-gridview" class="gridviewdebitnote whitebg">
                                                                            <asp:GridView ID="GridViewSummary" runat="server" AutoGenerateColumns="False" CssClass="datatable"
                                                                                GridLines="None" OnRowCommand="GridViewSummary_RowCommand">
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td width="50%" style="text-align: center">
                                                                    <html>
                                                                    <head id="Head1">
                                                                        <%-- <title>Facility.Reports</title>
                    <style type="text/css">
                    html, body {
                        height: 100%;
                        overflow: auto;
                    }
                    body {
                        padding: 0;
                        margin: 0;
                    }
                    #silverlightControlHost {
                        height: 100%;
                        text-align:center;
                    }
                    </style>--%>
                                                                        <script type="text/javascript" src="../Incl/Silverlight.js"></script>
                                                                        <script type="text/javascript">
                                                                            function onSilverlightError(sender, args) {
                                                                                var appSource = "";
                                                                                if (sender != null && sender != 0) {
                                                                                    appSource = sender.getHost().Source;
                                                                                }

                                                                                var errorType = args.ErrorType;
                                                                                var iErrorCode = args.ErrorCode;

                                                                                if (errorType == "ImageError" || errorType == "MediaError") {
                                                                                    return;
                                                                                }

                                                                                var errMsg = "Unhandled Error in Silverlight Application " + appSource + "\n";

                                                                                errMsg += "Code: " + iErrorCode + "    \n";
                                                                                errMsg += "Category: " + errorType + "       \n";
                                                                                errMsg += "Message: " + args.ErrorMessage + "     \n";

                                                                                if (errorType == "ParserError") {
                                                                                    errMsg += "File: " + args.xamlFile + "     \n";
                                                                                    errMsg += "Line: " + args.lineNumber + "     \n";
                                                                                    errMsg += "Position: " + args.charPosition + "     \n";
                                                                                }
                                                                                else if (errorType == "RuntimeError") {
                                                                                    if (args.lineNumber != 0) {
                                                                                        errMsg += "Line: " + args.lineNumber + "     \n";
                                                                                        errMsg += "Position: " + args.charPosition + "     \n";
                                                                                    }
                                                                                    errMsg += "MethodName: " + args.methodName + "     \n";
                                                                                }

                                                                                throw new Error(errMsg);
                                                                            }
                                                                        </script>
                                                                    </head>
                                                                    <body>
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%;">
                                                                            <tr>
                                                                                <td>
                                                                                    <div id="silverlightControlHost">
<%--                                                                                        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2"
                                                                                            width="100%" height="100%">
                                                                                            <param name="source" value="../ClientBin/Facility.Reports.xap" />
                                                                                            <param name="onError" value="onSilverlightError" />
                                                                                            <param name="minRuntimeVersion" value="3.0.40818.0" />
                                                                                            <param name="autoUpgrade" value="true" />
                                                                                            <param name="initparams" value="<%=string.Format("TranDateFrom={0}, TranDateTo={1}, ReportID={2}, PatientID={3}", "", "", 2, Session["PatientId"]) %>" />
                                                                                            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=3.0.40818.0" style="text-decoration: none">
                                                                                                <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight"
                                                                                                    style="border-style: none" />
                                                                                        </object>--%>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </body>
                                                                    </html>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="width: 100%" width="50%">
                                                                    <div class="grid">
                                                                        <div id="div1" class="gridviewDebitNote whitebg">
                                                                            <asp:GridView ID="GridViewTran" runat="server" AutoGenerateColumns="False" CssClass="datatable"
                                                                                GridLines="None" AllowSorting="True">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="TransactionDate" HeaderText="Transaction Date" HeaderStyle-Width="15%"
                                                                                        DataFormatString="{0:dd-MMM-yyyy}" ReadOnly="True" />
                                                                                    <asp:BoundField DataField="Description" HeaderText="Description" HeaderStyle-Width="25%"
                                                                                        ReadOnly="True" />
                                                                                    <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" HeaderStyle-Width="15%" />
                                                                                    <asp:BoundField DataField="Adminsitration" HeaderText="Administration" ReadOnly="True"
                                                                                        HeaderStyle-Width="15%" />
                                                                                    <asp:BoundField DataField="Cost" HeaderText="Actual Price" ReadOnly="True" HeaderStyle-Width="15%" />
                                                                                    <asp:BoundField DataField="ChargedPrice" HeaderText="Charged Price" ReadOnly="True"
                                                                                        HeaderStyle-Width="15%" />
                                                                                </Columns>
                                                                                <RowStyle CssClass="row" />
                                                                                <EmptyDataTemplate>
                                                                                    <span style="text-align: center">Select a debit note above to see details here.
                                                                                    </span>
                                                                                </EmptyDataTemplate>
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </act:TabPanel>
                                            </act:TabContainer>
                                            <%--<asp:Menu ID="tabControl" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab"
                                    StaticSelectedStyle-CssClass="selectedTab" CssClass="tabs" OnMenuItemClick="Menu_MenuItemClick"
                                    Runat="server" width:160px ForeColor="Black">
                                    <StaticSelectedStyle CssClass="selectedTab" />
                                    <StaticMenuItemStyle CssClass="tab" />
                                    <items>
                                        <asp:MenuItem Text="General" Value="0" Selected="true" />
                                        <asp:MenuItem Text="HIVCARE-STATIC FORM" Value="2" />
                                        <asp:MenuItem Text="PMTCT" Value="1" />
                                    </items>
                                </asp:Menu>--%>
                                        </div>
                                    </td>
                                </tr>
                                <%--<div class="tabContents">--%>
                                <tr valign="top">
                                    <td style="width: 60%; height: auto">
                                        <asp:MultiView ID="TabView" ActiveViewIndex="0" runat="server">
                                            <asp:View ID="ViewGeneral" runat="server">
                                            </asp:View>
                                            <asp:View ID="ViewPMTCT" runat="server">
                                                <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblpmtct" runat="server">
                                                    <tr>
                                                        <td colspan="2">
                                                            <h2 class="forms" align="left">
                                                                PMTCT Identification Information</h2>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:Label ID="lblanc" runat="server">ANC Number:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblancno" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:Label ID="lblpmtct" runat="server">PMTCT Number:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblpmtctno" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:Label ID="lbladmission" runat="server">Admission Number:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbladmissionno" runat="server"></asp:Label></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:Label ID="lbloutpatient" runat="server">Outpatient Number:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbloutpatientno" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <h2 class="forms" align="left">
                                                                PMTCT Information</h2>
                                                        </td>
                                                    </tr>
                                                    <%--  <tr>
                                    <td class="bold pad18" style="width: 50%; height: 16px;">
                                        PMTCT Status:
                                    </td>
                                    <td>
                                        <asp:Label ID="lblpmtctstatus" runat="server"></asp:Label>
                                    </td>
                                </tr>--%>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            LMP
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLMP" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            EDD
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblEDD" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            Gestational Age (Weeks)
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblGestAge" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            Current ARV Prophylaxis Regimen
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblARVProRegimen" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            Current ARV Prophylaxis Start Date
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblARVProStartDate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            TB Status
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTBStatus" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            Partner HIV Status
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPartnerHIVStatus" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px;">
                                                            Last Visit
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastVisit" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <h2 class="forms" align="left">
                                                                Exposed Infant Information</h2>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px">
                                                            Date of Birth (Current Pregnancy)
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDeliveryDate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px">
                                                            Infant Prophylaxis Regimen
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblInfantProphylaxisRegimen" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <%--   <tr>
                                    <td class="bold pad18" style="width: 50%; height: 16px;">
                                        Latest Child Delivered?
                                    </td>
                                    <td>
                                        <asp:Label ID="lblChildDelivered" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bold pad18" style="width: 50%; height: 16px;">
                                        Latest Child Delivery Date:
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDeliveryDate" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bold pad18" style="width: 50%; height: 16px;">
                                        Child HIV Status:
                                    </td>
                                    <td>
                                        <asp:Label ID="lblChildHIVStatus" runat="server"></asp:Label>
                                    </td>
                                </tr>--%>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 50%; height: 16px">
                                                            Feeding Option
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblFeedingOption" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" colspan="2">
                                                            <div id="divResult" runat="server">
                                                                <asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" colspan="2">
                                                            <asp:Panel ID="DynControlPMTCT" runat="server">
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <%--<tr>
                                
                                 <td class="pad18" style="width: 50%; height: 16px; ">  
                                        PCR
                                    </td>
                                </tr>
                                
                                <tr>
                                 <td class="pad18" style="width: 50%; height: 16px; ">  
                                        PCR
                                    </td>
                                </tr>
                                <tr>
                                 <td class="pad18" style="width: 50%; height: 16px; ">  
                                        HIV Rapid (Confirmatory)
                                    </td>
                                </tr>--%>
                                                    <%-- <tr>
                                    <td class="bold pad18" style="width: 50%; height: 16px;">
                                        Weaning Date:
                                    </td>
                                    <td>
                                        <asp:Label ID="lblWeaningDate" runat="server"></asp:Label>
                                    </td>
                                </tr>--%>
                                                </table>
                                            </asp:View>
                                            <asp:View ID="ViewART" runat="server">
                                                <table cellspacing="0" cellpadding="0" width="100%" border="0" runat="server" id="tbhiv">
                                                    <tr>
                                                        <td colspan="2">
                                                            <h2 class="forms" align="left">
                                                                HIVCare Static Form Identification Information</h2>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:Label ID="lblenroll" runat="server">Enroll#:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblptnenrollment" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:Label ID="lblClinicNo" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblexistingid" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <h2 class="forms" align="left">
                                                                ART Information</h2>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            ART/Palliative Care:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblprogram" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            Current ARV Regimen:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblarvregimen" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            Current ARV Start Date:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblarvstartdate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            ARV Start Date At This Facility:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblaidsrstartdate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            Historical ART Start Date:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblhistoricalsdate" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            Last Visit:
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbllstvisit" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18">
                                                            Next Appointment:
                                                        </td>
                                                        <td style="height: 19px">
                                                            <asp:Label ID="lblnextapp" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" style="width: 40%">
                                                            <asp:HyperLink ID="hlFollowupeducation" Visible="false" CssClass="utility" runat="server">Follow-up Education</asp:HyperLink>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Image ID="imgFollowupeducation" Visible="false" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold pad18" colspan="2">
                                                            <asp:Panel ID="DynControlsARV" runat="server">
                                                            </asp:Panel>
                                                        </td>
                                                        <%--<a class="link" href="" id="lnkSchedule" runat="server" visible="false">Schedule Appointment</a>--%>
                                                    </tr>
                                                </table>
                                            </asp:View>
                                            <asp:View ID="ViewDynamic" runat="server">
                                                <%--<asp:Panel id="thePnl" width="100%" runat="server">
                                    </asp:Panel>--%>
                                            </asp:View>
                                        </asp:MultiView>
                                    </td>
                                </tr>
                                <%--</div>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnAddChildren"></asp:PostBackTrigger>
                <%--<asp:PostBackTrigger ControlID="GridViewSummary"></asp:PostBackTrigger>--%>
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
