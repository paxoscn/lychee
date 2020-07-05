function showLogicalTableDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/modeling/logical-table.htm?id=" + el.obj.id
}

var layer = "";
var role = "";

function queryList() {
    ajax('POST', '/api/modeling/logical-tables', { "layer": layer, "role": role }, function(res) {
        tclean($("logical-table-table"));
        res.forEach(function(item) {
            tr($("logical-table-table"), item, [ item.layer, item.name, item.cn_name, item.remarks, item.has_oneid, item.is_fact == 1 ? "事实表" : "维度表", item.creator_id, item.created_on, "<button onclick='showLogicalTableDetail(event)'>详情</button>" ])
        })
    })
}

window.addEventListener("load", function() {
    for (var i = 0, radios = document.querySelectorAll("input[type=radio]"); i < radios.length; ++i) {
        radios[i].onchange = function(e) {
            if (e.target.checked) {
                eval(e.target.name + " = '" + e.target.value + "'");
                queryList();
            }
        };
    }

    queryList();
})
