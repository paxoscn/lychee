function showDataSourceDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/system/data-source.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/system/data-sources', {}, function(res) {
        res.forEach(function(item) {
            tr($("data-source-table"), item, [ item.driver, item.name, item.cn_name, item.creator_id > 0 ? "admin" : "", item.created_on, "<button onclick='showDataSourceDetail(event)'>详情</button>" ])
        })
    })
})
