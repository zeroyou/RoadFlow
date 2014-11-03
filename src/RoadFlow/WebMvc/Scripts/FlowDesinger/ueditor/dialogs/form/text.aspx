﻿<%@ Page Language="C#" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="../internal.js"></script>
    <script type="text/javascript" src="../common.js"></script>
    <%=WebMvc.Common.Tools.IncludeFiles %>
</head>
<body>
<% 
    WebMvc.Common.Tools.CheckLogin();
    Business.Platform.WorkFlowForm workFlowFrom = new Business.Platform.WorkFlowForm(); 
%>
<br />
<table cellpadding="0" cellspacing="1" border="0" width="95%" class="formtable">
    <tr>
        <th style="width:80px;">绑定字段:</th>
        <td><select class="myselect" id="bindfiled" style="width:227px"></select></td>
    </tr>
    <tr>
        <th>默认值:</th>
        <td><select class="myselect" id="defaultvalue" style="width:227px"><%=workFlowFrom.GetDefaultValueSelect("") %></select></td>
    </tr>
    <tr>
        <th>宽度:</th>
        <td><input type="text" id="width" class="mytext" style="width:150px" /></td>
    </tr>
    <tr>
        <th>最大字符数:</th>
        <td><input type="text" id="maxlength" class="mytext" style="width:150px" /></td>
    </tr>
    <tr>
        <th>输入类型:</th>
        <td><%=workFlowFrom.GetInputTypeRadios("inputtype","","") %></td>
    </tr>
    <tr>
        <th>值类型:</th>
        <td><select class="myselect" id="valuetype" ><%=workFlowFrom.GetValueTypeOptions("") %></select></td>
    </tr>
    <!--
    <tr>
        <th>字符范围:</th>
        <td><input type="text" id="charrange" class="mytext" style="width:272px" /></td>
    </tr>
    <tr>
        <th>非法字符:</th>
        <td><input type="text" id="charillegal" class="mytext" style="width:272px" /></td>
    </tr>
    -->
</table>
<script type="text/javascript">
    var text = getElement(editor, "flow_text", "formtextDialog");
    var attJSON = parent.formattributeJSON;
    var textid = text ? text.id : "";
    $(function ()
    {
        biddingFileds(attJSON, textid, $("#bindfiled"));
        if (text)
        {
            $text = $(text);
            $("#defaultvalue").val($text.attr('defaultvalue'));
            if ($text.attr('width1')) $("#width").val($text.attr('width1'));
            $("input[name='inputtype'][value='" + $text.attr('type') + "']").prop('checked', true);
            $("#maxlength").val($text.attr('maxlength'));
            //$("#charrange").val($text.attr('charrange'));
            //$("#charillegal").val($text.attr('charillegal'));
            $("#valuetype").val($text.attr('valuetype'));
        }
    });
    dialog.onok = function ()
    {
        var bindfiled = $("#bindfiled").val();
        var id = attJSON.dbconn && attJSON.dbtable && bindfiled ? attJSON.dbtable + '.' + bindfiled : "";
        var width = $("#width").val();
        var defaultvalue = $("#defaultvalue").val();
        var maxlength = $("#maxlength").val();
        var inputtype = $(":checked[name='inputtype']").val();
        var valuetype = $("#valuetype").val();
        var charrange = "";// $("#charrange").val();
        var charillegal = "";// $("#charillegal").val();

        var html = '<input ondblclick="if(editor.ui._dialogs.formtextDialog.iframeUrl.indexOf(\'?\')==-1){editor.ui._dialogs.formtextDialog.iframeUrl=editor.ui._dialogs.formtextDialog.iframeUrl+\'?edit=1\';}editor.ui._dialogs.formtextDialog.open();" title="双击可设置属性" type="' + (inputtype || 'text') + '" id="' + id + '" type1="flow_text" name="' + id + '" value="文本框" ';
        if (width)
        {
            html += 'style="width:' + width + '" ';
            html += 'width1="' + width + '" ';
        }
        html += 'defaultvalue="'+defaultvalue+'" ';
        if (parseInt(maxlength) > 0)
        {
            html += 'maxlength="' + maxlength + '" ';
        }
        if (valuetype)
        {
            html += 'valuetype="' + valuetype + '" ';
        }
        if (charrange)
        {
            html += 'charrange="' + charrange + '" ';
        }
        if (charillegal)
        {
            html += 'charillegal="' + charillegal + '" ';
        }

        html += '/>';
        if (text)
        {
            $(text).remove();
        }
        editor.execCommand("formtext", html);
        dialog.close();
    }
</script>
</body>
</html>