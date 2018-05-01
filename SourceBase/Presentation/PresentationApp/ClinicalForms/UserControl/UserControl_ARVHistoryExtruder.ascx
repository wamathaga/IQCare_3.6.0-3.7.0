﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControl_ARVHistoryExtruder.ascx.cs" Inherits="PresentationApp.ClinicalForms.UserControl.UserControl_ARVHistoryExtruder" %>


<style type="text/css">
    .style1
    {
        width: 100%;
    }
    
</style>


<div class="center">
<table width="100%" cellspacing="3">
    <tr>
        <td>
            <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Last Regimen:"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblLastRegimen" runat="server" Font-Bold="True"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="2">
        <div class="GridView whitebg" style="cursor: pointer;">
                    <div class="grid">
                        <div class="rounded">
                            <div class="top-outer">
                                <div class="top-inner">
                                    <div class="top">
                                        <h2>
                                            ARV History</h2>
                                    </div>
                                </div>
                            </div>
                            <div class="mid-outer">
                                <div class="mid-inner">
                                    <div class="mid" style="height: auto; overflow: auto">
                                        <div id="div-gridview" class="GridView whitebg">
                                            <asp:GridView ID="grdARVHistory" runat="server" Width="100%"  BorderWidth="0"
                                                GridLines="None" CssClass="datatable" CellPadding="0" CellSpacing="0" 
                                                AutoGenerateColumns="False">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
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
                </div>
         </td>
    </tr>
</table>
</div>


