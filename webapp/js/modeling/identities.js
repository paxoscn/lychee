function showIdentityDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/identity.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/identities', {}, function(res) {
        res.forEach(function(item) {
            tr($("identity-table"), item, [ item.name, item.cn_name, item.remarks, item.creator_id, item.created_on, "<button onclick='showIdentityDetail(event)'>详情</button>" ])
        })
    })
})
