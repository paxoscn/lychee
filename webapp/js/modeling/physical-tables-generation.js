window.addEventListener("load", function() {
})

function selectLogicalTables() {
    ajax('POST', '/api/modeling/logical-tables', { "layer": "", "role": "" }, function(res) {
        showItemSelector($("logical_table_selecting_button"), $("logical_table_selector"), true, res, function(item) {
            return cols(item)
        }, function(item) {
            var cols_ = cols(item)
            cols_.push("<button onclick='removeLogicalTable(event)'>移除</button>")
            tr($("logical-table-table"), item, cols_)
        })
    })
}

function cols(item) {
    return [ item.layer, item.name, item.cn_name, item.remarks, item.has_oneid, item.is_fact == 1 ? "事实表" : "维度表" ]
}
