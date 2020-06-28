function showDimensionDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/dimension.htm?id=" + el.obj.Id
}

window.addEventListener("load", function() {
    ajax('GET', '/api/modeling/dimensions', null, function(res) {
        res.forEach(function(item) {
            tr($("dimension-table"), item, [ item.Name, item.CnName, item.Type, item.CreatorId, item.CreatedOn, "<button onclick='showDimensionDetail(event)'>详情</button>" ])
        })  
    })  
})
