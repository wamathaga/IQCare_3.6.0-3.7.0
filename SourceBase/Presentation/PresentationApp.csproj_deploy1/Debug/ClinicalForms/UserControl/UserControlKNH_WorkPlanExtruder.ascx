﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControlKNH_WorkPlanExtruder.ascx.cs" Inherits="PresentationApp.ClinicalForms.UserControl.UserControlKNH_WorkPlanExtruder" %>
<div style="height: 900px; background-color: White">
    <br />

<table width="100%" border="0">
<tr>
<td class="form">
<div class="GridView whitebg" style="cursor: pointer;">
    <div class="grid">
        <div class="rounded">
            <div class="top-outer">
                <div class="top-inner">
                    <div class="top center">
                        <h2>
                            Work Plan</h2>
                    </div>
                </div>
            </div>
            <div class="mid-outer">
                <div class="mid-inner">
                    <div class="mid" style="height: auto; overflow: auto">
                        <div id="div-gridview" class="GridView whitebg">
                            <asp:GridView ID="grdWorkPlan" runat="server" 
                                AutoGenerateColumns="False" Width="100%"  BorderWidth="0"
                                GridLines="None" CssClass="datatable" CellPadding="0" CellSpacing="0">
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


