<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true"
    CodeBehind="frmAdmin_ItemManagement.aspx.cs" Inherits="PresentationApp.AdminForms.frmAdmin_ItemManagement"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="act" Namespace="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <script type="text/javascript" language="javascript">

        function ShowHide(theDiv, YN, theFocus) {
            $(document).ready(function () {

                if (YN == "show") {
                    //                    $("#" + theDiv).slideDown();
                    $("#" + theDiv).show();

                }
                if (YN == "hide") {
                    //                    $("#" + theDiv).slideUp();
                    $("#" + theDiv).hide();


                }

            });

        }
        function ShowMore(sender, eventArgs) {
            var substr = eventArgs._commandArgument.toString().split('|')
            ShowHide(substr[0], substr[1]);
        }

        function PopulateItmSubT(value) {
            //alert($('#<%=ddlItemSubType.ClientID %>').val('Analgesic'));
            $('#<%=ddlItemSubType.ClientID %> option:eq(' + value + ')').attr('selected', true);
            //$('#<%=ddlItemSubType.ClientID %>').val('Analgesic').prop('selected', true);
            //$('#<%=ddlItemSubType.ClientID %>').val('Analgesic').attr('selected', 'selected');
            //$('#<%=ddlItemSubType.ClientID %>').val('Analgesic')
            //            var objSelect = document.getElementById("<%=ddlItemSubType.ClientID %>");
            //            setSelectedValue(objSelect, 'Analgesic');
        }
        function setSelectedValue(selectObj, valueToSet) {
            for (var i = 0; i < selectObj.options.length; i++) {
                //alert(selectObj.options[i].text);
                if (selectObj.options[i].text == valueToSet) {
                    selectObj.options[i].selected = true;
                    return;
                }
            }
        }
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

        function rblSelectedValueNo(rbl, divID) {
            var selectedvalue = $("#" + rbl.id + " input:radio:checked").val();
            if (selectedvalue == "0") {
                YN = "show";
            }
            else {
                YN = "hide";
            }
            ShowHide(divID, YN);
        }
        //Checkbox list
        function getCheckBoxValue(DivId, chktext, str) {
            var YN = "";
            var id = "#" + CheckBoxID;
            if ($(id).is(':checked')) {
                YN = "show";
            }
            else {
                YN = "hide";
            }
            ShowHide(CheckBoxID, YN);
        }
        //DropDown list
        function getSelectedValue(DivId, DDText, str) {
            var e = document.getElementById(DDText);
            var text = e.options[e.selectedIndex].innerText;
            var YN = "";
            if (text == str) {
                YN = "show";
            }
            else {
                YN = "hide";
            }
            ShowHide(DivId, YN);
        }
        function CheckBoxToggleShowHideKNHAdultIE(divID, val, txt) {
            var checkList = document.getElementById(val);
            var checkBoxList = checkList.getElementsByTagName("input");
            var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
            var checkBoxSelectedItems = new Array();
            for (var i = 0; i < checkBoxList.length; i++) {

                if (checkBoxList[i].checked) {
                    if (arrayOfCheckBoxLabels[i].innerText.trim() == txt) {
                        ShowHide(divID, "show");
                        break;
                    }
                }
                else {
                    if (arrayOfCheckBoxLabels[i].innerText == txt) {
                        ShowHide(divID, "hide");
                    }

                }
            }

        }
        function WindowPrintAll() {
            window.print();
        }
        function fnUncheckall(strcblcontrolId) {
            var checkList = document.getElementById(strcblcontrolId);
            var checkBoxList = checkList.getElementsByTagName("input");
            var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
            var checkBoxSelectedItems = new Array();

            for (var i = 1; i < checkBoxList.length; i++) {
                checkBoxList[i].checked = false;
            }
        }
        function fnUncheckNormal(strcblcontrolId) {
            var checkList = document.getElementById(strcblcontrolId);
            var checkBoxList = checkList.getElementsByTagName("input");
            var arrayOfCheckBoxLabels = checkList.getElementsByTagName("label");
            var checkBoxSelectedItems = new Array();
            checkBoxList[0].checked = false;

        }
        function ace1_itemSelected(source, e) {
            var results = eval('(' + e.get_value() + ')');

            var index = source._selectIndex;
            if (index != -1) {
                //source.get_element().value = removeHTMLTags(source.get_completionList().childNodes[index]._value);
                var hdCustID = $get('<%= hdCustID.ClientID %>');
                hdCustID.value = results.ItemId;

            }
        }
        $(function () {
            $("#dialog").dialog({
                autoOpen: false,
                modal: true,
                title: "Details",
                buttons: {
                    Close: function () {
                        $(this).dialog('close');
                    }
                }
            });
            $("#btnbatchsummary").click(function () {
                $.ajax({
                    type: "POST",
                    url: "frmAdmin_ItemManagement.aspx/SendParameters",
                    data: "{name: '" + $("#txtName").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        $("#dialog").html(r.d);
                        $("#dialog").dialog("open");
                    }
                });
            });
        });

        var pageUrl = '<%=ResolveUrl("frmAdmin_ItemManagement.aspx")%>'
        function PopulateContinents() {
            $("#<%=ddlItemSubType.ClientID%>").attr("disabled", "disabled");

            if ($('#<%=ddlItemType.ClientID%>').val() == "0") {
                $('#<%=ddlItemSubType.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
            }
            else {
                $('#<%=ddlItemSubType.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/PopulateItemSubType',
                    data: '{ItemTypeId: ' + $('#<%=ddlItemType.ClientID%>').val() + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnCountriesPopulated,
                    failure: function (response) {
                        alert(response.d);
                    },
                    
                });

                //Get DropDownList selected value
                var selectedValue = $('#<%=ddlItemType.ClientID %>').val();
                EnableDisablePharma(selectedValue);
               
            }
        }


        function EnableDisablePharma(selectedValue){
         //Enable Controls
                if (selectedValue == 300) {
                //alert(selectedValue);
                    $('#<%=lstGeneric.ClientID %>').prop('disabled', false);
                    $('#<%=txtDrugAbbre.ClientID %>').prop('disabled', false);
                    $('#<%=btnAddGeneric.ClientID %>').prop('disabled', false);
                    $('#<%=lstStrength.ClientID %>').prop('disabled', false);
                    $('#<%=btnAddDose.ClientID %>').prop('disabled', false);
                    $('#<%=txtMornDose.ClientID %>').prop('disabled', false);
                    $('#<%=txtMidDayDose.ClientID %>').prop('disabled', false);
                    $('#<%=txtEvenDose.ClientID %>').prop('disabled', false);
                    $('#<%=txtNightDose.ClientID %>').prop('disabled', false);
                    $('#<%=txtRxNorm.ClientID %>').prop('disabled', false);
                }
                //Disable Controls
                else  {
                //alert(selectedValue);
                    $('#<%=lstGeneric.ClientID %>').prop('disabled', true);
                    $('#<%=txtDrugAbbre.ClientID %>').prop('disabled', true);
                    $('#<%=btnAddGeneric.ClientID %>').prop('disabled', true);
                    $('#<%=lstStrength.ClientID %>').prop('disabled', true);
                    $('#<%=btnAddDose.ClientID %>').prop('disabled', true);
                    $('#<%=txtMornDose.ClientID %>').prop('disabled', true);
                    $('#<%=txtMidDayDose.ClientID %>').prop('disabled', true);
                    $('#<%=txtEvenDose.ClientID %>').prop('disabled', true);
                    $('#<%=txtNightDose.ClientID %>').prop('disabled', true);
                    $('#<%=txtRxNorm.ClientID %>').prop('disabled', true);
                }
        }

        function OnCountriesPopulated(response) {
            PopulateControl(response.d, $("#<%=ddlItemSubType.ClientID %>"));
        }


        function PopulateControl(list, control) {
            if (list.length > 0) {
                control.removeAttr("disabled");
                control.empty().append('<option selected="selected" value="0">Please select</option>');
                $.each(list, function () {
                    control.append($("<option></option>").val(this['Value']).html(this['Text']));
                });
//                $(control).on('change', function() {
//                alert(this.value);                    
//                    $("#<%=hdsubtype.ClientID%>").val(this.value); //set value                
//                });
            }
            else {
                control.empty().append('<option selected="selected" value="0">Not available<option>');
            }
        }

        
        function chksyrupchange() {        
        $('#<%= chksyrup.ClientID %>').click(function (){
        var ApprovalRequired = $('#<%= chksyrup.ClientID %>').is(':checked');
        //alert(ApprovalRequired);
            if(ApprovalRequired==true){
                $('#<%=ddlVolumeUnit.ClientID %>').prop('disabled', false);
            } 
            else{
                $('#<%=ddlVolumeUnit.ClientID %>').prop('disabled', true);
                }        
        });
        }            


        $(function () {
            //Attach click event of button
            $("#<%=btnAdd.ClientID %>").click(function (e) {
                //Pass the value from Listbox1 to Listbox2
                $("#<%=lstAvailable.ClientID %> > option:selected").each(function () {
                    $(this).remove().appendTo("#<%=lstSelected.ClientID %>");
                });
                e.preventDefault();
            });
            //Attach click event of button
            $("#<%=btnRemove.ClientID %>").click(function (e) {
                //Pass the value from Listbox2 to Listbox1
                $("#<%=lstSelected.ClientID %> > option:selected").each(function () {
                    $(this).remove().appendTo("#<%=lstAvailable.ClientID %>");
                });
                e.preventDefault();
            });
        });
        $(function () {
            $("[id*=btnSubmit]").click(function () {
                var values = "";
                var selected = $("[id*=lstSelected] option");
                selected.each(function () {
                    values += $(this).html() + "-" + $(this).val() + ",";
                });
                $("#<%=hdStrGenID.ClientID%>").val(values);

            });
        });

        function calculateselling()
        {
            //alert(index);
            var DisUnitprice = $("#<%=txtDispUnitPrice.ClientID%>").val();
            var margin = $("#<%=txtDispMargin.ClientID%>").val();
            if(DisUnitprice !='' && margin !='')
            {                     
            var total = parseFloat(DisUnitprice) + parseFloat((margin/100)*DisUnitprice);            
             $("#<%=txtsellingprice.ClientID%>").val(total.toFixed(2));
             }            
        }
        function ItemSubTypeChange(ddlsubtype)
        {
        var value = $("#"+ ddlsubtype +" option:selected").val();
        $("#<%=hdsubtype.ClientID%>").val(value);
        //alert($("#<%=hdsubtype.ClientID%>").val());
                 
        }       
        $(document).ready(function() {
         chksyrupchange();
         $("#<%=ddlItemSubType.ClientID %>").change(function() {
            $("#<%=hdsubtype.ClientID%>").val(this.value);
            //alert($("#<%=hdsubtype.ClientID%>").val());
            });
        });

        function resetPosition(object, args) {
            var tb = object._element;
            var tbposition = findPositionWithScrolling(tb);
            var xposition = tbposition[0] - 200;
            var yposition = tbposition[1] + 14; // 22 textbox height 
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
    <style>
        .AutoExtender
        {
            font-family: Courier New, Arial, sans-serif;
            font-size: 11px;
            font-weight: 100;
            border: solid 1px #006699;
            line-height: 15px;
            padding: 0px;
            background-color: White;
            margin-left: 0px;
            width: 800px;
        }
        .AutoExtenderList
        {
            cursor: pointer;
            color: black;
            z-index: 2147483647 !important;
        }
        .AutoExtenderHighlight
        {
            color: White;
            background-color: #006699;
            cursor: pointer;
        }
        #divwidth
        {
            width: 800px !important;
        }
        #divwidth div
        {
            width: 800px !important;
        }
        #divwidthFooter
        {
            width: 800px !important;
        }
        #divwidthFooter div
        {
            width: 800px !important;
        }
        
        .Background
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
        .Popup
        {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 750px;
            height: 380px;
        }
        .lbl
        {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>
    <div class="container-fluid">
        <div class="border formbg">
            <br />
            <act:TabContainer ID="tabControl" runat="server" ActiveTabIndex="0" Width="100%">
                <act:TabPanel ID="TabPanel3" runat="server" Font-Size="Large" HeaderText="Item Configuration">
                    <ContentTemplate>
                        <table width="100%" class="table-condensed">
                            <tbody>
                                <tr>
                                    <td style="width: 10%; height: 40px" align="right" class="pad5">
                                        <asp:Label ID="Label1" runat="server" Text="Search Item:"></asp:Label>
                                    </td>
                                    <td style="width: 80%; height: 40px" align="center" class="pad5">
                                        <asp:TextBox ID="txtsearchitem" runat="server" Width="100%" Height="20px" AutoComplete="off"
                                            AutoPostBack="True" OnTextChanged="txtautoItemName_TextChanged"></asp:TextBox>
                                        <asp:Panel ID="divwidth" runat="server" ScrollBars="Vertical" Height="200px" />
                                        </div>
                                        <act:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="30"
                                            CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionListItemCssClass="AutoExtenderList"
                                            OnClientShown="resetPosition" BehaviorID="AutoCompleteEx" EnableCaching="False"
                                            MinimumPrefixLength="2" OnClientItemSelected="ace1_itemSelected" ServiceMethod="SearchItems"
                                            TargetControlID="txtsearchitem" CompletionListElementID="divwidth" DelimiterCharacters=""
                                            ServicePath="">
                                        </act:AutoCompleteExtender>
                                    </td>
                                    <td style="width: 10%; height: 40px" align="right" class="pad5">
                                        <asp:Button ID="btnAddNewItem" runat="server" Text="Add New" OnClick="btnAddNewItem_Click"
                                            CssClass="btn btn-primary" Height="30px" Width="107%" Style="text-align: left;
                                            margin-left: 2%;" /><span class="glyphicon glyphicon-plus" style="margin-left: 90%;
                                                vertical-align: middle; color: #fff; margin-top: -25%;"></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="border center formbg">
                            <table class="center formbg table-condensed" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlItemIdentifier" runat="server" CssClass="border center formbg"
                                            Style="padding: 6px">
                                            <h4 class="forms h4" align="left">
                                                <asp:ImageButton ID="imgItemIdentifier" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblItemIdentifier" runat="server" Text="Item Identifier"></asp:Label></h4>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlItemIdentifierDetails" runat="server">
                                            <table width="100%" class="table-condensed">
                                                <tbody>
                                                    <tr>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td style="width: 37%;" align="right">
                                                                        <label class="required">
                                                                            Item type :</label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlItemType" Width="250px" runat="server" AppendDataBoundItems="True"
                                                                            onchange="PopulateContinents(0);">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td style="width: 37%;" align="right" nowrap="nowrap">
                                                                        <label class="right30 required">
                                                                            Item sub-type :</label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlItemSubType" runat="server" Width="250px" DataTextField="Name"
                                                                            DataValueField="Id">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td style="width: 37%;" align="right">
                                                                        <label class="right30">
                                                                            Item Code :</label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtItemCode" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td style="width: 37%;" align="right">
                                                                        <label>
                                                                            RxNorm :</label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtRxNorm" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td style="width: 37%;" align="right">
                                                                        <label class="required">
                                                                            Trade name :</label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtTradeName" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td align="right" style="width: 37%;">
                                                                        <label>
                                                                            Drug abbreviation :</label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtDrugAbbre" ReadOnly="True" runat="server" Width="250px"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td>
                                                                        <label class="right30 required">
                                                                            Generic name :</label>
                                                                        <br />
                                                                        <center>
                                                                            <asp:ListBox ID="lstGeneric" runat="server" Height="100px" Width="300px"></asp:ListBox>
                                                                            <br />
                                                                            <br />
                                                                            <asp:Button ID="btnAddGeneric" runat="server" Text="Add Generic Drug" OnClick="btnAddGeneric_Click1"
                                                                                CssClass="btn btn-primary" Height="30px" Width="35%" Style="text-align: left;
                                                                                margin-left: 2%;" /><span class="glyphicon glyphicon-plus-sign" style="margin-left: -5%;
                                                                                    vertical-align: middle; color: #fff; margin-top: .25%;"></span>
                                                                        </center>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td class="form" style="width: 50%;" align="left">
                                                            <table width="100%" class="table-condensed">
                                                                <tr>
                                                                    <td>
                                                                        <label class="right30 required">
                                                                            Available Strengths :
                                                                        </label>
                                                                        <br />
                                                                        <center>
                                                                            <asp:ListBox ID="lstStrength" runat="server" Height="100px" Width="300px"></asp:ListBox>
                                                                            <br />
                                                                            <br />
                                                                            <asp:Button ID="btnAddDose" runat="server" Text="Add Strengths" OnClick="btnAddDose_Click"
                                                                                CssClass="btn btn-primary" Height="30px" Width="28%" Style="text-align: left;
                                                                                margin-left: 2%;" /><span class="glyphicon glyphicon-plus-sign" style="margin-left: -4%;
                                                                                    vertical-align: middle; color: #fff; margin-top: .25%;"></span>
                                                                        </center>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form" colspan="2" style="width: 100%;" align="left">
                                                            <table width="40%" class="table-condensed">
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <label class="right30">
                                                                            Default Doses :
                                                                        </label>
                                                                        <span class="smallerlabel" id="Span2">These will populate dosing fields on pharmacy
                                                                            dispense</span>
                                                                        <tr>
                                                                            <td style="width: 50px">
                                                                                <img src="../Images/morning1.jpg" alt="morning" width="40px" />
                                                                            </td>
                                                                            <td style="width: 50px">
                                                                                <img src="../Images/midday1.jpg" alt="midday" width="40px" />
                                                                            </td>
                                                                            <td style="width: 50px">
                                                                                <img src="../Images/evening1.jpg" alt="evening" width="40px" />
                                                                            </td>
                                                                            <td style="width: 50px">
                                                                                <img src="../Images/night2.jpg" alt="night" width="40px" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 50px">
                                                                                <asp:TextBox ID="txtMornDose" runat="server" Width="40px" MaxLength="2"></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 50px">
                                                                                <asp:TextBox ID="txtMidDayDose" runat="server" Width="40px" MaxLength="2"></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 50px">
                                                                                <asp:TextBox ID="txtEvenDose" runat="server" Width="40px" MaxLength="2"></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 50px">
                                                                                <asp:TextBox ID="txtNightDose" runat="server" Width="40px" MaxLength="2"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg table-condensed" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlscm" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h4 class="forms h4" align="left">
                                                <asp:ImageButton ID="imgSCM" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblSCM" runat="server" Text="Supply Chain Information"></asp:Label></h4>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:Panel ID="pnlSCMDetails" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td style="width: 37%;" align="right" nowrap="nowrap">
                                                                    <label class="right30">
                                                                        Manufacturer :</label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlmanufaturer" runat="server" Width="250px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td style="width: 37%;" align="right" nowrap="nowrap">
                                                                    <label class="right30">
                                                                        Purchase Unit :</label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlpurchaseunit" runat="server" Width="250px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td style="width: 37%;" align="right" nowrap="nowrap">
                                                                    <label class="right30">
                                                                        Purchase Unit Price :</label>
                                                                </td>
                                                                <td>'
                                                                    <asp:TextBox ID="txtPurUnitPrice" runat="server" Width="215px" style="float:right; margin-right:5%;"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td align="right" style="width: 37%;" nowrap="nowrap">
                                                                    <label>
                                                                        Purchase quantity :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txtpurchaseqty" runat="server" Width="250px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td style="width: 37%;" align="right" nowrap="nowrap">
                                                                    <label class="right30">
                                                                        Syrup/Powder :</label>
                                                                </td>
                                                                <td>
                                                                    <asp:CheckBox ID="chksyrup" runat="server"></asp:CheckBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td align="right" style="width: 37%;">
                                                                    <label>
                                                                        Volume unit :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddlVolumeUnit" runat="server" Width="250px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form" colspan="2" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td align="left" style="width: 100%; padding: 5px">
                                                                    <label>
                                                                        Instructions :</label>
                                                                    <asp:TextBox ID="txtinstructions" runat="server" Width="100%" TextMode="MultiLine"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="center formbg table-condensed" width="100%">
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="PnlPricing" runat="server" CssClass="border center formbg" Style="padding: 6px">
                                            <h4 class="forms h4" align="left">
                                                <asp:ImageButton ID="imgPricing" ImageUrl="~/images/arrow-up.gif" runat="server" />
                                                <asp:Label ID="lblPricing" runat="server" Text="Pricing"></asp:Label></h4>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="98%">
                                        <asp:Panel ID="PnlPricingDetails" runat="server">
                                            <table width="99.8%" class="table-condensed">
                                                <tr align="right">
                                                    <td align="right" colspan="2" width="2%">
                                                        <asp:LinkButton ID="btnbatchsummary" Visible="False" Text="Batch Summary" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td style="width: 37%;" align="right">
                                                                    <label>
                                                                        Dispensing Unit :</label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddldispensingunit" runat="server" Width="250px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td style="width: 37%;" align="right">
                                                                    <label>
                                                                        Dispensing Unit Price :</label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtDispUnitPrice" runat="server" Width="250px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td align="right" style="width: 37%;">
                                                                    <label>
                                                                        Dispensing Margin % :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txtDispMargin" runat="server" Width="250px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="form" style="width: 50%;" align="left">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td align="right" style="width: 37%;">
                                                                    <label>
                                                                        Selling Price :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txtsellingprice" runat="server" Width="250px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form" style="width: 100%;" colspan="2" align="center">
                                                        <table width="100%" class="table-condensed">
                                                            <tr>
                                                                <td align="right" style="width: 50%;">
                                                                    <label>
                                                                        Effective Date :</label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txtEffectiveDate" runat="server" onblur="DateFormat(this,this.value,event,false,'3')"
                                                                        onkeyup="DateFormat(this,this.value,event,false,'3')" onfocus="javascript:vDateType='3'"
                                                                        MaxLength="11" size="11" name="txteffectiveDt"></asp:TextBox>
                                                                    <img id="appDateimg2" onclick="w_displayDatePicker('ctl00_IQCareContentPlaceHolder_tabControl_TabPanel3_txtEffectiveDate');"
                                                                        height="22" alt="Date Helper" hspace="2" src="../images/cal_icon.gif" width="22"
                                                                        border="0" name="appDateimg" style="vertical-align: text-bottom;" />
                                                                    <span class="smallerlabel" id="Span3">(DD-MMM-YYYY)</span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:Button ID="dummyButton" runat="server" Style="display: none;" />
                        <act:CollapsiblePanelExtender ID="CPENigeriaMedical" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlItemIdentifierDetails"
                            CollapseControlID="pnlItemIdentifier" ExpandControlID="pnlItemIdentifier" CollapsedImage="~/images/arrow-up.gif"
                            Collapsed="True" ImageControlID="imgItemIdentifier" BehaviorID="_content_CPENigeriaMedical">
                        </act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPESCM" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="pnlSCMDetails" CollapseControlID="pnlSCM"
                            ExpandControlID="pnlSCM" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgSCM" BehaviorID="_content_CPESCM"></act:CollapsiblePanelExtender>
                        <act:CollapsiblePanelExtender ID="CPEPricing" runat="server" SuppressPostBack="True"
                            ExpandedImage="~/images/arrow-dn.gif" TargetControlID="PnlPricingDetails" CollapseControlID="PnlPricing"
                            ExpandControlID="PnlPricing" CollapsedImage="~/images/arrow-up.gif" Collapsed="True"
                            ImageControlID="imgPricing" BehaviorID="_content_CPEPricing"></act:CollapsiblePanelExtender>
                        <act:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="dummyButton"
                            CancelControlID="btnPendingOrdersClose" BackgroundCssClass="Background" BehaviorID="_content_mp1"
                            DynamicServicePath="">
                        </act:ModalPopupExtender>
                        <act:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="pnlbatchsummary"
                            TargetControlID="btnbatchsummary" CancelControlID="imgbatchclose" BackgroundCssClass="Background"
                            BehaviorID="_content_ModalPopupExtender1" DynamicServicePath="">
                        </act:ModalPopupExtender>
                        <asp:Table ID="Panl1" runat="server" Width="550px" Height="300px" BackColor="White">
                            <asp:TableRow runat="server">
                                <asp:TableCell Height="20px" CssClass="formbg" runat="server">
                                    <asp:Table ID="Table11" runat="server" Width="100%">
                                        <asp:TableRow runat="server">
                                            <asp:TableCell HorizontalAlign="Left" VerticalAlign="Middle" ForeColor="Navy" Font-Bold="True"
                                                runat="server">
                                                <asp:Label ID="lblGenStrPopup" class="forms" runat="server"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Right" VerticalAlign="Middle" runat="server">
                                                <asp:ImageButton ID="btnPendingOrdersClose" runat="server" ImageUrl="~/Images/closeButton1.png"
                                                    Height="20px" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableCell Height="100%" runat="server">
                                    <table width="100%" class="table-condensed">
                                        <tbody>
                                            <tr>
                                                <td class="border formbg">
                                                    <asp:ListBox ID="lstAvailable" runat="server" Height="180px" Width="210px"></asp:ListBox>
                                                </td>
                                                <td>
                                                    <div>
                                                        <asp:Button ID="btnAdd" runat="server" Width="80px" Text="Add >>" OnClick="btnAdd_Click" />
                                                    </div>
                                                    <br />
                                                    <div>
                                                        <asp:Button ID="btnRemove" runat="server" Width="80px" Text="<< Remove" OnClick="btnRemove_Click" />
                                                    </div>
                                                </td>
                                                <td class="border formbg">
                                                    <asp:ListBox ID="lstSelected" runat="server" Height="180px" Width="210px"></asp:ListBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br />
                                    <div class="border center" align="center" style="width: 600px">
                                        <asp:Button ID="btnSubmit" runat="server" Width="80px" Text="Submit" OnClick="btnSubmit_Click" />
                                    </div>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <asp:Table ID="pnlbatchsummary" runat="server" Width="700px" Height="200px" BackColor="White"
                            Style="display: none">
                            <asp:TableRow runat="server">
                                <asp:TableCell Height="20px" CssClass="formbg" runat="server">
                                    <asp:Table ID="pnltable" runat="server" Width="100%" class="table-condensed">
                                        <asp:TableRow runat="server">
                                            <asp:TableCell HorizontalAlign="Left" VerticalAlign="Middle" ForeColor="Navy" Font-Bold="True"
                                                runat="server">
                                                <asp:Label ID="lblbatchs" class="forms" runat="server" Text="Batch Summary"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Right" VerticalAlign="Middle" runat="server">
                                                <asp:ImageButton ID="imgbatchclose" runat="server" ImageUrl="~/Images/closeButton1.png"
                                                    Height="20px" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableCell Height="100%" runat="server">
                                    <div class="grid" id="div2" style="width: 100%;">
                                        <div class="rounded">
                                            <div class="mid-outer">
                                                <div class="mid-inner">
                                                    <div class="mid" style="height: 400px; overflow: auto">
                                                        <div id="div3" class="GridView whitebg">
                                                            <asp:GridView ID="gridItemBatchList" CssClass="datatable" CellPadding="0" runat="server"
                                                                AutoGenerateColumns="False" PageSize="1" BorderWidth="1px" DataKeyNames="BatchID,BatchName"
                                                                EmptyDataText="No Data to display" Width="100%" ShowHeaderWhenEmpty="True">
                                                                <Columns>
                                                                    <asp:BoundField DataField="BatchID" Visible="False"></asp:BoundField>
                                                                    <asp:BoundField DataField="BatchName" HeaderText="Batch Name" SortExpression="BatchName">
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle CssClass="textstyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" SortExpression="ExpiryDate"
                                                                        DataFormatString="{0:dd-MMM-yyyy}">
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle CssClass="textstyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="AvailableQty" HeaderText="Available Quantity" SortExpression="AvailableQty">
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle CssClass="textstyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CustomPurchasePrice" HeaderText="Custom Purchase Price"
                                                                        SortExpression="CustomPurchasePrice">
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle CssClass="textstyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CustomMargin" HeaderText="Custom Margin %" SortExpression="CustomMargin">
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle CssClass="textstyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="SellingPrice" HeaderText="Selling Price" SortExpression="SellingPrice">
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle CssClass="textstyle" />
                                                                    </asp:BoundField>
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
                    </ContentTemplate>
                </act:TabPanel>
                <act:TabPanel ID="TabPanel1" runat="server" Font-Size="Large" HeaderText="Goods & Services Bundles">
                    <ContentTemplate>
                    </ContentTemplate>
                </act:TabPanel>
                <act:TabPanel ID="TabPanel2" runat="server" Font-Size="Large" HeaderText="Price List">
                    <ContentTemplate>
                    </ContentTemplate>
                </act:TabPanel>
            </act:TabContainer>
        </div>
        <br />
        <table class="formbg center border pad5 table-condensed" width="100%">
            <tbody>
                <tr>
                    <td class="form pad5">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-primary"
                            Height="30px" Width="8%" Style="text-align: left; margin-left: 2%;" /><span class="glyphicon glyphicon-floppy-disk"
                                style="margin-left: -2%; vertical-align: middle; color: #fff; margin-top: .25%;"></span>
                        <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn btn-primary"
                            Height="30px" Width="8%" Style="text-align: left; margin-left: 2%;" /><span class="glyphicon glyphicon-remove"
                                style="margin-left: -2%; vertical-align: middle; color: #fff; margin-top: .25%;"></span>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <asp:HiddenField ID="hdCustID" runat="server" />
    <asp:HiddenField ID="hdFlag" runat="server" />
    <asp:HiddenField ID="hdsubtype" runat="server" />
    <asp:HiddenField ID="hdStrGenID" runat="server" />
</asp:Content>
