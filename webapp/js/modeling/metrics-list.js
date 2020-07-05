function showMetricsDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/metrics.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/metrics-list', {}, function(res) {
        res.forEach(function(item) {
            tr($("metrics-table"), item, [ item.name, item.cn_name, item.remarks, item.creator_id, item.created_on, "<button onclick='showMetricsDetail(event)'>详情</button>" ])
        })
    })
})
