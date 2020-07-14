function showDimensionDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/dimension.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/dimensions', {}, function(res) {
        res.forEach(function(item) {
            tr($("dimension-table"), item, [ item.name, item.cn_name, item.identity_id > 0 ? "" : "无", item.data_type, item.desensitization_method, item.creator_id > 0 ? "admin" : "", item.created_on, "<button onclick='showDimensionDetail(event)'>详情</button>" ])
        })
    })
})
