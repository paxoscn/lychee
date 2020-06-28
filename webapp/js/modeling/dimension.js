var dimension = null

window.addEventListener("load", function() {
    ajax('GET', '/api/modeling/dimension' + (location.href.indexOf("?") > -1 ? location.href.substring(location.href.indexOf("?")) : ""), null, function(item) {
        dimension = item
        $("id").value = dimension.Id
        $("name").value = dimension.Name
        $("type_" + dimension.Type).checked = true
        onTypeChanged()
        dimension.EnumValues.forEach(function(enumValue) {
            tr($("enum_values").getElementsByTagName("table")[0], enumValue, [ "<input value='" + enumValue.Value + "' />", "<input value='" + enumValue.Name + "' />", "<button onclick='removeEnumValue(event);'>移除</button>" ])
        })
        document.querySelectorAll('input[name="type"]').forEach(function(item) {
            item.onchange = onTypeChanged
        })
    })
})

function onTypeChanged() {
    if (document.querySelector('input[name="type"]:checked').value == "table") {
        $("table_id").value = dimension.TableId
        $("table_name").innerHTML = dimension.TableName
        $("table_selecting_button").disabled = false
        $("enum_values").style.display = "none"
    } else {
        $("table_id").value = "0"
        $("table_name").innerHTML = ""
        $("table_selecting_button").disabled = true
        $("enum_values").style.display = "block"
    }
}

function selectDimensionTable() {
    ajax('GET', '/api/modeling/dimension-tables', null, function(item) {
        showTableSelector($("table_selecting_button"), item, function(table) {
            $("table_id").value = dimension.TableId = table.Id
            $("table_name").innerHTML = dimension.TableName = table.Name
        })
    })
}

function addEnumValue() {
    tr($("enum_values").getElementsByTagName("table")[0], { "Value": "", "Name": "" }, [ "<input />", "<input />", "<button onclick='removeEnumValue(event);'>移除</button>" ])
}

function removeEnumValue(e) {
    var el = e.target
    while (el.nodeName != "TR") {
        el = el.parentNode
    }

    el.parentNode.removeChild(el)
}
