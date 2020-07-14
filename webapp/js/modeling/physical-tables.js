function showPhysicalTableDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/physical-table.htm?id=" + el.obj.id
}

function generatePhysicalTables() {
    location = "/modeling/physical-tables-generation.htm"
}

function parsePhysicalTables() {
    location = "/modeling/physical-tables-parsing-ddl.htm"
}

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/physical-tables', {}, function(res) {
        res.forEach(function(item) {
            tr($("physical-table-table"), item, [ item.logical_table_name, item.data_source_name, item.name, item.creator_id > 0 ? "admin" : "", item.created_on, "<button onclick='showPhysicalTableDetail(event)'>详情</button>" ])
        })
    })
})
