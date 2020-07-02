function showDimensionDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/dimension.htm?id=" + el.obj.Id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/dimensions', {}, function(res) {
        res.forEach(function(item) {
            tr($("dimension-table"), item, [ item.name, item.cn_name, item.remarks, item.identity_id, item.data_type, item.desensitization_method, item.creator_id, item.created_on, "<button onclick='showDimensionDetail(event)'>详情</button>" ])
        })  
    })  
})
