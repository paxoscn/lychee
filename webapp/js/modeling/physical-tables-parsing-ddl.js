var tables = null
var tableIndex = 0

window.addEventListener("load", function() {
    $("content").parentNode.style.width = "1800px"
})

function confirmAndGenerateLogicalTables() {
    ajax('POST', '/api/modeling/parse-ddl-and-init-logical-tables', { "ddl": $("ddl").value }, function(res) {
        tables = res.tables
        tableIndex = 0
        if (tables.length < 1) {
            $("tables").style.display = "none"
            return
        }
        $("table_count").innerHTML = tables.length + ""
        $("tables").style.display = "table-row"
        renderTable()
    })
}

function renderTable() {
    if (tableIndex > 0) {
        $("left_table").style.display = "inline"
        $("left_table").innerHTML = "《 " + tables[tableIndex - 1].name
    } else {
        $("left_table").style.display = "none"
    }
    if (tableIndex < tables.length - 1) {
        $("right_table").style.display = "inline"
        $("right_table").innerHTML = tables[tableIndex + 1].name + " 》"
    } else {
        $("right_table").style.display = "none"
    }
    $("query").value = tables[tableIndex].query
    loadPart($('logical_table'), '/modeling/logical-table.part.htm', tables[tableIndex])
}

function saveTables() {
    if ($("data_source_id").value.length < 1) {
        alert("请选择数据源")
        return
    }
    saveLogicalTables({ "tables": tables, "data_source_id": $("data_source_id").value })
}
