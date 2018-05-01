<%@ Page Language="C#" AutoEventWireup="true" Inherits="frmLogin"
    EnableViewState="true" Codebehind="frmLogin.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html lang="en-US" xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>International Quality Care Patient Management and Monitoring System</title>
    <link rel="stylesheet" type="text/css" href="Style/styles.css" />
   
</head>
<script language="javascript" type="text/javascript">
    
    function fnHelp() {
        var path = frmLogin.CallHelp().value;
        window.location.href = path;
        //window.showHelp("./IQCareHelp/IQCareARUserManualSep2010.chm")
    }
    function CloseWindow() {
        window.focus();
    }
</script>
<body>
    <form id="signIn" style="width: 100%" enableviewstate="true" runat="server">
    <div class="loginpageheight">
        <div class="utility" align="right">
            <a class="utility" href="frmLogin.aspx" onclick="window.open('./IQCareHelp/index.html'); return false">
                Help</a>
        </div>
        <div id="main">
            <div id="bluetop">
            </div>
            <img id="logo" height="94" alt="International Quality Care " src="./images/iq_logo.gif"
                width="236" border="0" />
            <img id="pmms" height="53" alt="Patient Management and Monitoring System" src="./images/pmms.gif"
                width="264" border="0" />
            <img id="collage" height="117" alt="" src="./images/collage.jpg" width="424" border="0" />
            <div id="username">
                <asp:Label ID="lblUserName" runat="server" Text="Lanette Burrows"></asp:Label></div>
            <div id="date" align="right">
                <asp:Label ID="lblDate" runat="server" Text="30 September 2006"></asp:Label></div>
            <div id="border">
            </div>
            <img id="tabfacility" height="23" alt="Facility Name" src="./images/tab_facility.gif"
                width="377" border="0" />
            <div id="facility">
                <asp:Label ID="lblLocation" runat="server" Text="Nsambya Hospital and Medical Center"></asp:Label></div>
            <div style="padding-top: 140px;">
                <!-- begin content area -->
                <table class="border" cellspacing="0" cellpadding="0" width="750" align="center"
                    border="0">
                    <tbody>
                        <tr>
                            <td style="border-right: #666699 1px solid;" width="500">
                                <asp:Image ID="imgLogin" runat="server" ImageUrl="~/Images/signin.jpg" Width="500px"
                                    Height="305px" />
                            </td>
                            <td class="login" style="width: 250px">
                                <h2 class="nomargin">
                                    Login</h2>
                                <asp:ScriptManager ID="mst" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdateMasterLink" runat="server">
                                    <ContentTemplate>
                                        <!-- note: method set to get for demo -->
                                        <table width="100%" border="0">
                                            <tr>
                                                <td class="pad18">
                                                    <label>
                                                        Username</label>
                                                    <asp:TextBox ID="txtuname" runat="server" Width="210px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="pad18">
                                                    <label for="password">
                                                        Password</label>
                                                    <asp:TextBox ID="txtpassword" TextMode="Password" runat="server" Width="210px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="pad18">
                                                    <asp:CheckBox ID="chkPref" runat="server" Text="Preferred Location" AutoPostBack="true"
                                                        OnCheckedChanged="chkPref_CheckedChanged" />
                                                    <label>
                                                        Facility/Satellite</label>
                                                    <asp:DropDownList ID="ddLocation" runat="server" Width="210px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="button" align="center">
                                                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                        <%-- <fieldset class="noborder loginpad">
                                            <br>
                                            <div style="padding-top: 5px">
                                            </div>
                                           <br>
                                            <div style="padding-top: 5px">
                                            </div>
                                           <br />
                                            <legend class="signinbutton">
                                                </legend>
                                        </fieldset>--%>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="chkPref" />
                                        <asp:PostBackTrigger ControlID="btnLogin" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <h3 class="nomargin">
                                    Recommendation</h3>
                                <table>
                                    <tr>
                                        <td>
                                            <p class="blue11 nomargin textjustify">
                                                IQCare is best viewed on Internet Explorer 8. Web site visitors using earlier versions
                                                of this or other browsers may encounter occasional format anomalies when viewing
                                                pages from this web site.</p>
                                        </td>
                                        <td>
                                            <img height="36" src="./Images/ribbon.gif" width="20" align="right" vspace="5" border="0" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table width="900">
                    <tr style="width: 100%">
                        <td align="left" style="width: 50%">
                            <p><a href="http://futuresgroup.com/ " onclick="window.open('http://futuresgroup.com/ '); return false">
                                <img src="./Images/FGI.jpg" width="70" vspace="5" border="0" /></a>
                            </p>
                        </td>
                        <td align="right" style="width: 50%">
                            <label class="right" style="width: 300">
                                Version :
                                <asp:Label CssClass="blue11 nomargin" ID="lblversion" Text="Version B1.0" runat="server"></asp:Label></label>
                            <br />
                            <label class="right" style="width: 300">
                                Release Date :
                                <asp:Label CssClass="blue11 nomargin" ID="lblrelDate" Text="Date" runat="server"></asp:Label></label>
                        </td>
                    </tr>
                </table>
                <!-- end content area -->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
