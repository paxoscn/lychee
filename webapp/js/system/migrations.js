function showMigrationDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/system/migration.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/system/migrations', {}, function(res) {
        res.forEach(function(item) {
            tr($("migration-table"), item, [ item.is_exporting == 1 ? "导出" : "导入", item.creator_id, item.created_on, "<button onclick='showMigrationDetail(event)'>详情</button>" ])
        })
    })
})
